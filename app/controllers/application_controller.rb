class ApplicationController < ActionController::API
    
    rescue_from StandardError, with: :unhandled_error
    rescue_from ActionController::InvalidAuthenticityToken,
        with: :invalid_authenticity_token
    include ActionController::RequestForgeryProtection
  
    protect_from_forgery with: :exception

    before_action :snake_case_params, :attach_authenticity_token

    def attach_authenticity_token
        headers['X-CSRF-Token'] = masked_authenticity_token(session)
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
        @current_user = user
        persist_cart
    end

    def persist_cart
        if session[:cart]
            guest_cart = Cart.find(session[:cart])
            if current_user.cart == nil
                new_cart = Cart.create!(user_id: current_user.id)
            else
                new_cart = current_user.cart
            end
            guest_cart.cart_items.each {|item| CartItem.create(
                cart_id: new_cart.id,
                product_id: item.product_id,
                quantity: item.quantity
            )}
            cart_items = CartItem.all
            cart_items.each {|item| item.delete if item.cart.user_id == nil}
            guest_cart.destroy
            session[:cart] = nil
        end
    end

    def logout!
        current_user.reset_session_token!
        session[:session_token] = nil
        @current_user = nil
    end

    def logged_in?
        !!current_user
    end

    def require_logged_in
        unless current_user
            render json: {message: 'you shall not pass'}, status: :unauthorized
        end 
    end

    private

    def snake_case_params
        params.deep_transform_keys!(&:underscore)
    end

    def invalid_authenticity_token
        render json: { message: 'Invalid authenticity token' }, 
          status: :unprocessable_entity
      end
      
    def unhandled_error(error)
        if request.accepts.first.html?
            raise error
        else
            @message = "#{error.class} - #{error.message}"
            @stack = Rails::BacktraceCleaner.new.clean(error.backtrace)
            render 'api/errors/internal_server_error', status: :internal_server_error
            
            logger.error "\n#{@message}:\n\t#{@stack.join("\n\t")}\n"
        end
    end
end

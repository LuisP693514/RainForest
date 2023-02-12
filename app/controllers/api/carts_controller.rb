class Api::CartsController < ApplicationController

    def show
        if current_user
            @cart_items = current_user.cart.cart_items.includes(:product_id)
            render 'api/cart_items/index'
        else
            @cart_items = retrieve_cart_items_from_session
            render 'api/cart_items/index'
        end
    end

    def update
        if current_user
            if current_user.cart_items&.update(cart_params)
                @cart_items = current_user.cart_items
                render 'api/cart_items/index'
            else
                render json: {errors: ["Could not update cart"]}
            end
        else
            @cart_items = retrieve_cart_items_from_session
            if @cart_items.update
                render 'api/cart_items/index'
            else
                render json: {errors: ["Could not update cart"]}
            end
        end
    end

    def create
        if current_user
            @cart_item = CartItem.create(cart_params)
            @cart_items = current_user.cart_items    
            @cart_items << @cart_item
            
            render 'api/cart_items/index'
        else
            @cart_items = retrieve_cart_items_from_session
            @cart_item = CartItem.create(cart_params)
            @cart_items << @cart_item

            render 'api/cart_items/index'
        end
    end

    def destroy
        if current_user
            @cart_items = current_user.cart_items

            if @cart_items&.delete(cart_params)
                render 'api/cart_items/index'
            else
                render json: {errors: ["Could not delete cart item"]}
            end
        else
            @cart_items = retrieve_cart_items_from_session
            if @cart_items&.delete(cart_params)
                render 'api/cart_items/index'
            else
                render json: {errors: ['Could not delete cart item']}
            end
        end
    end

    private

    def retrieve_cart_items_from_session
        cart = Cart.find_or_initialize_by(session: cart_params[:session])
        if cart&.cart_items
            cart.cart_items
        else
            render json: {errors: ["Could not find cart"]}
        end
    end

    def cart_params
        params.require(:cart).permit(:id, :product_id, :quantity, :user_id)
    end
end

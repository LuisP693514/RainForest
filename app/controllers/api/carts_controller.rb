class Api::CartsController < ApplicationController

    def show
        if current_user&.cart
            @cart = current_user.cart
            render 'api/cart/show'
        else
            if session[:cart]
                @cart = Cart.find(session[:cart])
                render 'api/cart/show'
            else
                @cart = Cart.create!
                session[:cart] = @cart.id
                render 'api/cart/show'
            end
        end
    end
end

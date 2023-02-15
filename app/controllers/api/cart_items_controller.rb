class Api::CartItemsController < ApplicationController
   def index
        if current_user
            @cart_items = current_user.cart.cart_items
            render 'api/cart_items/index'
        else
            if session[:cart]
                cart = Cart.find(session[:cart])
                @cart_items = cart.cart_items
                render 'api/cart_items/index'
            else
                @cart_items = []
                render 'api/cart_items/index'
            end
        end
   end

   def create
        @cart_item = CartItem.new(cart_item_params)

        if @cart_item.save
            render 'api/cart_items/show'
        else
            render json: {errors: ['Could not create cart item']}
        end

   end

   def destroy
        @cart_item = CartItem.find_by(id: params[:id])

        if @cart_item&.delete
            render json: "Successfully deleted the cart item"
        else
            render json: "Failed to delete the cart item"
        end
   end

   def update
        @cart_item = CartItem.find_by(id: params[:id])

        if @cart_item&.update(cart_item_params)
            render 'api/cart_items/show'
        else
            render json: "Failed to update item"
        end
   end

   private

   def cart_item_params
        params.require(:cart_item).permit(:id, :cart_id, :product_id, :quantity)
   end
end

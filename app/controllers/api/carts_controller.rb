class Api::CartsController < ApplicationController

    def show

    end

    def create
    end

    def update
    end

    def destroy
    end

    private

    def cart_params
        params.require(:cart).permit(:product_id)
    end
end

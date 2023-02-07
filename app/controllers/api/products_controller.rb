class Api::ProductsController < ApplicationController
    def show
        @product = Product.find_by(id: params[:id])

        if @product
            render 'api/products/show'
        else
            render json: {}
        end
    end

    def index
        @products = Product.all

        render 'api/products/index'
    end

end

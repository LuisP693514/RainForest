class Api::CategoriesController < ApplicationController
    def show
        @category = Category.find_by(id: params[:id])

        if @category
            render 'api/categories/show'
        else
            render json: {}
        end
    end

    def index

        @categories = Category.all

        render 'api/categories/index'
    end
end

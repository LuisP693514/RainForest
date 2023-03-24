class Api::ReviewsController < ApplicationController

    def user_reviews_index
        @reviews = User.find_by(id: params[:user_id])&.reviews

        if @reviews
            render 'api/reviews/index'
        else
            render json: {errors: 'Could not find reviews for user'}
        end
    end

    def product_reviews_index
        @reviews = Product.find_by(id: params[:product_id])&.reviews

        if @reviews
            render 'api/reviews/index'
        else
            render json: {errors: 'Could not find reviews for product'}, status: 404
        end
    end

    def update
        @review = Review.find_by(id: params[:id])

        if @review&.update(review_params)
            render 'api/reviews/show'
        else
            render json: {errors: 'failed to update review'}
        end
    end

    def destroy
        @review = Review.find_by(id: params[:id])

        if @review&.destroy
            render json: {message: "Successfully deleted the review"}
        else
            render json: {message: "Failed to delete the review"}
        end
    end

    def create 
        @review = Review.new(review_params)

        if @review.save
            render 'api/reviews/show'
        else
            render json: {errors: [@review.errors]}
        end
    end

    private

    def review_params
        params.require(:review).permit(:body, :score, :user_id, :product_id)
    end

end

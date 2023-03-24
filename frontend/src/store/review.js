// Constants

import csrfFetch from "./csrf"

const RECEIVE_REVIEWS = 'RECEIVE_REVIEWS'
const RECEIVE_REVIEW = 'RECEIVE_REVIEW'
const REMOVE_REVIEW = 'REMOVE_REVIEW'
const REMOVE_ALL = 'REMOVE_ALL'

// Actions

const receiveReview = review => ({
    type: RECEIVE_REVIEW,
    review
})

const receiveReviews = reviews => ({
    type: RECEIVE_REVIEWS,
    reviews
})

const removeReview = reviewId => ({
    type: REMOVE_REVIEW,
    reviewId
})

export const removeAllReviews = () => ({
    type: REMOVE_ALL
})

// selectors

export const getReviews = state => {
    return state?.reviews ? Object.values(state.reviews) : [];
}

export const getReview = reviewId => state => {
    return state?.reviews ? state.reviews[reviewId] : null;
}

// thunk methods
/**
 * fetchReview(reviewId) -> one review
 * fetchUserReviews(userId) -> all reviews 1 user has created
 * fetchProductReviews(productId) -> all reviews 1 product has
 * deleteReview(reviewId) -> deletes a review from existance
 * updateReview(review) -> updates a review
 * createReview(review) -> creates a new review
 */

export const fetchUserReviews = userId => async dispatch => {

    // generate the response

    const res = await csrfFetch(`/api/reviews/user/${userId}`)

    // create reviews
    if (res.ok) {
        const reviews = await res.json();
        dispatch(receiveReviews(reviews));
    }
}

export const fetchProductReviews = productId => async dispatch => {
    
    const res = await csrfFetch(`/api/reviews/product/${productId}`)

    if (res.ok) {
        const reviews = await res.json();
        dispatch(receiveReviews(reviews));
    }
}

export const fetchReview = reviewId => async dispatch => {
    const res = await csrfFetch(`/api/reviews/${reviewId}`)

    if (res.ok) {
        const review = await res.json();
        dispatch(receiveReview(review));
    }
}

export const deleteReview = reviewId => async dispatch => {
    const res = await csrfFetch(`/api/reviews/${reviewId}`, {
        method: 'DELETE'
    })

    if (res.ok) {
        dispatch(removeReview(reviewId))
    }
}

export const updateReview = review => async dispatch => {
    const res = await csrfFetch(`/api/reviews/${review.id}`, {
        method: 'PATCH',
        body: JSON.stringify({review: review})
    })

    if (res.ok) {
        const review = await res.json();
        dispatch(receiveReview(review))
    }
}

export const createReview = review => async dispatch => {
    const res = await csrfFetch(`/api/reviews/`, {
        method: 'POST',
        body: JSON.stringify({review: review})
    })

    if (res.ok) {
        const review = await res.json();
        dispatch(receiveReview(review))
    }
}

// reducer

const reviewsReducer = (state = {}, action) => {
    Object.freeze(state)

    const newState = {...state}

    switch (action.type) {
        case RECEIVE_REVIEW:
            newState[action.review.id] = action.review;
            return newState;
        case RECEIVE_REVIEWS:
            return {...newState, ...action.reviews};
        case REMOVE_REVIEW:
            delete newState[action.reviewId]
            return newState;
        case REMOVE_ALL:
            return {};
        default:
            return state;
    }
}

export default reviewsReducer;
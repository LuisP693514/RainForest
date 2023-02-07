// Constants

import csrfFetch from "./csrf"

export const RECEIVE_CATEGORY = 'RECIEVE_CATEGORY'
export const RECEIVE_CATEGORIES = 'RECIEVE_CATEGORIES'

// action creator

const receiveCategory = (category) => ({
    type: RECEIVE_CATEGORY,
    category
})

const receiveCategories = categories => ({
    type: RECEIVE_CATEGORIES,
    categories
})

// selectors

export const getCategory = categoryId => state => {
    return state?.categories ? state.categories[categoryId] : null
}

export const getCategories = state => {
    return state?.categories ? Object.values(state.categories) : []
}

// thunk actions

/*

    fetchCategories()
    fetchCategory(category)

*/

export const fetchCategories = () => async dispatch =>{
    const res = await csrfFetch(`/api/categories`)

    if (res.ok) {
        const categories = await res.json()
        dispatch(receiveCategories(categories))
    }
}

export const fetchCategory = (categoryId) => async dispatch => {
    const res = await csrfFetch(`/api/categories/${categoryId}`)

    if (res.ok) {
        const category = await res.json()
        dispatch(receiveCategory(category))
    }
}

// reducer

const categoriesReducer = (state = {}, action)=>{
    Object.freeze(state)
    const nextState = {...state}

    switch (action.type) {
        case RECEIVE_CATEGORIES:
            return {...nextState, ...action.categories}
        case RECEIVE_CATEGORY:
            if (action.category.id) nextState[action.category.id] = action.category;
            return nextState;
        default:
            return state;
    }
}

export default categoriesReducer;
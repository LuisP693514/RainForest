// actions

import csrfFetch from "./csrf"

const RECEIVE_CART_ITEMS = 'RECEIVE_CART_ITEMS'
const RECEIVE_CART_ITEM = 'RECEIVE_CART_ITEM'

const receiveCartItem = (cartItem) =>({
    type: RECEIVE_CART_ITEM,
    cartItem
})

const receiveCartItems = (cartItems) => ({
    type: RECEIVE_CART_ITEMS,
    cartItems
})


// selectors

export const getCartItem = (cartItemId) => state => {
    return state?.cartItems ? state.cartItems[cartItemId] : null
}

export const getCartItems = state => {
    return state?.cartItems ? Object.values(state.cartItems) : []
}

//thunk action

export const fetchCartItems = () => async dispatch => {
    const res = await csrfFetch(`/api/cart_items`)

    if (res.ok) {
        const cart = await res.json()
        dispatch(receiveCartItems(cart))
    }
}

export const updateCartItem = (cartItem) => async dispatch => {

}

// reducer

const initialState = {}

export const cartItemsReducer = (state = initialState, action) => {
    Object.freeze(state);
    const nextState = {...state}

    switch (action.type) {
        case RECEIVE_CART_ITEMS:
            
            return {...nextState, ...action.cartItems};
        default:
            return state;
    }
}
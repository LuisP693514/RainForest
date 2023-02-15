// actions

import csrfFetch from "./csrf"

const RECEIVE_CART_ITEMS = 'RECEIVE_CART_ITEMS'
const RECEIVE_CART_ITEM = 'RECEIVE_CART_ITEM'
const REMOVE_CART_ITEM = 'REMOVE_CART_ITEM'

const receiveCartItem = (cartItem) => ({
    type: RECEIVE_CART_ITEM,
    cartItem
})

const receiveCartItems = (cartItems) => ({
    type: RECEIVE_CART_ITEMS,
    cartItems
})

const removeCartItem = (cartItemId) => ({
    type: REMOVE_CART_ITEM,
    cartItemId
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
    const res = await csrfFetch(`/api/cart_items/${cartItem.id}`, {
        method: 'PATCH',
        body: JSON.stringify(cartItem)
    })

    if (res.ok) {
        const newCartItem = await res.json();
        dispatch(receiveCartItem(newCartItem))
    }
}

export const deleteCartItem = (cartItemId) => async dispatch => {
    const res = await csrfFetch(`/api/cart_items/${cartItemId}`,{
        method: 'DELETE'
    })

    if (res.ok) {
        dispatch(removeCartItem(cartItemId))
    }
}

export const addCartItem = (cartItem) => async dispatch => {
    const res = await csrfFetch(`/api/cart_items`, {
        method: 'POST',
        body: JSON.stringify({cartItem: cartItem})
    })

    if (res.ok) {
        const cartItem = await res.json();
        dispatch(receiveCartItem(cartItem))
    }
}

// reducer

const initialState = {}

export const cartItemsReducer = (state = initialState, action) => {
    Object.freeze(state);
    const nextState = { ...state }

    switch (action.type) {
        case RECEIVE_CART_ITEMS:
            return { ...nextState, ...action.cartItems };
        case RECEIVE_CART_ITEM:
            nextState[action.cartItem.id] = action.cartItem
            return nextState;
        case REMOVE_CART_ITEM:
            delete nextState.cartItems[action.cartItemId]
            return nextState;
        default:
            return state;
    }
}
// actions

import csrfFetch from "./csrf"

const RECEIVE_CART = 'RECEIVE_CART'

const receiveCart = (cart) =>({
    type: RECEIVE_CART,
    cart
})

// selectors

export const getCart = (cartId) => state => {
    return state?.carts ? state.carts[cartId] : null
}

//thunk action

export const fetchCart = (session) => async dispatch => {
    const res = await csrfFetch(`/api/cart?session=${session}`)

    if (res.ok) {
        const cart = await res.json()
        dispatch(receiveCart(cart))
    }
}

// reducer

const initialState = {cart : null}

export const cartsReducer = (state = initialState, action) => {
    Object.freeze(state);
    const nextState = {...state}

    switch (action.type) {
        case RECEIVE_CART:
            nextState[action.cart.id] = action.cart
            return nextState;
        default:
            return state;
    }
}
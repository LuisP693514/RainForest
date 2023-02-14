// actions

import csrfFetch from "./csrf"

const RECEIVE_CART = 'RECEIVE_CART'

const receiveCart = (cart) =>({
    type: RECEIVE_CART,
    cart
})


// selectors

export const getCart = () => state => {
    return state?.cart ? state.cart : null
}

//thunk action

export const fetchCart = () => async dispatch => {
    const res = await csrfFetch(`/api/cart`)

    if (res.ok) {
        const cart = await res.json()
        dispatch(receiveCart(cart))
    }
}
// reducer

const initialState = {}

export const cartsReducer = (state = initialState, action) => {
    Object.freeze(state);
    const nextState = {...state}

    switch (action.type) {
        case RECEIVE_CART:
            
            return {...nextState, ...action.cart};
        default:
            return state;
    }
}
import csrfFetch from "./csrf"

export const RECEIVE_PRODUCT = 'RECEIVE_PRODUCT'
export const RECEIVE_PRODUCTS = 'RECEIVE_PRODUCTS'

// actions:
const receiveProduct = (product) => ({
    type: RECEIVE_PRODUCT,
    payload: product
})

const receiveProducts = (products) => ({
    type: RECEIVE_PRODUCTS,
    products
})

// selectors:

export const getProduct = (productId) => state => {
    return state?.products ? state.products[productId] : null
}

export const getProducts = state => {
    return state?.products ? Object.values(state.products) : []
}

// thunk methods

/*
    fetchProducts()
    fetchProduct(productId)
    updateProduct(product)

*/

export const fetchProducts = () => async dispatch => {
    const res = await csrfFetch('/api/products')

    if (res.ok) {
        const products = await res.json();
        dispatch(receiveProducts(products))
    }
}

export const fetchProduct = (productId) => async dispatch => {
    const res = await csrfFetch(`/api/products/${productId}`)
    if (res.ok) {
        const product = await res.json();
        dispatch(receiveProduct(product))
    }

}

export const updateProduct = (product) => async dispatch => {
    
    const res = await csrfFetch(`/api/products/${product.id}`, {
        method: 'PATCH',
        body: JSON.stringify({product: product})
    })

    if (res.ok) {
        const product = await res.json();
        dispatch(receiveProduct(product))
    }
}

// Reducer

const productsReducer = (state = {}, action) => {
    Object.freeze(state)
    const nextState = { ...state }

    switch (action.type) {
        case RECEIVE_PRODUCT:
            if (action.payload.id) nextState[action.payload.id] = action.payload;
            return nextState;
        case RECEIVE_PRODUCTS:
            return { ...nextState, ...action.products };
        default:
            return state;
    }
}

export default productsReducer;

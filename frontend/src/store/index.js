import { applyMiddleware, combineReducers, compose, createStore } from 'redux'
import thunk from 'redux-thunk'
import { cartsReducer } from './cart';
import { cartItemsReducer } from './cartItems';
import categoriesReducer from './category';
import productsReducer from './product';
import sessionReducer from './session';

export const rootReducer = combineReducers({
    session: sessionReducer,
    products: productsReducer,
    categories: categoriesReducer,
    cart: cartsReducer,
    cartItems: cartItemsReducer
})

let enhancer;

if (process.env.NODE_ENV === 'production') {
    enhancer = applyMiddleware(thunk);
} else {
    const logger = require('redux-logger').default;
    const composeEnhancers =
        window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
    enhancer = composeEnhancers(applyMiddleware(thunk, logger));
}

const configureStore = (preloadedState = {}) => {
    return createStore(rootReducer, preloadedState, enhancer)
}

export default configureStore;
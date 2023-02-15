import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { fetchCartItems, getCartItems } from '../../store/cartItems';
import { fetchCart, getCart } from '../../store/cart';
import './CartShowPage.css'
import Navigation from '../Navigation';
import CategoryHeader from '../CategoryHeader';

const CartShowPage = () => {

    const dispatch = useDispatch();
    const cartItems = useSelector(getCartItems)
    const cartItemsIds = cartItems?.length ? cartItems[cartItems.length -1] : []
    const cart = useSelector(getCart)

    useEffect(() => {
        dispatch(fetchCart());
        dispatch(fetchCartItems());
    }, [dispatch])

    const noItems = (
        <div id='noItemsInCartDiv'>
            <h1 id='headerShop'>Your Cart is empty!</h1>
        </div>
    )

    const items = (
        <div id='itemsInCart'>
            <h1 id='headerShop'>Your Cart</h1>
        </div>
    )

    return (
        <>
            <Navigation />
            <CategoryHeader />
            {cartItemsIds?.length === 0 ? noItems : items}
        </>
    )

}

export default CartShowPage;
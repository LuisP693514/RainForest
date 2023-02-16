import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { fetchCartItems, getCartItems } from '../../store/cartItems';
import { fetchCart } from '../../store/cart';
import './CartShowPage.css'
import Navigation from '../Navigation';
import CategoryHeader from '../CategoryHeader';
import CartItemBox from '../CartItemBox';

const CartShowPage = () => {

    const dispatch = useDispatch();
    const cartItems = useSelector(getCartItems)
    const cartItemsIds = cartItems?.length ? cartItems[cartItems.length - 1] : []
    const realCartItems = cartItems?.length ? cartItems.slice(0, -1) : []
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        dispatch(fetchCartItems())
            .then(() => setLoading(false));
    }, [dispatch, cartItems])

    if (loading) return <h1>Loading...</h1>;

    const noItems = (
        <div id='noItemsInCartDiv'>
            <h1 id='headerShop'>Your Cart is empty!</h1>
        </div>
    )

    const items = (
        <div id='itemsInCart'>
            <h1 id='headerShop'>Your Cart</h1>
            <p id='smallPriceText'>Price</p>
            {realCartItems.map(item => <CartItemBox key={item.id} cartItem={item} />)}
        </div>
    )

    return (
        <div id='background'>
            <Navigation />
            <CategoryHeader />
            {cartItemsIds?.length === 0 ? noItems : items}
        </div>
    )

}

export default CartShowPage;
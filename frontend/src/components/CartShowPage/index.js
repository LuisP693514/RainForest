import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { fetchCartItems, getCartItems } from '../../store/cartItems';
import './CartShowPage.css'
import Navigation from '../Navigation';
import CategoryHeader from '../CategoryHeader';
import CartItemBox from '../CartItemBox';
import { Link } from 'react-router-dom';
import FooterNav from '../FooterNav';
import { getSessionUser } from '../../store/session';
import { fetchProducts, getProducts } from '../../store/product';
import { formatWithCommas } from '../../utils/helperFunctions';
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';

const CartShowPage = () => {

    const dispatch = useDispatch();
    const user = useSelector(getSessionUser)
    const cartItems = useSelector(getCartItems)
    const cartItemsIds = cartItems?.length ? cartItems[cartItems.length - 1] : []
    const realCartItems = cartItems?.length ? cartItems.slice(0, -1) : []
    const products = useSelector(getProducts)
    const [clickedDel, setClickedDel] = useState(false)
    const [loading, setLoading] = useState(true)
    const history = useHistory();

    useEffect(() => {
        dispatch(fetchCartItems())
            .then(() => setLoading(false));
        dispatch(fetchProducts())
        if (clickedDel) setClickedDel(false);
    }, [dispatch, clickedDel])

    const totalPrice = () => {
        let subtotal = 0;
        realCartItems?.forEach(item => {
            subtotal += parseFloat(products[item.productId - 1]?.price) * item?.quantity
        })
        const wholeNumber = formatWithCommas(Math.floor(subtotal));
        const decimal = Math.floor((subtotal % 1) * 100);

        return `${wholeNumber}.${decimal}`;
    }
    if (loading) return <h1>Loading...</h1>;

    const checkout = (
        <div id='checkOutBox'>
            <div id='subtotal'>{`Subtotal (${cartItems?.length ? cartItems.length - 1 : 0} item${cartItems?.length-1 === 1 ? '' : 's'}): $${totalPrice()}`}</div>
            <button onClick={()=>{
                history.push('/checkout', {totalPrice: totalPrice(), cart: cartItems, user: user});
                window.location.reload();
            }}  id='checkout'>Proceed to checkout</button>
        </div>
    )

    const signIn = (
        <div id='checkOutBox'>
            <div id='subtotal'>{`Subtotal (${cartItems?.length ? cartItems.length - 1 : 0} item${cartItems?.length-1 === 1 ? '' : 's'}): $${totalPrice()}`}</div>
            <button onClick={()=>{
                history.push('/login')
            }} 
            id='checkout'>Sign in to checkout</button>
        </div>
    )

    const noItems = (
        <div id='noItemsInCartDiv'>
            <h1 id='headerShop2'>Your Cart is empty!</h1>
            <Link to='/' id='redirectText'>Let's start here!</Link>
        </div>
    )

    const items = (
        <>
            <div id='itemsInCart'>
                <h1 id='headerShop'>Your Cart</h1>
                <p id='smallPriceText'>Price</p>
                {realCartItems.map(item => <CartItemBox key={item.id} cartItem={item} setClickedDel={setClickedDel} />)}
            </div>
            <div id='signInToCheckOut'>
                {user ? checkout : signIn}
            </div>
        </>
    )

    return (
        <div id='background'>
            <Navigation />
            <CategoryHeader />
            <div id='bigboy'>
                {cartItemsIds?.length === 0 ? noItems : items}
            </div>
            <FooterNav />
        </div>
    )

}

export default CartShowPage;
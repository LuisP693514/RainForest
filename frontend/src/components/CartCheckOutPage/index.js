import './CartCheckOutPage.css'
import { useDispatch, useSelector } from 'react-redux'
import { Redirect, useHistory } from 'react-router-dom/cjs/react-router-dom.min';
import CartCheckOutPageItem from '../CartCheckOutPageItem';
import { useEffect } from 'react';
import { fetchProduct, getProducts } from '../../store/product';


const CartCheckOutPage = () => {

    const dispatch = useDispatch();
    const history = useHistory();

    const cartItems = history?.location?.state?.cart
    const totalPrice = history?.location?.state?.totalPrice // this is a function
    const user = history?.location?.state?.user
    const realCartItems = cartItems?.slice(0, -1)
    const products = useSelector(getProducts)

    console.log(products)

    useEffect(() => {
        if (realCartItems) {
            realCartItems.forEach(cartItem => {
                dispatch(fetchProduct(cartItem.productId))
            });
        }
    }, [dispatch])

    if (!history) return <div>loading...</div>
    if (!cartItems) return <Redirect to='/' />
    console.log(history)

    return (
        <div id='entireCheckOutPage'>
            <header id='checkoutHeader'>
                <a href='/'><img id='checkoutLogo' src={require('../../images/logo.png')} alt={'RainForest logo'} /></a>
                <div id='amountOfItems'>{`Checkout (${cartItems?.length ? cartItems.length - 1 : 0} item${cartItems?.length - 1 === 1 ? '' : 's'})`}</div>
            </header>
            <main id='body'>
                {/* Address, payment, list of items */}
                <div id='Address'>
                    <div id='theOne' className='numbered'>1</div>
                    <div id='shippingAddress'>Shipping Address</div>
                    <div id='actualAddress'>
                        <div id='nameAddress' className='RealAddress'>{user?.name}</div>
                        <div id='middleAddress' className='RealAddress'>123 Earth Ave.</div>
                        <div id='bottomAddress' className='RealAddress'>Atlantic Ocean, 00000-0000</div>
                    </div>
                </div>
                <div id='Payment'>
                    <div id='theTwo' className='numbered'>2</div>
                    <div id='paymentMethod'>Payment method</div>
                    <div id='paymentWrapper'>
                        <div id='visa'>Visa ending in 0000</div>
                        <div id='billingAddress'>Billing Address: 123 Earth Ave. Atlantic Ocean, 00000-0000</div>
                    </div>
                </div>
                <div id='orderItems'>
                    <div id='flex-direction-row'>
                        <div id='theThree' className='numbered'>3</div>
                        <div id='review'>Review items and shipping</div>
                    </div>
                    <div id='boxHoldingOrder'>
                        {/* list of items goes here */}
                        {realCartItems.map(cartItem => <CartCheckOutPageItem key={cartItem.id} />)}
                    </div>
                </div>
            </main>
        </div>
    )
}

export default CartCheckOutPage;
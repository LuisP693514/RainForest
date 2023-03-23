import './CartCheckOutPage.css'
import { useDispatch, useSelector } from 'react-redux'
import { Redirect, useHistory } from 'react-router-dom/cjs/react-router-dom.min';
import CartCheckOutPageItem from '../CartCheckOutPageItem';
import { useEffect } from 'react';
import { fetchProduct, getProducts, updateProduct } from '../../store/product';
import { deleteCartItem } from '../../store/cartItems';
import { Link } from 'react-router-dom';


const CartCheckOutPage = () => {

    const dispatch = useDispatch();
    const history = useHistory();

    const cartItems = history?.location?.state?.cart
    const totalPrice = history?.location?.state?.totalPrice // this is a function
    const user = history?.location?.state?.user
    const realCartItems = cartItems?.slice(0, -1)
    const products = useSelector(getProducts)

    useEffect(() => {
        if (realCartItems) {
            realCartItems.forEach(cartItem => {
                dispatch(fetchProduct(cartItem.productId))
            });
        }
    }, [dispatch])

    if (!history) return <div>loading...</div>
    if (!cartItems) return <Redirect to='/' />

    // delivery date
    const currentDate = new Date();
    const fiveDaysFromNow = new Date(currentDate.getTime() + (5 * 24 * 60 * 60 * 1000));

    const options = { year: 'numeric', month: 'short', day: 'numeric' };
    const formattedDate = fiveDaysFromNow.toLocaleDateString('en-US', options);

    // moving the quantity of items into the product object (O(n^2)) where n is the length of the cart

    const realProducts = [];

    realCartItems.forEach(cartItem => {
        products.forEach(product => {
            if (cartItem.productId === product.id) {
                const realProduct = { ...product, quantity: cartItem.quantity }
                realProducts.push(realProduct)
            }
        })
    });

    // update the product count in the backend
    const handlePurchase = (e) => {
        realProducts.forEach(product => {
            dispatch(updateProduct({
                ...product,
                amount: product.amount - product.quantity
            }))
        })
        realCartItems.forEach(cartItem => {
            dispatch(deleteCartItem(cartItem.id));
        })
        history.push('/checkout', {});
        window.location.reload();
    }

    return (
        <div id='entireCheckOutPage'>
            <header id='checkoutHeader'>
                <a href='/'><img id='checkoutLogo' src={require('../../images/logo.png')} alt={'RainForest logo'} /></a>
                <div>
                    {`Cart ( `}
                    <Link to={'cart'} id='amountOfItems'>{`${cartItems?.length ? cartItems.length - 1 : 0} item${cartItems?.length - 1 === 1 ? '' : 's'}`}</Link>
                    {` )`}
                </div>
                <div id='lock'><i className="fa-solid fa-lock"></i></div>
            </header>
            <main id='body'>
                {/* Address, payment, list of items */}
                <div id='leftSideOfCheckOut'>
                    <div id='Address'>
                        <div id='theOne' className='numbered'>1</div>
                        <div id='shippingAddress'>Shipping address</div>
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
                            <div id='visa'><strong>Visa</strong> ending in <strong>0000</strong></div>
                            <div id='billingAddress'>{`Billing Address: ${user?.name}, 123 Earth Ave. Atlantic Ocean, 00000-0000`}</div>
                        </div>
                    </div>
                    <div id='orderItems'>
                        <div id='flex-direction-row'>
                            <div id='theThree' className='numbered'>3</div>
                            <div id='review'>Review items and shipping</div>
                        </div>
                        <div id='boxHoldingOrder'>
                            {/* list of items goes here */}
                            <div id='deliveryDate'>{"Delivery date: "}<strong id='futureDateStrong'>{formattedDate}</strong></div>
                            {realProducts?.map(product => <CartCheckOutPageItem key={product.id} product={product} />)}
                        </div>
                        <div id='boxToPlaceOrder'>
                            <button id='placeOrderButton' onClick={handlePurchase}>Place your order</button>
                            <strong id='orderTotalPrice'>{`Order total: $${totalPrice}`}</strong>
                        </div>
                    </div>
                </div>
                {/* Checkout button on the right */}
                <div id='checkoutButtonRightSide'>
                    <button onClick={handlePurchase} id='placeOrderButton'>Place your order</button>
                    <div id='orderSummary'>
                        <div id='orderSummaryText'>Order Summary</div>
                        <div id='itemsThingyHolder' className='flexRow'>
                            <p>Items:</p>
                            <p>{`$${totalPrice}`}</p>
                        </div>
                        <div id='shippingPrice' className='flexRow'>
                            <p>Shipping & Handling</p>
                            <p id='shippingPricePTag'>$0.00</p>
                        </div>
                        <div id='taxPrice' className='flexRow'>
                            <p>Total before tax:</p>
                            <p>{`$${totalPrice}`}</p>
                        </div>
                        <div id='actualTax' className='flexRow'>
                            <p>Estimated tax to be collected:</p>
                            <p>$0.00</p>
                        </div>
                    </div>
                    <div id='orderTotalPriceDiv'>
                        <strong id='orderTotalPrice'>{`Order total:`}</strong>
                        <strong id='totalPriceNumber'>{`$${totalPrice}`}</strong>
                    </div>
                </div>
            </main>
        </div>
    )
}

export default CartCheckOutPage;
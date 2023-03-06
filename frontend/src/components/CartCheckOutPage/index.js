import './CartCheckOutPage.css'
import { useDispatch } from 'react-redux'
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';


const CartCheckOutPage = () => {

    const dispatch = useDispatch();
    const history = useHistory();

    const cartItems = history?.location?.state?.cart
    const totalPrice = history?.location?.state?.totalPrice // this is a function
    const user = history?.location?.state?.user

    return (
        <div id='entireCheckOutPage'>
            <header id='checkoutHeader'>
                <a href='/'><img id='checkoutLogo' src={require('../../images/logo.png')} alt={'RainForest logo'}/></a>
                <div id='amountOfItems'>{`Checkout (${cartItems?.length ? cartItems.length - 1 : 0} item${cartItems?.length-1 === 1 ? '' : 's'})`}</div>
            </header>
            <main id='body'>
                {/* Address, payment, list of items */}
                <div id='Address'>
                    <div id='theOne'>1</div>
                    <div id='shippingAddress'>Shipping Address</div>
                    <div id='actualAddress'>
                        <div id='nameAddress' className='RealAddress'>{user?.name}</div>
                        <div id='middleAddress' className='RealAddress'>123 Earth Ave.</div>
                        <div id='bottomAddress' className='RealAddress'>Atlantic Ocean, 00000-0000</div>
                    </div>
                </div>
                <div id='Payment'></div>
                <div id='orderItems'></div>
            </main>
        </div>
    )
}

export default CartCheckOutPage;
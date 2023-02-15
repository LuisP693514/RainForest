import { useDispatch, useSelector } from 'react-redux';
import { Redirect, useHistory } from 'react-router-dom/cjs/react-router-dom.min';
import { getSessionUser, logout } from '../../store/session';
import './Navigation.css'
import LOGO from '../../images/logoWhite.png'
import SearchBar from '../SearchBar';
import FitText from '../FitText';
import { useEffect, useState } from 'react';
import { fetchCartItems, getCartItems } from '../../store/cartItems';
import { Link } from 'react-router-dom';
import { fetchCart, getCart } from '../../store/cart';

const Navigation = () => {

    const dispatch = useDispatch();
    const history = useHistory();
    const user = useSelector(getSessionUser)
    const userName = user?.name
    const cartItems = useSelector(getCartItems)
    const [hover, setHover] = useState(false)

    const realCartItemsLength = () => {
        const temp = cartItems?.length ? cartItems.slice(0, cartItems.length-1) : [];
        let count = 0;
        if (temp.length) {
            temp.forEach(item => {
                count += item.quantity
            });
        }
        return count;
    }

    const signedIn = !!user
    const displaySignOut = (

        <button id='signInButtonNav' onClick={(e) => {
            e.preventDefault();
            dispatch(logout());
            history.push('/');
        }}>Sign out</button>
    )
    const displaySignIn = (
        <button id='signInButtonNav' onClick={(e) => {
            e.preventDefault();
            history.push('/login');
        }}>Sign in</button>
    )

    useEffect(() => {
        dispatch(fetchCart())
        dispatch(fetchCartItems())
    }, [dispatch])

    const welcomeName = user ? userName : 'sign in'
    return (
        <nav id='navBar'>
            <div id='nav-left'>
                <a href='/'>
                    <img id='navLogoImage' src={LOGO} alt='Logo' />
                </a>
            </div>
            <div id='nav-fill'>
                <div id='mid-nav-test'>
                    <SearchBar />
                </div>
            </div>
            <div id='nav-right'>
                <div id='containerForThingy' onMouseEnter={() => {
                    setHover(true)
                }}
                    onMouseLeave={() => {
                        setHover(false)
                    }}
                >
                    <FitText idParam={'helloMessage'} maxWidth={250} text={`Hello ${welcomeName}`} font={16} />
                    <div id='containerForSignInButton' style={
                        hover ? { display: 'flex' } : { display: 'none' }
                    }
                        onMouseEnter={() => {
                            setHover(true)
                        }}
                        onMouseLeave={() => { setHover(false) }}>
                        {signedIn ? displaySignOut : displaySignIn}
                    </div>
                </div>
                <Link id='linkTagFixColor' to='/cart'>
                    <div id='cartDisplayingNumber' >
                        <p id='numberOfItemsInCart'>{realCartItemsLength()}</p>
                        <i id='cartIconInTheNav' className="fa-solid fa-cart-shopping"></i>
                    </div>
                </Link>
            </div>
        </nav>
    )
}

export default Navigation;
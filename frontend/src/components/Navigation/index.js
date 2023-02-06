import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';
import { getSessionUser, logout } from '../../store/session';
import './Navigation.css'
import LOGO from '../../images/logo.png'

const Navigation = () => {

    const dispatch = useDispatch();
    const history = useHistory();
    const user = useSelector(getSessionUser)
    const userName = user?.name
    
    const signedIn = !!user
    const displaySignOut = (
        <button id='signInButtonNav' onClick={(e)=>{
            e.preventDefault();
            dispatch(logout());
        }}>Sign out</button>
    )
    const displaySignIn = (
        <button id='signInButtonNav' onClick={(e)=> {
            e.preventDefault();
            history.push('/login');
        }}>Sign in</button>
    )
    return (
        <nav id='navBar'>
            <div id='nav-left'>
                <a href='/'>
                    <img id='navLogoImage' src={LOGO} alt='Logo'/>
                </a>
            </div>
            <div id='nav-fill'>
                <div id='mid-nav-test'>
                    hello
                </div>
            </div>
            <div id='nav-right'>
                <p id='helloMessage'>Hello { user ? userName : 'sign in'}</p>
                {signedIn ? displaySignOut : displaySignIn}
            </div>
        </nav>
    )
}

export default Navigation;
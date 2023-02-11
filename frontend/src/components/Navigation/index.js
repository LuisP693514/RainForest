import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';
import { getSessionUser, logout } from '../../store/session';
import './Navigation.css'
import LOGO from '../../images/logoWhite.png'
import SearchBar from '../SearchBar';
import FitText from '../FitText';

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

    const welcomeName = user ? userName : 'sign in'
    return (
        <nav id='navBar'>
            <div id='nav-left'>
                <a href='/'>
                    <img id='navLogoImage' src={LOGO} alt='Logo'/>
                </a>
            </div>
            <div id='nav-fill'>
                <div id='mid-nav-test'>
                    <SearchBar />
                </div>
            </div>
            <div id='nav-right'>
                <FitText idParam={'helloMessage'} maxWidth={200} text={`Hello ${welcomeName}`}/>
                {signedIn ? displaySignOut : displaySignIn}
            </div>
        </nav>
    )
}

export default Navigation;
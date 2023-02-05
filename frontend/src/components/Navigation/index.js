import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';
import { getSessionUser, logout } from '../../store/session';
import './Navigation.css'

const Navigation = () => {

    const dispatch = useDispatch();
    const history = useHistory();
    const session = useSelector(getSessionUser)
    
    const signedIn = !!session
    const displaySignOut = (
        <button onClick={(e)=>{
            e.preventDefault();
            dispatch(logout());
        }}>Sign out</button>
    )
    const displaySignIn = (
        <button onClick={(e)=> {
            e.preventDefault();
            history.push('/login');
        }}>Sign in</button>
    )
    return (
        <header id='navBar'>
            <nav id='nav-left'>

            </nav>
            <nav id='nav-fill'>

            </nav>
            <nav id='nav-right'>
                {signedIn ? displaySignOut : displaySignIn}
            </nav>
        </header>
    )
}

export default Navigation;
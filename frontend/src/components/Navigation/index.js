import { useSelector } from 'react-redux';
import { getSessionUser } from '../../store/session';
import './Navigation.css'

const Navigation = () => {

    const session = useSelector(getSessionUser)
    

    return (
        <header id='navBar'>


        </header>
    )
}

export default Navigation;
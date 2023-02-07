import { useDispatch, useSelector } from "react-redux"
import { Redirect } from "react-router-dom"
import { getSessionUser } from "../../store/session"
import { useState } from "react"
import * as sessionActions from '../../store/session';
import './LoginForm.css'
import LOGO from '../../images/logo.png'
import { useHistory } from "react-router-dom/cjs/react-router-dom.min";

const LoginFormPage = () => {
    const history = useHistory();
    const dispatch = useDispatch()
    const [credential, setCredential] = useState('')
    const [password, setPassword] = useState('')
    const [errors, setErrors] = useState([])
    const sessionUser = useSelector(getSessionUser)

    if (sessionUser) return <Redirect to={'/'} />

    const handleSubmit = (e) => {
        e.preventDefault();
        setErrors([]);
        return dispatch(sessionActions.fetchSession({ credential, password }))
            .catch(async (res) => {
                let data;
                try {
                    data = await res.clone().json();
                } catch {
                    data = await res.text();
                }
                if (data?.errors) setErrors(data.errors);
                else if (data) setErrors([data]);
                else setErrors([res.statusText]);
            });
    }
    const handleDemoSubmit = (e) => {
        e.preventDefault();
        return dispatch(sessionActions.fetchSession({ credential: 'demo@user.io', password: 'password' }))
    }

    const emailError = errors.find(error => error.toLowerCase().includes('email'))
    const passError = errors.find(error => error.toLowerCase().startsWith('password '))

    return (
        <div id="outerDiv">
            <div id="titleHeader">
                <a href="/">
                    <img id='rainForestLogo' src={(LOGO)} alt='' />
                </a>
            </div>
            <div id="logInFormDiv">
                <h1>Sign in</h1>
                <form onSubmit={handleSubmit} id='loginForm'>
                    <label className='logInFormLabel' id="credLabel">Email</label>
                    <br />
                    <input
                        className="logInInputField"
                        id="credInput"
                        type="text"
                        value={credential}
                        onChange={(e) => setCredential(e.target.value)}
                        style={{ borderColor: emailError ? "red" : "", boxShadow: emailError ? ('0 0 3px 1px #C40000') : '' }}
                    />

                    {emailError ? <li id='error' key={emailError}><i className="fa-sharp fa-solid fa-triangle-exclamation"></i> {emailError}</li> : <br />}

                    <label className='logInFormLabel' id="passLabel">Password</label>
                    <br />
                    <input
                        className="logInInputField"
                        id="passInput"
                        type="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        style={{ borderColor: passError ? "red" : "", boxShadow: passError ? ('0 0 3px 1px #C40000') : '' }}
                    />

                    {passError ? <li id='error' key={passError}><i className="fa-sharp fa-solid fa-triangle-exclamation"></i>{passError}</li> : <br />}

                    <button
                        type="submit"
                        id="logInButton"
                    >Log In</button>
                </form>
                <form id="demoForm" onSubmit={handleDemoSubmit}>
                    <button id='demoSubmit'>Demo Login</button>
                </form>
            </div>
            <div id='createDivAtTheBottom'>
                <div id='logInPTagContainer'>
                    <h3 id="logInPTag">New to RainForest?</h3>
                </div>
                <button id='createAccountButton' onClick={(e) => {
                    history.push('/signup')
                }}>Create your RainForest account</button>
            </div>
        </div>
    );
}

export default LoginFormPage;
import { useDispatch, useSelector } from "react-redux";
import { Redirect } from "react-router-dom";
import { getSessionUser } from "../../store/session";
import * as sessionActions from '../../store/session'
import { useRef, useState } from "react";
import { Link } from "react-router-dom/cjs/react-router-dom.min";
import './SignUpForm.css'
import LOGO from '../../images/logo.png'

const SignUpForm = () => {
    const inputRef = useRef(null)
    const dispatch = useDispatch();
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [name, setName] = useState('')
    const [confirmPassword, setConfirmPassword] = useState('')
    const [errors, setErrors] = useState([])
    const sessionUser = useSelector(getSessionUser)

    if (sessionUser) return <Redirect to={'/'} />

    const handleSubmit = (e) => {
        e.preventDefault();
        setErrors([]);
        if (password === confirmPassword) {
            return dispatch(sessionActions.signUp({ email, name, password }))
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
        } else {
            return setErrors(['Passwords must match'])
        }
    }

    const emailError = errors.find(error => error.toLowerCase().startsWith('email'))
    const nameError = errors.find(error => error.toLowerCase().startsWith('name'))
    const passError = errors.find(error => error.toLowerCase().startsWith('password '))
    const matchError = errors.find(error => error.toLowerCase().startsWith('passwords'))

    return (
        <div id="outerDiv">
            <div id="titleHeader">
                <a href="/">
                    <img id='rainForestLogo' src={(LOGO)} alt='RainForest' />
                </a>
            </div>
            <div id="signUpForm">
                <h1>Create account</h1>
                <form onSubmit={handleSubmit} id='suForm'>

                    <label className='signUpFormLabel' htmlFor="email" id="emailLabel">Email</label>
                    <br />
                    <input
                        id="email"
                        className='signUpFormInput'
                        type='text'
                        value={email}
                        placeholder='Your email'
                        onChange={(e) => setEmail(e.currentTarget.value)}
                        style={{ borderColor: emailError ? "red" : "", boxShadow: emailError ? ('0 0 3px 1px #C40000') : '' }}
                    />
                    {/* Render error if it exists, otherwise break to new line */}
                    {emailError ? <li id='error' key={emailError}><i className="fa-sharp fa-solid fa-triangle-exclamation"></i> {emailError}</li> : <br />}

                    <label className='signUpFormLabel' htmlFor="name" id="nameLabel">Name</label>
                    <br />
                    <input
                        id="name"
                        className='signUpFormInput'
                        type={'text'}
                        value={name}
                        placeholder='Your name'
                        onChange={(e) => setName(e.currentTarget.value)}
                        style={{ borderColor: nameError ? "red" : "", boxShadow: nameError ? ('0 0 3px 1px #C40000') : '' }}
                    />

                    {nameError ? <li id='error' key={nameError}><i className="fa-sharp fa-solid fa-triangle-exclamation"></i> {nameError}</li> : <br />}

                    <label className='signUpFormLabel' htmlFor="password" id="passwordLabel">Password</label>
                    <br />
                    <input
                        id="password"
                        className='signUpFormInput'
                        type={'password'}
                        value={password}
                        placeholder='At least 6 characters'
                        onChange={(e) => setPassword(e.currentTarget.value)}
                        style={{ borderColor: passError ? "red" : "", boxShadow: passError ? ('0 0 3px 1px #C40000') : '' }}

                    />

                    {passError ? <li id='error' key={passError}><i className="fa-sharp fa-solid fa-triangle-exclamation"></i>{passError}</li> : <li id='infoLi'><i className="fa-solid fa-circle-info"></i><p id='infoP'>Passwords must be at least 6 characters.</p></li>}

                    <label className='signUpFormLabel' htmlFor="confirmPassword" id="confirmPasswordLabel">Re-enter password</label>
                    <br />
                    <input
                        ref={inputRef}
                        className='signUpFormInput'
                        id="confirmPassword"
                        type={'password'}
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.currentTarget.value)}
                        style={{ borderColor: matchError ? "red" : "", boxShadow: matchError ? ('0 0 3px 1px #C40000') : '' }}
                        onPaste={(e) => { e.preventDefault(); }}
                    />

                    {matchError ? <li id='error' key={matchError}><i className="fa-sharp fa-solid fa-triangle-exclamation"></i>{matchError}</li> : <br />}

                    <button id="signUpButton">Sign Up </button>

                </form>
                <p id="signInPTag">Already have an account? <Link to={'/login'} id='signInLink'>Sign in </Link> <Link to={'/login'} id='signInLink'><i className="fa-solid fa-caret-right"></i> </Link> </p>
            </div>
        </div>
    )
}

export default SignUpForm;
import { useDispatch, useSelector } from "react-redux";
import { Redirect } from "react-router-dom";
import { getSessionUser } from "../../store/session";
import * as sessionActions from '../../store/session'
import { useState } from "react";
import { Link } from "react-router-dom/cjs/react-router-dom.min";
import './SignUpForm.css'
import LOGO from '../../images/logo.png'

const SignUpForm = () => {
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
            return setErrors(['Both password fields should match.'])
        }
    }

    return (
        <div id="outerDiv">
            <div id="titleHeader">
                <img src={(LOGO)} alt='' />

            </div>
            <div id="signUpForm">
                <h1>Create account</h1>
                <form onSubmit={handleSubmit} id='suForm'>
                    <ul id="errorsUl">
                        {errors.map(error => <li id='error' key={error}>{error}</li>)}
                    </ul>
                    <label htmlFor="email" id="emailLabel">Email</label>
                    <br />
                    <input
                        id="email"
                        type='email'
                        value={email}
                        placeholder='Your email'
                        onChange={(e) => setEmail(e.currentTarget.value)}
                        required
                    />

                    <br />
                    <label htmlFor="name" id="nameLabel">Name</label>
                    <br />
                    <input
                        id="name"
                        type={'text'}
                        value={name}
                        placeholder='Your name'
                        onChange={(e) => setName(e.currentTarget.value)}
                        required
                    />

                    <br />
                    <label htmlFor="password" id="passwordLabel">Password</label>
                    <br />
                    <input
                        id="password"
                        type={'password'}
                        value={password}
                        placeholder='At least 6 characters'
                        onChange={(e) => setPassword(e.currentTarget.value)}
                        required
                    />

                    <br />
                    <label htmlFor="cofirmPassword" id="confirmPasswordLabel">Re-enter password</label>
                    <br />
                    <input
                        id="confirmPassword"
                        type={'password'}
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.currentTarget.value)}
                        required
                    />

                    <br />
                    <button id="signUpButton">Sign Up</button>

                </form>
                <p id="signInPTag">Already have an account? <Link to={'/login'} id='signInLink'> Sign in </Link> </p>
            </div>
        </div>
    )
}

export default SignUpForm;
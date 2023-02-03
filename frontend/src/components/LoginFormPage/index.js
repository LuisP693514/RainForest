import { useDispatch, useSelector } from "react-redux"
import { Redirect } from "react-router-dom"
import { getSessionUser } from "../../store/session"
import { useState } from "react"
import * as sessionActions from '../../store/session';
import './LoginForm.css'

const LoginFormPage = () => {

    const dispatch = useDispatch()
    const [credential, setCredential] = useState('')
    const [password, setPassword] = useState('')
    const [errors, setErrors] = useState([])
    const sessionUser = useSelector(getSessionUser)

    if (sessionUser) <Redirect to={'/'} />

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

    return (
        <form onSubmit={handleSubmit}>
            <ul id="errorsUl">
                {errors.map(error => <li key={error}>{error}</li>)}
            </ul>
            <label id="credLabel">
                Username or Email 
                <input
                    id="credInput"
                    type="text"
                    value={credential}
                    onChange={(e) => setCredential(e.target.value)}
                    required
                />
            </label>
            <br/>
            <label id="passLabel">
                Password
                <input
                    id="passInput"
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                />
            </label>
            <br/>
            <button 
                type="submit"
                id="submitButton"
                >Log In</button>
        </form>
    );
}

export default LoginFormPage;
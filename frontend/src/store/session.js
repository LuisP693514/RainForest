import csrfFetch, { storeCSRFToken } from "./csrf";

export const RECEIVE_SESSION = 'RECEIVE_SESSION';
export const REMOVE_SESSION = 'REMOVE_SESSION';

export const receiveSession = (user) => ({
    type: RECEIVE_SESSION,
    payload: user
})

export const removeSession = () => ({
    type: REMOVE_SESSION
})

export const getSessionUser = state => {
    return state?.session ? state.session.user : null;
}

export const signUp = (user) => async dispatch => {
    const res = await csrfFetch('/api/users', {
        method: 'POST',
        body: JSON.stringify(user)
    })

    if (res.ok) {
        const data = await res.json()
        storeCurrentUser(data.user)
        dispatch(receiveSession(data.user))
    }
}

export const fetchSession = (user) => async dispatch => {
    const { credential, password } = user
    const res = await csrfFetch('/api/session', {
        method: 'POST',
        body: JSON.stringify({ credential, password })
    })

    if (res.ok) {
        const session = await res.json();
        storeCurrentUser(session.user)
        dispatch(receiveSession(session.user))
        return res;
    }
}

export const logout = () => async dispatch => {
    const res = await csrfFetch('/api/session', {
        method: 'DELETE'
    })

    if (res.ok) {
        storeCurrentUser(null)
        dispatch(removeSession())
        return res;
    }
}

const storeCurrentUser = user => {
    if (user) sessionStorage.setItem("currentUser", JSON.stringify(user));
    else sessionStorage.removeItem("currentUser");
}

export const restoreSession = () => async dispatch => {
    const response = await csrfFetch("/api/session");
    storeCSRFToken(response);
    const data = await response.json();
    storeCurrentUser(data.user);
    dispatch(receiveSession(data.user));
    return response;
};

const initialState = {
    user: JSON.parse(sessionStorage.getItem("currentUser"))
};

const sessionReducer = (state = initialState, action) => {
    Object.freeze(state)

    const nextState = { ...state }

    switch (action.type) {
        case RECEIVE_SESSION:
            nextState.user = action.payload
            return nextState;
        case REMOVE_SESSION:
            nextState.user = null
            return nextState;
        default:
            return state;
    }
}

export default sessionReducer;
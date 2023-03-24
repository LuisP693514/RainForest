// constants

import csrfFetch from "./csrf";

const RECEIVE_USER = "RECEIVE_USER";
const REMOVE_USER = "REMOVE_USER";

// actions

const receiveUser = user => ({
    type: RECEIVE_USER,
    user
})

const removeUser = userId => ({
    type: REMOVE_USER,
    userId
})

// selectors

export const getUser = userId => state => {
    return state?.users ? state.users[userId] : null;
}

// thunk middleware
/**
 * fetchUser(userId)
 */

export const fetchUser = userId => async dispatch => {

    const res = await csrfFetch(`/api/users/${userId}`)

    if (res.ok) {
        const user = await res.json();
        dispatch(receiveUser(user))
    }
}

// reducer

const initialState = {}

const usersReducer = (state = initialState, action) => {
    Object.freeze(state);

    const nextState = {...state};

    switch (action.type) {
        case RECEIVE_USER:
            nextState[action.user.id] = action.user;
            return nextState;
        case REMOVE_USER:
            delete nextState[action.userId];
            return nextState;
        default:
            return state;
    }
}

export default usersReducer;
import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { fetchUser, getUser } from '../../store/user';
import './Review.css';

const Review = ({ review }) => {

    const dispatch = useDispatch();
    const author = useSelector(getUser(review.userId))

    useEffect(() => {
        dispatch(fetchUser(review.userId))
    }, [dispatch, review.userId])

    if (!author) return <div>Loading...</div>;

    return (
        <div id='reviewContainer'>
            <div id='reviewAuthor'>{author?.name}</div>
            <div id='reviewBody'>{review?.body}</div>
            <div id='reviewScore'>{review?.score}</div>
        </div>
    )

}

export default Review;

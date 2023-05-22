import React, { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { deleteReview, updateReview } from '../../store/review';
import { getSessionUser } from '../../store/session';
import { fetchUser, getUser } from '../../store/user';
import './Review.css';

const Review = ({ review }) => {

    const dispatch = useDispatch();
    const user = useSelector(getSessionUser);
    const author = useSelector(getUser(review.userId))
    const [edit, setEdit] = useState(false)
    const [reviewBody, setReviewBody] = useState(review.body)

    useEffect(() => {
        dispatch(fetchUser(review.userId))
    }, [dispatch, review.userId, edit])

    if (!author) return <div>Loading...</div>;

    const handleEditReviewSubmit = (e) => {
        e.preventDefault();

        const amount = e.target.querySelector('select');
        const value = amount.value;

        dispatch(updateReview({
            ...review,
            body: reviewBody,
            score: value
        }))

        setEdit(false)
    }

    return (
        <>
            {!edit ?
                <div id='reviewContainer'>
                    <div id='reviewAuthor'>{author?.name}</div>
                    <div id='column-flex'>
                        <div id='reviewBody'>{review?.body}</div>
                        <div id='reviewScore'>Score: {review?.score}/5</div>
                    </div>
                    {user?.id === review?.userId ? <>
                        <button id='editReviewButton'
                            onClick={(e) => {
                                setEdit(true)
                            }}>Edit</button>
                        <button id='deleteReviewButton' onClick={() => {
                            dispatch(deleteReview(review?.id));
                        }}>Delete</button>
                    </>
                        : <></>}
                </div>
                :
                <form id='reviewContainer' onSubmit={handleEditReviewSubmit}>
                    <div id='reviewAuthor'>{author?.name}</div>
                    <div id='column-flex'>
                        <textarea
                            id='textareaReview'
                            placeholder='Write a review'
                            onChange={(e) => setReviewBody(e.target.value)}
                            value={reviewBody}
                            required
                        />

                        <div id='selectContainerReview'>
                            <p id='selectContainerReviewPTag'>Score: </p>
                            <select id='reviewScoreOption'>
                                <option value={0}>0</option>
                                <option value={1}>1</option>
                                <option value={2}>2</option>
                                <option value={3}>3</option>
                                <option value={4}>4</option>
                                <option value={5}>5</option>
                            </select>
                            <input id='submitReviewButtonInput' type='submit' value='Update Review' />
                        </div>
                    </div>
                </form>}
        </>
    )

}

export default Review;

import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Redirect, useHistory, useParams } from 'react-router-dom/cjs/react-router-dom.min';
import { fetchProduct, getProduct } from '../../store/product';
import CategoryHeader from '../CategoryHeader';
import Navigation from '../Navigation';
import './ProductShowPage.css'
import { formatWithCommas } from '../../utils/helperFunctions';
import { addCartItem, fetchCartItems, getCartItems } from '../../store/cartItems';
import { fetchCart, getCart } from '../../store/cart';
import { createReview, fetchProductReviews, getReviews, updateReview } from '../../store/review';
import Review from '../Review';
import { getSessionUser } from '../../store/session';

const ProductShowPage = () => {
    const [isLoading, setIsLoading] = useState(true);
    const history = useHistory();
    const { productId } = useParams()
    const dispatch = useDispatch();
    const product = useSelector(getProduct(productId)) || {}
    const cart = useSelector(getCart)
    product.amount = product.amount || 0

    const user = useSelector(getSessionUser)
    const reviews = useSelector(getReviews)
    const realReviews = reviews?.length ? reviews.slice(0, -1) : [];
    const cartItems = useSelector(getCartItems)
    const allCartItems = cartItems?.length ? cartItems.slice(0, -1) : [];

    const [reviewBody, setReviewBody] = useState('');

    let includedInList = false;
    let averageScore = 5;
    if (realReviews.length) {
        let sum = 0;
        for (let i = 0; i < realReviews.length; i++) {
            const review = realReviews[i];
            sum += review.score;
            if (user) {
                if (review.userId === user.id) includedInList = true;
            }
        }
        averageScore = sum / realReviews.length;
    }

    let amountArr = []
    useEffect(() => {
        dispatch(fetchProduct(productId))
            .then(() => setIsLoading(false))
        dispatch(fetchCart())
        dispatch(fetchCartItems())
        dispatch(fetchProductReviews(productId))
    }, [dispatch, productId])

    if (product.amount > 30) {
        amountArr = [...Array(31).keys()]
        amountArr.splice(0, 1)
    } else if (product.amount > 0) {
        amountArr = [...Array(product.amount + 1).keys()]
        amountArr.splice(0, 1)
    } else {
        amountArr = [0]
    }

    const handleFormSubmit = (e) => {
        e.preventDefault();
        const amount = e.target.querySelector('select');
        const value = amount.value;

        if (value > 0) {
            if (allCartItems.some(item => item.productId == productId)) {
                history.push('/cart')
            } else {
                dispatch(addCartItem({ quantity: value, productId: productId, cartId: cart.id }));
                history.push('/cart')
            }
        }
    }

    const inStock = (
        <select id='quantitySelect'>
            {amountArr.map(num => <option key={num} className={`quantityOption`} value={num}>{`Qnt. ${num}`}</option>)}
        </select>
    )

    const stock = () => {
        if (product.amount < 1) {
            return (
                <p id='outOfStockPTag'>
                    {`Out of Stock.`}
                </p>
            )
        } else if (product.amount < 31) {
            return (
                <p id='almostOutPTag'>
                    {`Only ${product.amount} left in stock - order soon!`}
                </p>
            )

        } else {
            return (
                <p id='inStockPTag'>
                    {`In Stock.`}
                </p>
            )
        }
    }
    const handleReviewSubmit = (e) => {
        e.preventDefault();
        const amount = e.target.querySelector('select');
        const value = amount.value;

        dispatch(createReview({
            score: value,
            userId: user.id,
            productId: productId,
            body: reviewBody
        }))
        setReviewBody('');
    }

    const createReviewForm = (
        <form id='createReview' onSubmit={handleReviewSubmit}>
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
                <input id='submitReviewButtonInput' type='submit' value='Create review' />
            </div>
        </form>
    )

    const handleEditReviewSubmit = (e) => {
        e.preventDefault();
        const amount = e.target.querySelector('select');
        const value = amount.value;

        dispatch(updateReview({
            score: value,
            userId: user.id,
            productId: productId,
            body: reviewBody
        }))
    }

    if (isLoading) return <h1>Loading...</h1>
    if (!isLoading && !product) return <Redirect to='/product_does_not_exist' />

    const imageSrc = product ? require(`../../images/${product.image}`) : null
    return (
        <>
            <Navigation />
            <CategoryHeader />
            <div id='megaContainer'>
                <div id='topOfPage'>
                    <div id='imageDivLeftSide'>
                        {imageSrc ? <img id='productImage' src={imageSrc} alt='no img :(' /> : <img src='https://nyc3.digitaloceanspaces.com/memecreator-cdn/media/__processed__/e37/template-fairly-odd-parents-987-0c6db91aec9c.jpeg' alt='this Is not it' />}
                    </div>
                    <div id='midDivForTitleAndStuff'>
                        <h1 id='productNameH1'>{product.name}</h1>
                        <div id="reviewScoreUnderTitle">Reviews: {averageScore} / 5</div>
                        <div id='priceDiv'>
                            <p id='dollarSign'>$</p>
                            <p id='priceH3'>{formatWithCommas(Math.floor(product.price))}</p>
                            <p id='priceCents'>{`${Math.floor((product.price % 1) * 100) === 0 ? '00' : Math.floor((product.price % 1) * 100)}`}</p>
                        </div>
                        <ul id='bulletDesc'>
                            {product.bulletDesc.map((bullet, i) => <li key={`bullet-${i}`}>{bullet}</li>)}
                        </ul>
                    </div>
                    <div id='rightDivCart'>
                        <form id='addToCartForm' onSubmit={handleFormSubmit}>
                            <div id='priceDivCart'>
                                <p id='dollarSignCart'>$</p>
                                <p id='priceH3Cart'>{formatWithCommas(Math.floor(product.price))}</p>
                                <p id='priceCentsCart'>{`${Math.floor((product.price % 1) * 100) === 0 ? '00' : Math.floor((product.price % 1) * 100)}`}</p>
                            </div>
                            {stock()}
                            {product?.amount > 0 ? inStock : ''}
                            {product?.amount > 0 ? <button id='addToCartButton'>Add to cart</button> : <div id='addToCartButton2'>Check back another time!</div>}
                        </form>
                    </div>
                </div>
                <div id='productDescriptionDiv'>
                    <h2 id='productDescription'>Product Description</h2>
                    <p id='productDescriptionPTag'>{product.description}</p>
                </div>
                <div id='ReviewsDiv'>
                    <div id='productDescription'>Reviews</div>
                    {realReviews.map(review => {
                        return (<Review key={review.id} review={review} />)
                    })}
                    {user ? (includedInList ? (<></>) : createReviewForm)
                        :
                        <></>}
                </div>
            </div>
        </>
    )
}

export default ProductShowPage;
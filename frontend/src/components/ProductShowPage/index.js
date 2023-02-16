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

const ProductShowPage = () => {
    const [isLoading, setIsLoading] = useState(true);
    const history = useHistory();
    const { productId } = useParams()
    const dispatch = useDispatch();
    const product = useSelector(getProduct(productId)) || {}
    const cart = useSelector(getCart)
    product.amount = product.amount || 0

    const cartItems = useSelector(getCartItems)
    const allCartItems = cartItems?.length ? cartItems.slice(0, -1) : [];

    let amountArr = []
    useEffect(() => {
        dispatch(fetchProduct(productId))
            .then(() => setIsLoading(false))
        dispatch(fetchCart())
        dispatch(fetchCartItems())
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

                </div>
            </div>
        </>
    )
}

export default ProductShowPage;
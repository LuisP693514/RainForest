import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Redirect, useParams } from 'react-router-dom/cjs/react-router-dom.min';
import { fetchProduct, getProduct } from '../../store/product';
import Navigation from '../Navigation';
import './ProductShowPage.css'

const ProductShowPage = () => {
    const [isLoading, setIsLoading] = useState(true);

    const { productId } = useParams()
    const dispatch = useDispatch();
    const product = useSelector(getProduct(productId)) || {}
    product.amount = product.amount || 0
    let amountArr = []
    let selectedValue = 0;

    if (product.amount > 30) {
        amountArr = [...Array(31).keys()]
        amountArr.splice(0,1)
    } else if (product.amount > 0) {
        amountArr = [...Array(product.amount + 1).keys()]
        amountArr.splice(0,1)
    } else {
        amountArr = [0]
    }

    useEffect(() => {
        dispatch(fetchProduct(productId))
            .then(() => setIsLoading(false))
    }, [dispatch, productId])

    const handleFormSubmit = (e) => {
        e.preventDefault();

    }

    const stock = () => {
        if (product.amount < 1) {
            return (
                <p id='outOfStockPTag'>
                    {`Out of Stock.`}
                </p>
            )
        } else if (product.amount < 21) {
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
                        <select id='quantitySelect'> 
                            {amountArr.map(num => <option key={num} className={`quantityOption`} value={num}>{`Qnt. ${num}`}</option>)}
                        </select>
                        <button id='addToCartButton'>Add to cart</button>
                    </form>
                </div>
            </div>
            <div id='productDescriptionDiv'>
                <h2 id='productDescription'>Product Description</h2>
                <p id='productDescriptionPTag'>{product.description}</p>
            </div>
            <div id='ReviewsDiv'>

            </div>
        </>
    )
}

function formatWithCommas(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
export default ProductShowPage;
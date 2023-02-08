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
    const product = useSelector(getProduct(productId))

    useEffect(() => {
        dispatch(fetchProduct(productId))
            .then(() => setIsLoading(false))
    }, [dispatch, productId])

    const handleFormSubmit = (e) => {
        e.preventDefault();

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
                        <p id='priceH3'>{` ${Math.floor(product.price)}`}</p>
                        <p id='priceCents'>{`${Math.floor((product.price % 1) * 100) === 0 ? '00' : Math.floor((product.price % 1) * 100) }`}</p>
                    </div>
                    <ul id='bulletDesc'>
                        {product.bulletDesc.map((bullet, i) => <li key={`bullet-${i}`}>{bullet}</li>)}
                    </ul>
                </div>
                <div id='rightDivCart'>
                    <form id='addToCartForm' onSubmit={handleFormSubmit}>
                        <div id='priceDivCart'>
                            <p id='dollarSignCart'>$</p>
                            <p id='priceH3Cart'>{` ${Math.floor(product.price)}`}</p>
                            <p id='priceCentsCart'>{`${Math.floor((product.price % 1) * 100) === 0 ? '00' : Math.floor((product.price % 1) * 100) }`}</p>
                        </div>
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

export default ProductShowPage;
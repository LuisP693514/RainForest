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
                    <h3 id='price'>{`$${product.price}`}</h3>
                    <ul id='bulletDesc'>
                        {product.bulletDesc.map((bullet, i) => <li key={`bullet-${i}`}>{bullet}</li>)}
                    </ul>
                </div>
                <div id='rightDivCart'>
                    
                </div>
            </div>
            <div id='productDescriptionDiv'>
                <p id='productDescriptionPTag'>{product.description}</p>
            </div>
            <div id='ReviewsDiv'>

            </div>
        </>
    )
}

export default ProductShowPage;
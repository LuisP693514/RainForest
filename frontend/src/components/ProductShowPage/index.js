import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Redirect, useParams } from 'react-router-dom/cjs/react-router-dom.min';
import { fetchProduct,  getProduct, getProducts } from '../../store/product';
import Navigation from '../Navigation';
import './ProductShowPage.css'

const ProductShowPage = () => {
    const [isLoading, setIsLoading] = useState(true);

    const { productId } = useParams()
    const dispatch = useDispatch();
    const product = useSelector(getProduct(productId))
    
    useEffect(()=>{
        dispatch(fetchProduct(productId))
            .then(()=> setIsLoading(false))
    }, [dispatch,productId])


    if (isLoading) return <div>Loading...</div>
    if (!isLoading && !product) return <Redirect to='/product_does_not_exist'/>

    return (
        <>
        <Navigation />
        <div ></div>
        </>
    )
}

export default ProductShowPage;
import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Redirect, useParams } from 'react-router-dom/cjs/react-router-dom.min';
import { fetchProduct, fetchProducts, getProduct, getProducts } from '../../store/product';
import Navigation from '../Navigation';
import './ProductShowPage.css'

const ProductShowPage = () => {

    const { productId } = useParams()
    const dispatch = useDispatch();
    const productsIds = useSelector(getProducts).productsIds
    
    useEffect(()=>{
        dispatch(fetchProduct(productId))
        dispatch(fetchProducts())
    }, [dispatch,productId])

    const product = useSelector(getProduct(productId))

    if (!productsIds.includes(productId)) return <Redirect to='/'/>
    return (
        <>
        <Navigation />
        <div ></div>
        </>
    )
}

export default ProductShowPage;
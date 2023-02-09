import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { fetchProduct, getProduct } from '../../store/product';
import ProductBoxBox from '../ProductBoxBox';
import './ProductBox.css'

const ProductBox = ({ productId }) => {
// grab 4 products at random that have this category and use their images to link to their product page

    const dispatch = useDispatch()
    const product = useSelector(getProduct(productId))

    useEffect(()=>{
        dispatch(fetchProduct(productId))
    }, [dispatch, productId])

    return (

       <div id='containerBox'>
            <ProductBoxBox product={product} />
       </div>

    )

}

const filterProducts = (products, catId) => {
    const valueArr = Object.values(products);
    valueArr.splice(valueArr.length-1)
    const returnArr =[];
    valueArr.forEach(product => {
        if(product.categoryId === catId) returnArr.push(product);
    });
    return returnArr;
}

export default ProductBox;
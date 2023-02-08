import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { fetchProducts, getProducts } from '../../store/product';
import ProductBoxBox from '../ProductBoxBox';
import './ProductBox.css'

const ProductBox = ({ categoryId }) => {
// grab 4 products at random that have this category and use their images to link to their product page

    const dispatch = useDispatch()
    const products = useSelector(getProducts)
    const filtered = filterProducts(products, categoryId)

    useEffect(()=>{
        dispatch(fetchProducts())
    }, [dispatch])

    return (

        <div id='containerBox'>
            {filtered.map(product => <ProductBoxBox key={`inside-${product.id}`} product={product}/>)}
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
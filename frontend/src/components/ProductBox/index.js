import { useSelector } from 'react-redux';
import { getProduct } from '../../store/product';
import ProductBoxBox from '../ProductBoxBox';
import './ProductBox.css'

const ProductBox = ({ productId }) => {
// grab 4 products at random that have this category and use their images to link to their product page


    const product = useSelector(getProduct(productId))

    return (

       <div id='containerBox' key={productId}>
            <ProductBoxBox product={product} />
       </div>

    )

}

export default ProductBox;
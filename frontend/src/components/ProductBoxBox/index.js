import { Link } from 'react-router-dom';
import './ProductBoxBox.css'

const ProductBoxBox = ({product}) => {

    return (
        <>
            <Link to={`/products/${product.id}`} >
                <img id='productImageForInnerBox' src={require(`../../images/${product.image}`)} alt={product.name}/>
            </Link>
            <Link to={`/products/${product.id}`} >
                <p id='nameOfBoxBox'>{product.name}</p>
            </Link>
        </>
    )

}

export default ProductBoxBox;
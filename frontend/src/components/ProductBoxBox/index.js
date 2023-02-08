import { Link } from 'react-router-dom';
import './ProductBoxBox.css'

const ProductBoxBox = ({product}) => {

    return (
        <>
            <img src={require(`../../images/${product.image}`)} alt={product.name}/>
            <Link to={`/products/${product.id}`} >
                <p id='nameOfBoxBox'>{product.name}</p>
            </Link>
        </>
    )

}

export default ProductBoxBox;
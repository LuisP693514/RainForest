import { Link } from 'react-router-dom';
import './ProductBoxBox.css'

const ProductBoxBox = ({product}) => {

    return (
        <div id='innerDivHolds2'>
            <Link id='imgLinkTag' to={`/products/${product.id}`} >
                <img id='productImageForInnerBox' src={require(`../../images/${product.image}`)} alt={product.name}/>
            </Link>
            <Link id='wordsLinkTag' to={`/products/${product.id}`} >
                <p id='nameOfBoxBox'>{product.name}</p>
            </Link>
        </div>
    )

}

export default ProductBoxBox;
import { useDispatch } from 'react-redux';
import { Link } from 'react-router-dom';
import { removeAllReviews } from '../../store/review';
import './ProductBoxBox.css'

const ProductBoxBox = ({product}) => {

    const dispatch = useDispatch();

    let prodName = product.name

    if (prodName.length > 80) {
        prodName = product.name.slice(0, 80) + '...';
    }


    return (
        <div id='innerDivHolds2'>
            <Link onClick={(e) => {
                dispatch(removeAllReviews());
            }} id='imgLinkTag' to={`/products/${product.id}`} >
                <img id='productImageForInnerBox' src={require(`../../images/${product.image}`)} alt={product.name}/>
            </Link>
            <Link id='wordsLinkTag' to={`/products/${product.id}`} >
                <p id='nameOfBoxBox'>{prodName}</p>
            </Link>
        </div>
    )

}

export default ProductBoxBox;
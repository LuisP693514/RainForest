import { Link } from 'react-router-dom';
import FitText from '../FitText';
import './CategoryProductBox.css'
import { formatWithCommas } from '../../utils/helperFunctions';
import { useDispatch } from 'react-redux';
import { removeAllReviews } from '../../store/review';

const CategoryProductBox = ({ product }) => {

    const dispatch = useDispatch();

    return (
        
            <div id='categoryProductMotherDiv'>
                <Link onClick={(e) => {
                    dispatch(removeAllReviews())
                }} to={`/products/${product.id}`} id='imgLinkTagInCatBox'>
                    <img src={require(`../../images/${product.image}`)} id='imageInsideTheCatBox' />
                </Link>
                <div id='priceOfTheCatItem'>
                    <p id='dollarSignCat'>$</p>
                    <p id='priceH3Cat'>{formatWithCommas(Math.floor(product.price))}</p>
                    <p id='priceCentsCat'>{`${Math.floor((product.price % 1) * 100) === 0 ? '00' : Math.floor((product.price % 1) * 100)}`}</p>
                </div>
                <FitText idParam={'nameOfProductInsideCatBox'} text={product.name} maxWidth={300} font={16} />
            </div>
       
    )

}

export default CategoryProductBox;
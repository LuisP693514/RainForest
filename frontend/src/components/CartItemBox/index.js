import { useSelector } from 'react-redux';
import { getProduct } from '../../store/product';
import './CartItemBox.css'

const CartItemBox = ({cartItem}) => {


    const product = useSelector(getProduct(cartItem.productId))

    return (
        <div>
            <p id='productTitle'></p>
        </div>
    )

}

export default CartItemBox;
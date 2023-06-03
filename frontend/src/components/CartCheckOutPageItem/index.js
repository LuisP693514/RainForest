import { formatWithCommas } from '../../utils/helperFunctions'
import './CartCheckOutPageItem.css'

const CartCheckOutPageItem = ({ product }) => {

    const realPrice = parseFloat(product.price) * product.quantity
    const price = `${formatWithCommas(Math.floor(realPrice))}.${Math.floor((realPrice % 1) * 100)}`

    return (
        <div id='listOfCartItemsInCheckout'>
            <img id='cartItemCheckOutImageThing' src={require(`../../images/${product.image}`)} alt={`${product.name}`} />
            <strong id='nameOfTheProductInCheckout'>{product.name}</strong>
            <div id='priceInside'>{price % 1 === 0 ? `$${price}0` : `$${price}`}</div>
        </div>
    )

}

export default CartCheckOutPageItem;

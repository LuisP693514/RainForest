import { formatWithCommas } from '../../utils/helperFunctions'
import './CartCheckOutPageItem.css'

const CartCheckOutPageItem = ({ product }) => {

    const realPrice = parseFloat(product.price) * product.quantity
    const price = `${formatWithCommas(Math.floor(realPrice))}.${Math.floor((realPrice % 1) * 100)}`

    return (
        <div id='listOfCartItemsInCheckout'>
            <img id='cartItemCheckOutImageThing' src={require(`../../images/${product.image}`)} alt={`${product.name}`} />
            <div id='nameOfTheProductInCheckout'>{product.name}</div>
            <div>{price % 1 === 0 ? `$${price}0` : `$${price}`}</div>
        </div>
    )

}

export default CartCheckOutPageItem;
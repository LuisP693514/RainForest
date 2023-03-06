import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { deleteCartItem, updateCartItem } from '../../store/cartItems';
import { fetchProducts, getProduct } from '../../store/product';
import { formatWithCommas } from '../../utils/helperFunctions';
import './CartItemBox.css'

const CartItemBox = ({ cartItem, setClickedDel }) => {

    const [loading, setLoading] = useState(true)
    const dispatch = useDispatch();
    const product = useSelector(getProduct(cartItem.productId))
    const [selected, setSelected] = useState(cartItem.quantity)


    useEffect(() => {
        dispatch(fetchProducts())
            .then(() => {
                setLoading(false)
            })

    }, [dispatch])

    if (loading) return <h1>Loading...</h1>

    let amountArr = [];
    if (product.amount > 99) {
        amountArr = [...Array(100).keys()]
        amountArr.splice(0, 1)
    } else if (product.amount > 0) {
        amountArr = [...Array(product.amount + 1).keys()]
        amountArr.splice(0, 1)
    } else {
        amountArr = [0]
    }

    const stock = () => {
        if (product.amount < 1) {
            return (
                <p id='outOfStockPTagCart'>
                    {`Out of Stock.`}
                </p>
            )
        } else if (product.amount < 31) {
            return (
                <p id='almostOutPTagCart'>
                    {`Only ${product.amount} left in stock - order soon!`}
                </p>
            )

        } else {
            return (
                <p id='inStockPTagCart'>
                    {`In Stock.`}
                </p>
            )
        }
    }

    const inStock = (
        <select value={selected} id='quantitySelectCart' onChange={(e) => {
            e.preventDefault();
            const value = e.target.value;
            setSelected(value)
            dispatch(updateCartItem({ ...cartItem, quantity: value }))
        }}>
            {amountArr.map(num => <option key={num} className={`quantityOption`} value={num}>{`Qnt. ${num}`}</option>)}
        </select>
    )
    const total = parseFloat(product.price) * parseInt(cartItem.quantity)
    
    return (
        <div id='containerForCartItemCartPage'>
            <img id='imageOnCartPage' src={require(`../../images/${product.image}`)} alt={`${product.name}`} />
            <div id='right-side-box'>
                <p id='productTitle'>{product.name}</p>
                <div id='priceDivCartPage'>
                    <p id='dollarSignCartPage'>$</p>
                    <p id='priceH3CartPage'>{formatWithCommas(Math.floor(total))}</p>
                    <p id='priceCentsCartPage'>{`${Math.floor((total % 1) * 100) === 0 ? '00' : Math.floor((total % 1) * 100)}`}</p>
                </div>
                {stock()}
                <div id='crudButtons' >
                    {inStock}

                    <button id='deleteItem' onClick={() => {
                        dispatch(deleteCartItem(cartItem.id))
                        setClickedDel(true)
                    }}>Delete</button>
                </div>
            </div>
        </div>
    )

}

export default CartItemBox;
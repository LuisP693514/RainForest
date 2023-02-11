import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { getCategories, fetchCategories } from "../../store/category";
import { fetchProducts, getProducts } from "../../store/product";
import Carousel from "../Carousel";
import CategoryHeader from "../CategoryHeader";
import Navigation from "../Navigation";
import ProductBox from "../ProductBox";
import "./HomePage.css"

const HomePage = () => {

    const dispatch = useDispatch()
    const categoriesArr = useSelector(getCategories)
    const categories = categoriesArr[categoriesArr.length - 1] || []

    const productsArr = useSelector(getProducts)
    const products = productsArr[productsArr.length - 1] || []
    const productsShuffled = shuffleArray(products)
    productsShuffled.splice(8)
    useEffect(() => {
        dispatch(fetchCategories())
        dispatch(fetchProducts())
    }, [dispatch])

    return (
        <>
            <Navigation />
            <CategoryHeader/>
            <main id='mainBody'
                style={{ height: window.innerHeight }}>
                <div id="backgroundDiv">
                    <div id="topPartOfBG">

                        <img id='forestImage' src={require('../../images/rainforestbg.jpg')} alt='forest' />
                        <div id='gridDiv'>
                            {productsShuffled.map(pId => <ProductBox productId={pId} key={pId} />)}
                        </div>
                    <div id='cat1Carousel'>
                        <Carousel products={productsArr} />
                    </div>
                    </div>
                </div>
            </main>
        </>
    )
}

function shuffleArray(a) {
    const array = [...a];
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}

export default HomePage;
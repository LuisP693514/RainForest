import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { fetchProducts, getProducts } from "../../store/product";
import Carousel from "../Carousel";
import CategoryHeader from "../CategoryHeader";
import FooterNav from "../FooterNav";
import Navigation from "../Navigation";
import ProductBox from "../ProductBox";
import "./HomePage.css"

const HomePage = () => {

    const dispatch = useDispatch()

    const productsArr = useSelector(getProducts)
    const products2 = productsArr.slice(0, -1) || []
    const products = productsArr[productsArr.length - 1] || []
    const productsShuffled = shuffleArray(products)
    productsShuffled.splice(8)
    useEffect(() => {
        dispatch(fetchProducts())
    }, [dispatch])

    const arrId1Id2Id6Id7 = []
    const arrOtherOne = []

    products2.forEach(prod => {
        if (prod.categoryId === 1 ||
            prod.categoryId === 2 ||
            prod.categoryId === 6 ||
            prod.categoryId === 7) {
            arrId1Id2Id6Id7.push(prod)
        }
    })

    products2.forEach(prod => {
        if (prod.categoryId === 3 ||
            prod.categoryId === 4 ||
            prod.categoryId === 5 ||
            prod.categoryId === 8) {
            arrOtherOne.push(prod)
        }
    })

    return (
        <>
            <Navigation />
            <CategoryHeader />
            <div id='mainBody'>
                <div id="backgroundDiv">
                    <div id="topPartOfBG">
                        <img id='forestImage' src={require('../../images/rainforestbg.jpg')} alt='forest' />
                        <h1 id='top8random'>Explore 8 Random Picks:</h1>
                        <div id='gridDiv'>
                            {productsShuffled.map(pId => <ProductBox productId={pId} key={pId} />)}
                        </div>
                        <h2 id='exploreOurCatalog'>Explore the Forest</h2>
                        <div id='cat1Carousel'>
                            <Carousel products={arrId1Id2Id6Id7} />
                        </div>
                        <h3 id='exploreOurCatalog'>Prepare for The Forest</h3>
                        <div id='cat1Carousel'>
                            <Carousel products={arrOtherOne} />
                        </div>
                    </div>
                </div>
            </div>
            <FooterNav />
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
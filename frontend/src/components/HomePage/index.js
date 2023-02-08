import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { getCategories, fetchCategories } from "../../store/category";
import Navigation from "../Navigation";
import ProductBox from "../ProductBox";
import "./HomePage.css"

const HomePage = () => {

    const dispatch = useDispatch()
    const categoriesArr = useSelector(getCategories)
    const categories = categoriesArr[categoriesArr.length-1] || []

    useEffect(() => {
        dispatch(fetchCategories())
    }, [dispatch])

    return (
        <>
            <Navigation />
            <div id="backgroundDiv">
                <div id='gridDiv'>
                    {categories.map(categoryId => <ProductBox key={`outside-${categoryId}`} categoryId={categoryId}/>)}
                </div>
            </div>
        </>
    )
}

export default HomePage;
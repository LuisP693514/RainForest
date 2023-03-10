import { useEffect, useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Redirect, useParams } from 'react-router-dom/cjs/react-router-dom.min';
import { fetchCategories, fetchCategory, getCategory } from '../../store/category';
import { fetchProducts, getProducts } from '../../store/product';
import CategoryHeader from '../CategoryHeader';
import CategoryProductBox from '../CategoryProductBox';
import Navigation from '../Navigation';
import './CategoryShowPage.css'
import { filterProducts } from '../../utils/helperFunctions.js';
import FooterNav from '../FooterNav';

const CategoryShowPage = () => {

    const dispatch = useDispatch();
    const products = useSelector(getProducts);
    const productsCopy = products ? [...products] : []
    // const productsArr = productsCopy.splice(productsCopy.length - 1, 1)

    const { categoryId } = useParams();
    const category = useSelector(getCategory(categoryId))

    const [loadingCats, setLoadingCats] = useState(true)
    const [loadingProds, setLoadingProds] = useState(true)


    useEffect(() => {
        dispatch(fetchCategories())
        dispatch(fetchProducts())
            .then(() => setLoadingProds(false))
        dispatch(fetchCategory(categoryId))
            .then(() => setLoadingCats(false))

    }, [dispatch, categoryId])

    if (loadingCats || loadingProds) return <p>Loading...</p>
    if (!loadingProds && !loadingCats && !category) return <Redirect to='/category_does_not_exist' />

    const filteredProds = filterProducts(productsCopy, categoryId)
    return (
        <>
            <Navigation />
            <CategoryHeader />
            <div id='theWholeBackground'>
                <h1 id='catHeaderH1'>{category.category}</h1>
                <div id='motherOfAllDivs'>
                    {filteredProds.map(prodObj =>
                        <div id='productInsideTheCategory' key={`product-${prodObj.id}`}>
                            <CategoryProductBox product={prodObj} />
                        </div>
                    )}
                </div>
            </div>
            <FooterNav />

        </>
    )
}

export default CategoryShowPage;
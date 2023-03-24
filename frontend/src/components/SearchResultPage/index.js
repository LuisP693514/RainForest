import { useEffect } from 'react';
import { useDispatch } from 'react-redux';
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';
import { fetchProducts } from '../../store/product';
import CategoryHeader from '../CategoryHeader';
import CategoryProductBox from '../CategoryProductBox';
import Navigation from '../Navigation';
import './SearchResultPage.css'

const SearchResultPage = () => {

    const dispatch = useDispatch();
    const history = useHistory();
    const products = history?.location?.state?.products
    const searchTerm = history?.location?.state?.searchTerm

    useEffect(() => {
        dispatch(fetchProducts());
    }, [dispatch])

    return (
        <>
            <Navigation />
            <CategoryHeader />
            <h1 id='resultsHeader'>Results for "{searchTerm}"</h1>
            <div id='motherOfAllDivs'>
                {products.map(prodObj =>
                    <div id='productInsideTheCategory' key={`product-${prodObj.id}`}>
                        <CategoryProductBox product={prodObj} />
                    </div>
                )}
            </div>
        </>
    )

}

export default SearchResultPage;
import { useState } from 'react';
import { useSelector } from 'react-redux';
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';
import { getCategories } from '../../store/category';
import { getProducts } from '../../store/product';
import './SearchBar.css'

const SearchBar = () => {

    const history = useHistory();
    const categories = useSelector(getCategories)
    const realCategories = categories?.length ? categories.slice(0, -1) : [];
    const products = useSelector(getProducts)
    const realProducts = products?.length ? products.slice(0, -1) : [];
    const [searchTerm, setSearchTerm] = useState('')

    const handleSearchSubmit = (e) => {
        e.preventDefault();
        let arrayOfFilteredProducts = [];
        const select = e.target.querySelector('select');
        const categoryId = parseInt(select.value);
        if (categoryId === -1) {
            for (let i = 0; i < realProducts.length; i++) {
                const product = realProducts[i];
                if (product.name.toLowerCase().includes(searchTerm.toLowerCase())) {
                    arrayOfFilteredProducts.push(product)
                }
            }
        } else {
            for (let i = 0; i < realProducts.length; i++) {
                const product = realProducts[i];
                if (product.name.toLowerCase().includes(searchTerm.toLowerCase()) && product.categoryId === categoryId) {
                    arrayOfFilteredProducts.push(product)
                }
            }
        }

        history.push('/searchResult', { products: arrayOfFilteredProducts, searchTerm: searchTerm })
        window.location.reload();
    }

    return (
        <form id='searchBarForm' onSubmit={handleSearchSubmit}>
            <select id='searchBarDropDown'>
                <option value={-1}>All</option>
                {realCategories.map(category => {
                    return <option key={category.id} value={category.id}>{category.category}</option>
                })}
            </select>
            <input
                id='searchBarInput'
                value={searchTerm}
                onChange={(e) => {
                    setSearchTerm(e.target.value)
                }}
                placeholder="Search RainForest"
            />
            <button type='submit'><i className="fa-solid fa-magnifying-glass"></i></button>
        </form>
    )

}

export default SearchBar;
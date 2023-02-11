import { useDispatch, useSelector } from 'react-redux'
import { getCategories, fetchCategories } from "../../store/category";
import { useEffect, useState } from 'react';
import { Link } from "react-router-dom/cjs/react-router-dom.min";
import './CategoryHeader.css'

const CategoryHeader = () => {

    const dispatch = useDispatch()
    const categoriesArr = useSelector(getCategories)
    const categories = categoriesArr[categoriesArr.length - 1] || []
    const [loading, setLoading] = useState(true)
    
    const categoryObjs = categories.map(catId => {
        return categoriesArr[catId - 1]
    });
    
    useEffect(() => {
        dispatch(fetchCategories())
            .then(() => {
                setLoading(false)
            })
    }, [dispatch])

    if (loading) return (<p>Loading...</p>)
    return (
        <div id='entireBar'>
            {categoryObjs.map(catObj =>
                <Link key={catObj.id} className={'categoryNav'} to={`/categories/${catObj.id}`}>
                    <p>

                        {catObj.category}
                    </p>
                </Link>)}
        </div>
    )

}


export default CategoryHeader;
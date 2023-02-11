import './PageNotFound.css'
import Navigation from '../Navigation';
const PageNotFound = () => {

    return (
        <>
            <Navigation />
            <h1 id='h1-404'>404 me no exist :/</h1>
            <a id='link to home page' href='/'>Lets go home</a>
        </>
    )

}

export default PageNotFound;
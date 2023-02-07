import './SearchBar.css'

const SearchBar = () => {

    return (
        <form id='searchBarForm'>
            <select id='searchBarDropDown'></select>
            <input id='searchBarInput'></input>
            <button id='searchBarSubmitButton'></button>
        </form>
    )

}

export default SearchBar;
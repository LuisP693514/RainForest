import './FooterNav.css'

const FooterNav = () => {

    return (
        <div id='bottomOfTheBarrel'>
            <div id='inBetweenTags'>

                <a id='footerLinkTags' href='https://www.linkedin.com/in/luis-perez-5baa4695/' target={"_blank"}>
                    <img id='gitHubHomePage' src={require(`../../images/linkedInLogo.png`)} alt='' />
                </a>
                <a id='footerLinkTags' href='https://github.com/LuisP693514/RainForest' target={"_blank"}>
                    <img id='gitHubHomePage' src={require(`../../images/gitHubLogo.png`)} alt='' />
                </a>
                {/* <Link id='footerLinkTags' to='/'>
                    <img id='gitHubHomePage' src={require(`../../images/linkedInLogo.png`)} alt=''/>
                </Link> */}
            </div>

        </div>
    )
}

export default FooterNav;
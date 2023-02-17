import { Link } from 'react-router-dom';
import './FooterNav.css'

const FooterNav = () => {


    return (
        <div id='bottomOfTheBarrel'>
            <div id='inBetweenTags'>

                <Link id='footerLinkTags' to='/'>
                    <img id='gitHubHomePage' src={require(`../../images/linkedInLogo.png`)} alt=''/>
                </Link>
                <Link id='footerLinkTags' to='/'>
                    <img id='gitHubHomePage' src={require(`../../images/gitHubLogo.png`)} alt=''/>
                </Link>
                {/* <Link id='footerLinkTags' to='/'>
                    <img id='gitHubHomePage' src={require(`../../images/linkedInLogo.png`)} alt=''/>
                </Link> */}
            </div>

        </div>
    )
}

export default FooterNav;
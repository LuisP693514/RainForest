import { Redirect, useHistory } from 'react-router-dom/cjs/react-router-dom.min';
import './ConfirmationPage.css';
import { generateNumber } from '../../utils/helperFunctions';
import Navigation from '../Navigation';
import CategoryHeader from '../CategoryHeader';

const ConfirmationPage = ({ }) => {

    // todo: make a confirmation page

    const history = useHistory();
    const confirm = history?.location?.state?.confirm || false;

    const confirmationNumber = generateNumber();

    if (!confirm) return <Redirect to={'/'} />

    return (
        <>
            <Navigation />
            <CategoryHeader />

            <div id='orderNumberContainer'>

                <h1 id='h1'>{'Order placed, thanks!'}</h1>
                <div id="number">{`Order Number: ${confirmationNumber}`}</div>

            </div>

            <div id='thanks'>Thank you for shopping with RainForest!</div>
            <i id='disclaimer'>Disclaimer: This is not a real website and nothing will get delivered to your home.</i>
        </>
    )

}

export default ConfirmationPage;
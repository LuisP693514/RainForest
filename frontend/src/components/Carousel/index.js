import './Carousel.css'
import React from 'react';
import { CarouselProvider, Slider, Slide, ButtonBack, ButtonNext } from 'pure-react-carousel';
import 'pure-react-carousel/dist/react-carousel.es.css';
import ProductBox from '../ProductBox';

const Carousel = ({ products }) => {

    const productsArr = [...products] || []
    productsArr.splice(productsArr.length-1, 1)

    return (
        <CarouselProvider 
            id='daddyCarouselContainer'
            naturalSlideWidth={1440}
            naturalSlideHeight={400}
            totalSlides={3}
        >
            <Slider id='sliderContaier'>
                {productsArr.map(product => <Slide><ProductBox key={product.id} productId={product.id}/></Slide>)}
            </Slider>
            <ButtonBack id='backButtonCarousel'>backButton</ButtonBack>
            <ButtonNext id='forwardButtonCarousel'>forward!!!!</ButtonNext>
        </CarouselProvider>
    )

}

export default Carousel;
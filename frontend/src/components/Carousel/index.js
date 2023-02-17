import './Carousel.css'
import React from 'react';
import { CarouselProvider, Slider, Slide, ButtonBack, ButtonNext } from 'pure-react-carousel';
import 'pure-react-carousel/dist/react-carousel.es.css';
import ProductBox from '../ProductBox';

const Carousel = ({ products }) => {

    const productsArr = [...products] || []

    return (
        <CarouselProvider
            id='daddyCarouselContainer'
            naturalSlideWidth={150}
            naturalSlideHeight={100}
            totalSlides={Math.ceil(products.length / 5)}
            style={{ background: '#f7f7f7' }}
        >
            <ButtonBack id='backButtonCarousel'>{"<"}</ButtonBack>
            <Slider id='sliderContaier'>
                {
                    productsArr.map(product => <Slide key={product.id} style={{ background: 'blue', width: '250px', margin: "0px 20px" }} className='slideBox'><ProductBox key={product.id} productId={product.id} /></Slide>)
                }
            </Slider>

            <ButtonNext id='forwardButtonCarousel'>{">"}</ButtonNext>
        </CarouselProvider>
    )

}

export default Carousel;
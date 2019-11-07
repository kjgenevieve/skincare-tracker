import React, { Component } from 'react';
import IngredientProductTable from '../components/IngredientProductTable';

export default class IncludedIn extends Component {
    separateProductReviews = () => {
        let reviews = this.props.userProductReviews.userProductReviews;
        let positive = [];
        let negative = [];
        let neutral = [];
        
        if (reviews) {
            reviews.map((review) => {
                let rating = review.user_notes.rating
                
                if (rating === 1 || rating === 2) {
                    negative.push(review)
                } else if (rating === 3) {
                     neutral.push(review)
                } else if (rating === 4 || rating === 5) {
                     positive.push(review)
                } else {
                    // Product is unrated
                }
            })
        }
        
        return (
            <div>
                <h2>Positive</h2>
                <IngredientProductTable reviews={positive}/>

                <h2>Negative</h2>
                <IngredientProductTable reviews={negative}/>

                <h2>Neutral</h2>
                <IngredientProductTable reviews={neutral}/>
            </div>
        )
    }
    
    render() {
        return (
            <div>
                {this.separateProductReviews()}
            </div>
        )
    }
}
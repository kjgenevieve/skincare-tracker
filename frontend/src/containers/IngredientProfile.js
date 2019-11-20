import React, { Component } from 'react';
import PageTitle from '../components/PageTitle';
import Message from '../components/Message'
import IncludedIn from './IncludedIn'

export default class IngredientProfile extends Component {
    constructor() {
        super();
        this.state = {
            ingredient: {},
            userProductReviews: {}
        }
    }

    componentDidMount() {
        this.getIngredientsProducts()
    }

    getIngredientsProducts = () => {
        let userId = 1
        let ingredientId = window.location.pathname.split("/").pop()
        
        fetch(`http://localhost:3000/users/${userId}/ingredients/${ingredientId}`)
        .then(res => res.json())
        .then(data => this.destructureData(data))
    }

    destructureData = (data) => {
        let ingredient = {
            id: data.ingredient_id,
            name: data.name,
            como_rating: data.como_rating
        }
        let userProductReviews = {
            userProductReviews: data.user_product_reviews
        }
        this.setNewState(ingredient, userProductReviews)
    }


    setNewState = (ingredient, userProductReviews) => {
        this.setState({
            ingredient: ingredient,
            userProductReviews: userProductReviews
        })
    }
    
    render() {
        return (
            <div>
                <PageTitle location="ingredient profile" ingredientName={this.state.ingredient.name}/>

                <Message />
                <IncludedIn
                    userProductReviews={this.state.userProductReviews}
                    ingredient={this.state.ingredient}
                />
            </div>
        )
    }
}
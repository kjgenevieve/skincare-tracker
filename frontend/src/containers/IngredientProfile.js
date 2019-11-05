import React, { Component } from 'react';
import Message from '../components/Message'
import IncludedIn from './IncludedIn'

export default class IngredientProfile extends Component {
        // This is a case where I should be making an api call instead of mix and matching.
        // This isn't a bennyhannas; we need to do as much of the information synthesizing as possible on the backend
        // So, what I'll do instead, is make a new API endpoint that allows me to pass in a user id and an ingredient id, and in response get an object sort of like this:
            // {ingredient:
                //     id: 
                //     name: 
                //     products:
                //         {
                //             id: 
                //             name:
                //             blahblah:
                //         }
                // }
       
        // Once I have that info back, I can set state HERE in this component, filter through the products to pass into good/bad/neutral, and everything will be BEAUTIFUL



    constructor() {
        super();
        this.state = {
            currentIngredient = {},
            ingredientsProducts = []
        }
    }

    componentDidMount() {
        this.getIngredientsProducts()
    }

    getIngredientsProducts = () => {
        let userId = 13
        let ingredientId = this.props.match.params.id
        
        fetch(url)
        .then(res => res.json())
        .then(data => )
    }
    
    // SHOW OR PASS INFORMATION


    
    render() {
        return (
            <div>
                    IngredientProfile

                    <Message />
                    <IncludedIn
                        // products={this.state.ingredientsProducts}
                    />
            </div>
        )
    }
}
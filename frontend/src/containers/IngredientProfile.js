import React, { Component } from 'react';
import Message from '../components/Message'
import IncludedIn from './IncludedIn'

export default class IngredientProfile extends Component {
    render() {
        return (
            <div>
                    IngredientProfile
                    <Message />
                    <IncludedIn />
            </div>
        )
    }
}
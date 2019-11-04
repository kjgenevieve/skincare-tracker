import React, { Component } from 'react';
import Message from '../components/Message'
import IncludedIn from './IncludedIn'

export default class IngredientProfile extends Component {
    componentDidMount() {
        this.props.handleIngredientClick(this.props.match.params.id);
    }
    
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
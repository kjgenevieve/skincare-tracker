import React, { Component } from 'react';
import { BrowserRouter as Router, Link } from 'react-router-dom';

export default class NavBar extends Component {
    render() {
        return (
            <div>
                    <ul>
                        <li>
                            <Link to="/">Home</Link>
                        </li>
                        <li>
                            <Link to="/products">Products</Link>
                        </li>
                        <li>
                            <Link to="/ingredients">Ingredients</Link>
                        </li>
                    </ul>

            </div>
        )
    }
}
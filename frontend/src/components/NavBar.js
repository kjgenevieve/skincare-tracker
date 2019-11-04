import React, { Component } from 'react';
import { Link } from 'react-router-dom';

export default class NavBar extends Component {
    
    
    render() {
        return (
            <div>
                    <ul>
                        <li>
                            <Link to="/">Home</Link>
                        </li>
                        <li>
                            <Link to="/products">
                                <button type="button">
                                    Products
                                </button>
                            </Link>
                            {/* <button
                                onClick={(event) => console.log(event.target)}
                                link
                            >
                                PRODUCTS
                            </button> */}
                            
                            
                        </li>
                        <li>
                            <Link to="/ingredients">Ingredients</Link>
                        </li>
                    </ul>

            </div>
        )
    }
}
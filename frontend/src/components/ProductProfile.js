import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import PageTitle from './PageTitle';
import ProductIngredients from './ProductIngredients';
import ReactTable from 'react-table';
import 'react-table/react-table.css';
import checkmark from '../assets/checkmark.svg'

export default class ProductProfile extends Component {
    constructor() {
        super();
        this.state = {
            product: {},
            productReview: {},
            ingredients: []
        }
    }

    componentDidMount() {
        this.getData();
    }

    getData = () => {
        let userId = 13
        let productId = window.location.pathname.split("/").pop()
        const urls = [
            `http://localhost:3000/products/${productId}/`,
            `http://localhost:3000/users/${userId}/user_products`
        ]
        
        Promise.all(
            urls.map(url =>
                fetch(url)
                .then(resp => resp.json())
            )
        )
        .then(data => this.destructureData(data))
    }

    destructureData = (data) => {
        let product = data[0]
        let ingredients = product.ingredients
        let allReviews = data[1]
        this.findProductReview(product, ingredients, allReviews)
    }

    findProductReview = (product, ingredients, allReviews) => {
        let productReview = {}
        allReviews.map ((review) => {
            if (review.product.id === product.id) {
                productReview = review
            }
        })
        
        this.setNewState(product, ingredients, productReview)
    }

    setNewState = (product, ingredients, productReview) => {
        this.setState({
            product: product,
            productReview: productReview,
            ingredients: ingredients
        })
    }
    
    render() {
        return (
            <div>
                <PageTitle location="product profile" productBrand={this.state.product.brand} productName={this.state.product.name} productImage={this.state.product.img_url}/>
                <div>
                    <div>
                        <b>Brand: </b> {this.state.product.brand}
                    </div>
                    <div>
                        <b>Product: </b> {this.state.product.name}
                    </div>
                    <div>
                        <b>Category: </b> {this.state.product.category}
                    </div>
                    <div>
                        <b>SPF: </b> {this.state.product.spf}
                    </div>
                    <div>
                        <b>PA: </b> {this.state.product.pa}
                    </div>
                </div>
                <div>
                    <div>
                        <b>Rating: </b> {this.state.productReview.rating}
                    </div>
                    <div>
                        <b>Current: </b> {this.state.productReview.current}
                    </div>
                    <div>
                        <b>Wishlist: </b> {this.state.productReview.wishlist}
                    </div>
                    <div>
                        <b>Caused Acne: </b> {this.state.productReview.caused_acne}
                    </div>
                    <div>
                        <b>Notes: </b> {this.state.productReview.notes}
                    </div>
                </div>
                <ProductIngredients ingredients={this.state.ingredients}/>
            </div>
        )
    }
}
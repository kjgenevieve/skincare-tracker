import React, { Component } from 'react';
import { Link, Redirect, withRouter } from 'react-router-dom';
import { Button, Confirm } from 'semantic-ui-react';
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
            ingredients: [],
            open: false,
            toProductsPage: false
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

    // Delete button functions
    open = () => this.setState({ open: true })
    close = () => this.setState({ open: false })
    
    handleConfirmDelete = () => {
        let product_review_id = this.state.productReview.id
        fetch(`http://localhost:3000/user_products/${product_review_id}`, {
            method: "DELETE",
            headers: {
                "Content_Type": "application/json",
                Accept: "application/json"
            }
        })
        .then(response => {
            if (response.ok) {
                return response => response.json();
            } else {
                throw new Error("Network response was not ok.");
            }
          })
        .then(
            this.setState(() => ({
                toProductsPage: true
            }))
        )
        .catch(error => console.log(error.message));
    }
    
    render() {
        if (this.state.toProductsPage === true) {
            return <Redirect to='/products' />
        }
        return (
            <div>
                <PageTitle location="product profile" productBrand={this.state.product.brand} productName={this.state.product.name} productImage={this.state.product.img_url}/>
                <Button 
                    as={ Link } to={`/addtoshelf/${this.state.product.id}`}
                    className="ui button"
                >
                    Add to Shelf
                </Button>
                <Button onClick={this.open}>
                    Delete from Shelf
                </Button>
                <Confirm
                    open={this.state.open}
                    onCancel={this.close}
                    onConfirm={this.handleConfirmDelete}
                />
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
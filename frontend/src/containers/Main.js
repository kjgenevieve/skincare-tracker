import React, { Component } from 'react';
import { Route } from 'react-router-dom';
import ProductTable from '../components/ProductTable'
import IngredientProfile from './IngredientProfile'

export default class Main extends Component {
    constructor() {
        super();
        this.state = {
            usersProducts: []
        }
    }

    componentDidMount() {
        const user_id = 13
        const urls = [
            `http://localhost:3000/users/${user_id}`,
            'http://localhost:3000/user_products'
        ];

        Promise.all(urls.map(url =>
            fetch(url)
                .then(resp => resp.json())
                .catch(error => console.log('There was a problem!', error))
            ))
            .then(data => this.getProductIds(data))
    };

    getProductIds = (data) => {
        let userProductObjects = data[1];
        let productIds = data[0].user_products.map (product => product.product_id)
        
        this.getUserProducts(productIds, userProductObjects)
    };

    getUserProducts = (ids, objects) => {
        let userProducts = []
        ids.map (userProductId => {    
            return userProducts = [...userProducts, objects.find(userProduct => userProduct.product.id === userProductId)]
        })
        this.setUsersProducts(userProducts)
    };

    setUsersProducts = (products) => {
        this.setState({
            usersProducts: products
        })
    }
    
    render() {
        return (
            <div>
                Main Container.
                    <Route
                        exact
                        path="/products"
                        render={(props) => (
                            <ProductTable
                                {...props}
                                products={this.state.usersProducts}
                            />
                        )}
                    />
                    {/* <Route
                         exact
                         path ="/ingredients"
                         render={ () => <IngredientsTable /> }
                     /> */}
                    <Route
                         path ="/ingredients/:id"
                         render={ () => <IngredientProfile /> }
                    />
            </div>
        )
    }
}
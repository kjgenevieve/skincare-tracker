import React, { Component } from "react";
import { Route } from "react-router-dom";
import Home from '../components/Home';
import ProductTable from "../components/ProductTable";
import ProductProfile from "../components/ProductProfile";
import AddToShelf from "../components/AddToShelf";
import AddEditProduct from "../components/AddEditProduct";
import IngredientsTable from "../components/IngredientsTable";
import IngredientProfile from "./IngredientProfile";

export default class Main extends Component {
  constructor() {
    super();
    this.state = {
      allProducts: [],
      usersProducts: [],
      usersIngredients: [],
      currentIngredient: {}
    };
  }

  componentDidMount() {
    const user_id = 13;
    const urls = [
      `http://localhost:3000/users/${user_id}`,
      "http://localhost:3000/user_products",
      "http://localhost:3000/product_ingredients",
      "http://localhost:3000/products"
    ];

    Promise.all(
      urls.map(url =>
        fetch(url)
          .then(resp => resp.json())
          .catch(error => console.log("There was a problem!", error))
      )
    ).then(data => this.getProductIds(data));
  }

  getProductIds = data => {
    let userProductObjects = data[1];
    let allIngredients = data[2];
    let allProducts = data[3];
    let productIds = data[0].user_products.map(product => product.product_id);

    this.getUserProducts(productIds, userProductObjects, allIngredients, allProducts);
  };

  getUserProducts = (ids, objects, allIngredients, allProducts) => {
    let userProducts = [];
    ids.map(userProductId => {
      return (userProducts = [
        ...userProducts,
        objects.find(userProduct => userProduct.product.id === userProductId)
      ]);
    });
    this.getUserIngredients(ids, userProducts, allIngredients, allProducts);
  };

  getUserIngredients = (ids, userProducts, allIngredients, allProducts) => {
    let rawIngredients = [];
    ids.map(userProductId => {
      return (rawIngredients = [
        ...rawIngredients,
        allIngredients.filter(
          ingredient => ingredient.product.id === userProductId
        )
      ]);
    });

    rawIngredients = rawIngredients.flat();
    let userIngredients = [];
    let userIngIds = [];

    rawIngredients.map(rawIngredient => {
      if (userIngIds.includes(rawIngredient.ingredient.id)) {
      } else {
        userIngIds = [...userIngIds, rawIngredient.ingredient.id];
        userIngredients = [...userIngredients, rawIngredient];
      }
      return userIngredients;
    });

    this.setNewState(userProducts, userIngredients, allProducts);
  };

  setNewState = (userProducts, ingredients, allProducts) => {
    this.setState({
      usersProducts: userProducts,
      usersIngredients: ingredients,
      allProducts: allProducts
    });
  };

  render() {
    return (
      <div>
        <Route
          exact
          path="/"
          render={() => (
            <Home />
          )}
        />
        <Route
          exact
          path="/products"
          render={props => (
            <ProductTable {...props} products={this.state.usersProducts} />
          )}
        />
        <Route
          exact
          path="/products/:id"
          render={(props) => (
            <ProductProfile {...props} />
          )}
        />
        <Route
          exact
          path="/addtoshelf"
          render={props => (
            <AddToShelf {...props} products={this.state.allProducts} usersProducts={this.state.usersProducts}/>
          )}
        />
        <Route
          exact
          path="/addtoshelf/:product_id"
          render={props => (
            <AddEditProduct {...props} products={this.state.allProducts} usersProducts={this.state.usersProducts}/>
          )}
        />
        <Route
          exact
          path="/ingredients"
          render={props => (
            <IngredientsTable
              {...props}
              ingredients={this.state.usersIngredients}
            />
          )}
        />
        <Route
          path="/ingredients/:id"
          render={() => (
            <IngredientProfile
              // {...props}
            //   onSetCurrentIngredient={this.setCurrentIngredient}
            //   ingredient={this.state.currentIngredient}
            />
          )}
        />
      </div>
    );
  }
}

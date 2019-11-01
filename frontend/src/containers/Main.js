import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import ProductTable from '../components/ProductTable'
import Message from '../components/Message'
import IncludedIn from './IncludedIn'

export default class Main extends Component {
    render() {
        return (
            <div>
                Main Container. I hold shit together.
                    <Route
                        exact
                        path="/products"
                        render={() => <ProductTable />}
                    />
                     {/* <Route
                         exact
                         path ="/ingredients"
                         render={ () => <IngredientsTable /> }
                     /> */}
                     <Route
                         path ="/ingredients/:id"
                         render={ () => <Message /> }
                     />
                     <Route
                         path ="/ingredients/:id"
                         render={ () => <IncludedIn /> }
                     />
            </div>
        )
    }
}
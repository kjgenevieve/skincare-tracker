import React, { Component } from 'react';
import ProductTable from '../components/ProductTable';

export default class IncludedIn extends Component {
    render() {
        return (
            <div>
                INCLUDEDIN...
                <ProductTable />
                <ProductTable />
                <ProductTable />
            </div>
        )
    }
}
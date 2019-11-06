import React, { Component } from 'react';
import ProductTable from '../components/ProductTable';

export default class IncludedIn extends Component {
    componentDidMount() {
        // Can view in COMPONENTS chrome add on, but not by console.log
        console.log(this.props)
    }
    
    render() {
        return (
            <div>
                INCLUDEDIN...
                {/* <ProductTable />
                <ProductTable />
                <ProductTable /> */}
            </div>
        )
    }
}
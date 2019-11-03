import React, { Component } from 'react';
import ReactTable from 'react-table'
import 'react-table/react-table.css'

export default class ProductTable extends Component {
  constructor() {
    super();
    this.state = {
      productDisplay: []
    }
  }

  componentDidUpdate(prevProps) {
    // console.log(
    //   "prevProps.products=",
    //   prevProps.products
    // );
    // console.log(
    //   "this.props.products in cDU=",
    //   this.props.products
    // );
    if (
      this.props.products.length !==
      prevProps.products.length
    ) {
      // console.log("Cdu logic fires");
      this.formatData(this.props.products)
    }
  }
  
  formatData = (products) => {
    let productData = []

    products.map ((product) => {
      return productData = [...productData,
        {
          "id": product.id,
          "current": product.current,
          "rating": product.rating,
          "wishlist": product.wishlist,
          "opened": product.opened,
          "expires": product.expires,
          "caused_acne": product.caused_acne,
          "notes": product.notes,
          "product": {
            "brand": product.product.brand,
            "name": product.product.name,
            "category": product.product.category,
            "img_url": product.product.img_url,
            "sunscreen_type": product.product.sunscreen_type,
            "spf": product.product.spf,
            "pa": product.product.pa,
          }
        }
      ]
    })
    this.setProductDisplayState(productData)
  }

  setProductDisplayState = (productData) => {
    if (productData.length > 0) {
      this.setState({
        productDisplay: productData
      })
    }
  }
  
  render() {
    const columns = [{
      Header: 'Image',
      accessor: 'product.img_url'
    }, {
      Header: 'Brand',
      accessor: 'product.brand',
    }, {
      Header: 'Name',
      accessor: 'product.name'
    }, {
      Header: 'Category',
      accessor: 'product.category'
    }, {
      Header: 'Sunscreen',
      columns: [{
          Header: 'Type',
          accessor: 'product.sunscreen_type',
          width: 60,
      }, {
          Header: 'SPF',
          accessor: 'product.spf',
          width: 45,
      }, {
          Header: 'PA',
          accessor: 'product.pa',
          width: 45,
      }]
  }, {
      Header: 'Current',
      accessor: 'current'
    }, {
      Header: 'Wishlist',
      accessor: 'wishlist'
    }, {
      Header: 'Rating',
      accessor: 'rating'
    }, {
      Header: 'Opened',
      accessor: 'opened'
    }, {
      Header: 'Expires',
      accessor: 'expires'
    }, {
      Header: 'Notes',
      accessor: 'notes'
    }
  ]
 
    return <ReactTable
      data={this.state.productDisplay}
      columns={columns}
      filterable={true}
      defaultFilterMethod={(filter, row, column) => {
        const id = filter.pivotId || filter.id
        return row[id] !== undefined ? String(row[id]).includes(filter.value) : true}
      }
    />
  }

}
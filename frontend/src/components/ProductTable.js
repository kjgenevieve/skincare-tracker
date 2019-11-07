import React, { Component } from 'react';
import PageTitle from './PageTitle';
import ReactTable from 'react-table';
import 'react-table/react-table.css';
import checkmark from '../assets/checkmark.svg'

export default class ProductTable extends Component {
  formatData = (products) => {
    let productData = []
    
    if (products) {
      products.map ((product) => {
        if (product.current === true) {
          product.current = <img src={checkmark} height="25" alt={product.id}/>
        }
        if (product.wishlist === true) {
          product.wishlist = <img src={checkmark} height="25" alt={product.id}/>
        }
        if (product.caused_acne === true) {
          product.caused_acne = <img src={checkmark} height="25" alt={product.id}/>
        }

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
              "img_url": <img src={product.product.img_url} height="100" alt={product.id}/>,
              "sunscreen_type": product.product.sunscreen_type,
              "spf": product.product.spf,
              "pa": product.product.pa,
            }
          }
        ]
      })
    } else {
      console.log("Data not being received (ProductTable.js)")
    }
    return productData
  }
  
  render() {
    
    const columns = [{
      Header: 'Image',
      accessor: 'product.img_url',
      width: 115
    }, {
      Header: 'Brand',
      accessor: 'product.brand',
      width: 100
    }, {
      Header: 'Name',
      accessor: 'product.name',
      style: { 'whiteSpace': 'unset' },
      width: 175
    }, {
      Header: 'Category',
      accessor: 'product.category',
      width: 100
    }, {
      Header: 'Rating',
      accessor: 'rating',
      style: { 'text-align': 'center' },
      width: 60
  }, {
      Header: 'Current',
      accessor: 'current',
      style: { 'text-align': 'center' },
      width: 60
    }, {
      Header: 'Want',
      accessor: 'wishlist',
      style: { 'text-align': 'center' },
      width: 60
    }, {
      Header: 'Acne',
      accessor: 'caused_acne',
      style: { 'text-align': 'center' },
      width: 60
    }, {
    //   Header: 'Opened',
    //   accessor: 'opened',
    //   width: 75
    // }, {
    //   Header: 'Expires',
    //   accessor: 'expires',
    //   width: 75
    // }, {
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
          style: { 'whiteSpace': 'unset' },
          width: 45,
      }]
    }, {
      Header: 'Notes',
      accessor: 'notes',
      style: { 'whiteSpace': 'unset' },
      // width: 175,
    }
  ]

    return (
      <div>
        <PageTitle location="products"/>
        <ReactTable
          data={this.formatData(this.props.products)}
          columns={columns}
          defaultPageSize={20}
          noDataText="Rate products to see them here."
          style={{
            height: "600px" // This will force the table body to overflow and scroll, since there is not enough room
          }}
          className="-striped -highlight"
          filterable={true}
          defaultFilterMethod={(filter, row, column) => {
            const id = filter.pivotId || filter.id
            return row[id] !== undefined ? String(row[id]).includes(filter.value) : true}
          }
        />
        <center><p><i>Tip: Hold shift when sorting to sort by multiple columns!</i></p></center>
      </div>
    )
  }
}
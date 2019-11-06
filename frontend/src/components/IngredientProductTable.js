import React, { Component } from 'react';
import ReactTable from 'react-table'
import 'react-table/react-table.css'

export default class IngredientProductTable extends Component {
  formatData = (reviews) => {
    let reviewData = []
    if (reviews) {
        reviews.map ((review) => {
            console.log(review)
        
            return reviewData = [...reviewData,
                {
                    "id": review.user_notes.id,
                    "current": review.user_notes.current,
                    "rating": review.user_notes.rating,
                    "wishlist": review.user_notes.wishlist,
                    "opened": review.user_notes.opened,
                    "expires": review.user_notes.expires,
                    "caused_acne": review.user_notes.caused_acne,
                    "notes": review.user_notes.notes,
                    "product": {
                      "brand": review.product.brand,
                      "name": review.product.name,
                      "category": review.product.category,
                      "img_url": review.product.img_url,
                      "sunscreen_type": review.product.sunscreen_type,
                      "spf": review.product.spf,
                      "pa": review.product.pa,
                    }
                }
            ]
        })
    } else {
      console.log("Data not being received (IngredientProductTable.js)")
    }
    return reviewData
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
      data={this.formatData(this.props.reviews)}
      columns={columns}
      defaultPageSize={5}
      style={{
        height: "300px" // This will force the table body to overflow and scroll, since there is not enough room
      }}
      className="-striped -highlight"
      filterable={true}
      defaultFilterMethod={(filter, row, column) => {
        const id = filter.pivotId || filter.id
        return row[id] !== undefined ? String(row[id]).includes(filter.value) : true}
      }
    />
  }
}
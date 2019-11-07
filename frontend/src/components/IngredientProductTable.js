import React, { Component } from 'react';
import ReactTable from 'react-table'
import 'react-table/react-table.css';
import checkmark from '../assets/checkmark.svg';

export default class IngredientProductTable extends Component {
  formatData = (reviews) => {
    let reviewData = []
    if (reviews) {
        reviews.map ((review) => {
          if (review.user_notes.current === true) {
            review.user_notes.current = <img src={checkmark} height="25" alt={review.user_notes.id}/>
          }
          if (review.user_notes.wishlist === true) {
            review.user_notes.wishlist = <img src={checkmark} height="25" alt={review.user_notes.id}/>
          }
          if (review.user_notes.caused_acne === true) {
            review.user_notes.caused_acne = <img src={checkmark} height="25" alt={review.user_notes.id}/>
          }
          
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
                      "img_url": <img src={review.product.img_url} height="100" alt={review.user_notes.id}/>,
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
    //   accessor: 'expires'
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
      accessor: 'notes'
    }
  ]

    return (
      <div>
        <ReactTable
          data={this.formatData(this.props.reviews)}
          columns={columns}
          defaultPageSize={5}
          noDataText="No products for this category."
          style={{
            height: "450px" // This will force the table body to overflow and scroll, since there is not enough room
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
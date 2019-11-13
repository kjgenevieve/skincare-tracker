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
            review.user_notes.current = "Yes"
          } else if (review.user_notes.current === false) {
            review.user_notes.current = "No"
          } else {
             // eslint-disable-next-line
            review.user_notes.current = review.user_notes.current
          }

          if (review.user_notes.wishlist === true) {
            review.user_notes.wishlist = "Yes"
          } else if (review.user_notes.wishlist === false) {
            review.user_notes.wishlist = "No"
          } else {
             // eslint-disable-next-line
            review.user_notes.wishlist = review.user_notes.wishlist
          }

          if (review.user_notes.caused_acne === true) {
            review.user_notes.caused_acne = "Yes"
          } else if (review.user_notes.caused_acne === false) {
            review.user_notes.caused_acne = "No"
          } else {
             // eslint-disable-next-line
            review.user_notes.caused_acne = review.user_notes.caused_acne
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
  
  filterCaseInsensitive = (filter, row) => {
    const id = filter.pivotId || filter.id;
    const content = row[id];
    if (typeof content !== 'undefined') {  
      // filter by text in the table or if it's a object, filter by key
        if (typeof content === 'object' && content !== null && content.props.children) {
          // console.log(content)
          return String(content.props.children).toLowerCase().includes(filter.value.toLowerCase());
        } else {
          // console.log("content", content)
            return String(content).toLowerCase().includes(filter.value.toLowerCase());
        }
    }
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
      style: { 'textAlign': 'center' },
      width: 60
    }, {
      Header: 'Current',
      accessor: 'current',
      style: { 'textAlign': 'center' },
      width: 60,
       // eslint-disable-next-line
      Cell: ({ value }) => (value === "No" ? "" : <img src={checkmark} height="25" />),
      filterMethod: (filter, row) => {
        if (filter.value === "all") {
          return true;
        }
        if (filter.value === "true") {
          return row[filter.id] === "Yes";
        }
        return row[filter.id] === "No";
      },
      Filter: ({ filter, onChange }) =>
        <select
          onChange={event => onChange(event.target.value)}
          style={{ width: "100%" }}
          value={filter ? filter.value : "all"}
        >
          <option value="all">All</option>
          <option value="true">Currently in Use</option>
          <option value="false">Not in Use</option>
        </select>
    }, {
      Header: 'Want',
      accessor: 'wishlist',
      style: { 'textAlign': 'center' },
      width: 60,
       // eslint-disable-next-line
      Cell: ({ value }) => (value === "No" ? "" : <img src={checkmark} height="25" />),
      filterMethod: (filter, row) => {
        if (filter.value === "all") {
          return true;
        }
        if (filter.value === "true") {
          return row[filter.id] === "Yes";
        }
        return row[filter.id] === "No";
      },
      Filter: ({ filter, onChange }) =>
        <select
          onChange={event => onChange(event.target.value)}
          style={{ width: "100%" }}
          value={filter ? filter.value : "all"}
        >
          <option value="all">All</option>
          <option value="true">Wishlist</option>
          <option value="false">Not on Wishlist</option>
        </select>
    }, {
      Header: 'Acne',
      accessor: 'caused_acne',
      style: { 'textAlign': 'center' },
      width: 60,
       // eslint-disable-next-line
      Cell: ({ value }) => (value === "No" ? "" : <img src={checkmark} height="25" />),
      filterMethod: (filter, row) => {
        if (filter.value === "all") {
          return true;
        }
        if (filter.value === "true") {
          return row[filter.id] === "Yes";
        }
        return row[filter.id] === "No";
      },
      Filter: ({ filter, onChange }) =>
        <select
          onChange={event => onChange(event.target.value)}
          style={{ width: "100%" }}
          value={filter ? filter.value : "all"}
        >
          <option value="all">All</option>
          <option value="true">Caused Acne</option>
          <option value="false">Didn't Cause Acne</option>
        </select>
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
          defaultFilterMethod={this.filterCaseInsensitive}
          defaultSorted={[
            {
              id: "current",
              desc: true
            }
          ]}
        />
        <center><p><i>Tip: Hold shift when sorting to sort by multiple columns!</i></p></center>
      </div>
    )
  }
}
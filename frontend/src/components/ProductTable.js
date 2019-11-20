import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import PageTitle from './PageTitle';
import ReactTable from 'react-table';
import 'react-table/react-table.css';
import checkmark from '../assets/checkmark.svg'

export default class ProductTable extends Component {
  formatData = (usersProductReviews) => {
    let productData = []
    if (usersProductReviews) {
      usersProductReviews.product_reviews.map ((productReview) => {
        let product = productReview.product
        let review = productReview.user_review

        // Format so checkmarks will render
        if (review.current === true) {
          review.current = "Yes"
        } else if (review.current === false) {
          review.current = "No"
        } else {
           // eslint-disable-next-line
          review.current = review.current
        }

        if (review.wishlist === true) {
          review.wishlist = "Yes"
        } else if (review.wishlist === false) {
          review.wishlist = "No"
        } else {
           // eslint-disable-next-line
          review.wishlist = review.wishlist
        }

        if (review.caused_acne === true) {
          review.caused_acne = "Yes"
        } else if (review.caused_acne === false) {
          review.caused_acne = "No"
        } else {
           // eslint-disable-next-line
          review.caused_acne = review.caused_acne
        }

        return productData = [...productData,
          {
            "id": product.id,
            "current": review.current,
            "rating": review.rating,
            "wishlist": review.wishlist,
            "opened": review.opened,
            "expires": review.expires,
            "caused_acne": review.caused_acne,
            "notes": review.notes,
            "product": {
              "brand": product.brand,
              "name": <Link to={`/products/${product.id}`}>{product.name}</Link>,
              "category": product.category,
              "img_url": <img src={product.img_url} height="100" alt={product.id}/>,
              "sunscreen_type": product.sunscreen_type,
              "spf": product.spf,
              "pa": product.pa,
            }
          }
        ]
      })
    } else {
      console.log("Data not being received (ProductTable.js)")
    }
    return productData
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
          console.log("content", content)
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
      Cell: ({ value }) => (value === "No" ? "" : <img src={checkmark} height="25"/>),
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
        <Link 
          to="/addtoshelf"
          name="Add to Shelf"
        >
          Add a New Product to Your Shelf
        </Link>
        <ReactTable
          data={this.formatData(this.props.usersProductReviews)}
          columns={columns}
          defaultPageSize={20}
          noDataText="Rate products to see them here."
          style={{
            height: "600px" // This will force the table body to overflow and scroll, since there is not enough room
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
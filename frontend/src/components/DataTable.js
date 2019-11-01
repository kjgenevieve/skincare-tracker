import React, { Component } from 'react';
import ReactTable from 'react-table'
import 'react-table/react-table.css'


export default class DataTable extends Component {
    render() {
    const data = [
        {
            "id": 41,
            "current": false,
            "rating": 4,
            "wishlist": false,
            "opened": null,
            "expires": null,
            "caused_acne": false,
            "notes": "A little harsh and drying.",
            "user": {
              "id": 13,
              "name": "Genevieve",
              "goals": null,
              "concern_1": null,
              "concern_2": null,
              "concern_3": null,
              "loved_ing": null,
              "avoid_ing": null,
              "created_at": "2019-10-30T18:19:02.890Z",
              "updated_at": "2019-10-30T18:19:02.894Z"
            },
            "product": {
              "id": 56,
              "brand": "Neutrogena",
              "name": "Oil-Free Acne Wash Pink Grapefruit Facial Cleanser",
              "category": "cleanser",
              "img_url": "https://target.scene7.com/is/image/Target/11537188?wid=520&hei=520&fmt=pjpeg",
              "sunscreen_type": null,
              "spf": null,
              "pa": null,
              "created_at": "2019-10-30T18:19:02.898Z",
              "updated_at": "2019-10-30T18:19:02.902Z"
            }
          },
          {
            "id": 42,
            "current": true,
            "rating": 5,
            "wishlist": false,
            "opened": null,
            "expires": null,
            "caused_acne": false,
            "notes": "Holy Grail Cleanser!",
            "user": {
              "id": 13,
              "name": "Genevieve",
              "goals": null,
              "concern_1": null,
              "concern_2": null,
              "concern_3": null,
              "loved_ing": null,
              "avoid_ing": null,
              "created_at": "2019-10-30T18:19:02.890Z",
              "updated_at": "2019-10-30T18:19:02.894Z"
            },
            "product": {
              "id": 57,
              "brand": "Tula",
              "name": "Purifying Face Cleanser",
              "category": "cleanser",
              "img_url": "https://images.ulta.com/is/image/Ulta/2532485?op_sharpen=1&resMode=bilin&qlt=85&wid=800&hei=800&fmt=webp",
              "sunscreen_type": null,
              "spf": null,
              "pa": null,
              "created_at": "2019-10-30T18:19:03.323Z",
              "updated_at": "2019-10-30T18:19:03.326Z"
            }
          },
    ]
     
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
    data={data}
    columns={columns}
    filterable={true}
  />
}

}
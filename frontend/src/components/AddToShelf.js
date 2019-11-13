import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { Button } from 'semantic-ui-react';
import PageTitle from './PageTitle';
import ReactTable from 'react-table';
import 'react-table/react-table.css';

export default class AddToShelf extends Component {
    formatData = (products, usersProducts) => {
        // console.log(products)
        let productData = []
        let usersProductIds = []
        if (products && usersProducts) {
            usersProducts.map ((product) => {
                return usersProductIds.push(product.product.id)
            })

             // eslint-disable-next-line
            products.map ((product) => {
                if (usersProductIds.includes(product.id)) {
                    console.log("")
                } else {
                    return productData = [...productData,
                        {
                            "id": product.id,
                            "brand": product.brand,
                            "name": product.name,
                            "category": product.category,
                            "img_url": <img src={product.img_url} height="100" alt={product.id}/>,
                            "sunscreen_type": product.sunscreen_type,
                            "spf": product.spf,
                            "pa": product.pa,
                            "add": <Button
                                as={ Link } to={`/addtoshelf/${product.id}`}
                                className="ui button"
                                >
                                    Add to Shelf
                                </Button>
                        }
                    ]
                }
            })
        } else {
            console.log("Data not being received (ProductTable.js)")
        }
        return productData
    }
    
    //   filterCaseInsensitive = (filter, row) => {
    //     const id = filter.pivotId || filter.id;
    //     const content = row[id];
    //     if (typeof content !== 'undefined') {  
    //       // filter by text in the table or if it's a object, filter by key
    //         if (typeof content === 'object' && content !== null && content.props.children) {
    //           // console.log(content)
    //           return String(content.props.children).toLowerCase().includes(filter.value.toLowerCase());
    //         } else {
    //           console.log("content", content)
    //             return String(content).toLowerCase().includes(filter.value.toLowerCase());
    //         }
    //     }
    //   }

  render() {
    const columns = [{
        Header: 'Image',
        accessor: 'img_url',
        width: 115
      }, {
        Header: 'Brand',
        accessor: 'brand',
        width: 100
      }, {
        Header: 'Name',
        accessor: 'name',
        style: { 'whiteSpace': 'unset' },
        width: 175
      }, {
        Header: 'Category',
        accessor: 'category',
        width: 100
      }, {
        Header: 'Sunscreen',
        columns: [{
            Header: 'SPF',
            accessor: 'spf',
            width: 45,
        }, {
            Header: 'PA',
            accessor: 'pa',
            style: { 'whiteSpace': 'unset' },
            width: 45,
        }]
      }, {
        Header: 'Add Product',
        accessor: 'add',
      }
    ]
  
    return (
      <div>
            <PageTitle location="addtoshelf" />
            <ReactTable
                data={this.formatData(this.props.products, this.props.usersProducts)}
                columns={columns}
                defaultPageSize={20}
                noDataText="Loading..."
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
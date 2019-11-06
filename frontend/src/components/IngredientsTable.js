import React, { Component } from 'react';
import { Link } from 'react-router-dom'
import ReactTable from 'react-table'
import 'react-table/react-table.css'

export default class IngredientsTable extends Component {
  
  formatData = (ingredients) => {
    let ingredientData = ingredients.map ((ingredient) => {
      return {
          "ingredient": <Link to={`/ingredients/${ingredient.ingredient.id}`}>{ingredient.ingredient.name}</Link>,
          "como_rating": ingredient.ingredient.como_rating,
        }
    })
    return ingredientData
  }

  render() {
    const columns = [{
      Header: 'Ingredient',
      accessor: 'ingredient'
    }, {
      Header: 'Comodogenic Rating',
      accessor: 'como_rating',
    }
  ]
 
    return <ReactTable
      data={this.formatData(this.props.ingredients)}
      columns={columns}
      defaultPageSize={50}
      style={{
        height: "600px" // This will force the table body to overflow and scroll, since there is not enough room
      }}
      className="-striped -highlight"
      filterable={false}
      defaultFilterMethod={(filter, row, column) => {
        const id = filter.pivotId || filter.id
        return row[id] !== undefined ? String(row[id]).includes(filter.value) : true}
      }
    />
  }

}
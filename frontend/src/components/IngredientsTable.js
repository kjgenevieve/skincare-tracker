import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import PageTitle from './PageTitle';
import ReactTable from 'react-table';
import 'react-table/react-table.css';

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

  filterCaseInsensitive = (filter, row) => {
    const id = filter.pivotId || filter.id;
    const content = row[id];
    if (typeof content !== 'undefined') {
      // console.log(content)
      // filter by text in the table or if it's a object, filter by key
        if (typeof content === 'object' && content !== null && content.props.children) {
          return String(content.props.children).toLowerCase().includes(filter.value.toLowerCase());          
        } else {
            return String(content).toLowerCase().includes(filter.value.toLowerCase());
        }
    }

    return true;
  };

  sortMethod = (a, b, desc) => {
    // force undefined to the bottom
    a = a === undefined ? '' : a
    b = b === undefined ? '' : b
    
    if (a !== null || b !== null) {
      // force null to the bottom
      a = a === null ? '' : a
      b = b === null ? '' : b

      // force any string values to lowercase
      a = typeof a === 'string' ? a.toLowerCase() : a
      b = typeof b === 'string' ? b.toLowerCase() : b
      
      // change objects to strings
      a = typeof a === 'object' ? a = a.props.children : a
      b = typeof b === 'object' ? b = b.props.children : b

      // change numbers to strings
      a = typeof a === 'number' ? a.toString() : a
      b = typeof b === 'number' ? b.toString() : b
      
      // Return either 1 or -1 to indicate a sort priority
      if (a > b) {
        return 1
      }
      if (a < b) {
        return -1
      }
      // returning 0, undefined or any falsey value will use subsequent sorts or
      // the index as a tiebreaker
      return 0
    }
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
  
    return (
      <div>
        <PageTitle location="ingredients" />
        <ReactTable
          data={this.formatData(this.props.ingredients)}
          columns={columns}
          defaultPageSize={50}
          style={{
            height: "600px" // This will force the table body to overflow and scroll, since there is not enough room
          }}
          className="-striped -highlight"
          filterable={true}
          defaultFilterMethod={this.filterCaseInsensitive}
          defaultSortMethod={this.sortMethod}
          defaultSorted={[
            {
              id: "ingredient",
              asc: true
            }
          ]}
        />
      </div>
    )
  }

}
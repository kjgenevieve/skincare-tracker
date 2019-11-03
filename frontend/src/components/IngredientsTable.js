import React, { Component } from 'react';
import ReactTable from 'react-table'
import 'react-table/react-table.css'

export default class IngredientsTable extends Component {
  constructor() {
    super();
    this.state = {
      ingredientDisplay: []
    }
  }

  componentDidUpdate(prevProps) {
    // console.log(
    //   "prevProps.ingredients=",
    //   prevProps.ingredients
    // );
    // console.log(
    //   "this.props.ingredients in cDU=",
    //   this.props.ingredients
    // );
    if (
      this.props.ingredients.length !==
      prevProps.ingredients.length
    ) {
      // console.log("Cdu logic fires");
      this.formatData(this.props.ingredients)
    }
  }
  
  formatData = (ingredients) => {
    let ingredientData = []
    ingredients.map ((ingredient) => {
      return ingredientData = [...ingredientData,
        {
          "ingredient": ingredient.ingredient.name,
          "como_rating": ingredient.ingredient.como_rating,
        }
      ]
    })
    this.setIngredientDisplayState(ingredientData)
  }

  setIngredientDisplayState = (ingredientData) => {
    if (ingredientData.length > 0) {
      this.setState({
        ingredientDisplay: ingredientData
      })
    }
  }
  
  render() {
    const columns = [{
      Header: 'Ingredient',
      accessor: 'ingredient'
    }
    // , {
    //   Header: 'Comodogenic Rating',
    //   accessor: 'como_rating',
    // }
  ]
 
    return <ReactTable
      data={this.state.ingredientData}
      columns={columns}
      filterable={true}
      defaultFilterMethod={(filter, row, column) => {
        const id = filter.pivotId || filter.id
        return row[id] !== undefined ? String(row[id]).includes(filter.value) : true}
      }
    />
  }

}
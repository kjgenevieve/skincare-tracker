import React, { Component } from 'react';
import { Grid, Header, Image } from 'semantic-ui-react';
import homeIcon from '../assets/user_profile.png';
import productsIcon from '../assets/products.svg';
import ingredientsIcon from '../assets/ingredients.svg';
import ingredientProfileIcon from '../assets/ingredient_profile.svg';


export default class PageTitle extends Component {
    findLocation = () => {
        let location = this.props.location;
        let icon = ""
        let greeting = ""
        let circle = false
        
        if (location) {
            if (location === "home") {
                // console.log(location)
                icon = homeIcon;
                greeting = "Welcome, Genevieve";
                circle = true
            } else if (location === "products") {
                // console.log(location)
                icon = productsIcon;
                greeting = "Products";
            } else if (location === "ingredients") {
                // console.log(location)
                icon = ingredientsIcon;
                greeting = "Ingredients";
            } else if (location === "ingredient profile") {
                // console.log(location)
                icon = ingredientProfileIcon;
                greeting = this.props.ingredientName;
            } else {
                console.log("Default")
            }
        }
        
        return (
            <div className="pageTitle">
                <Header as="h1">
                    <Grid>
                        <Grid.Column width={4}>
                            <Image circular={circle} src={icon} height="150" />
                        </Grid.Column>
                        <Grid.Column width={8} verticalAlign='middle'>
                            <div className="page title">{greeting}</div>
                        </Grid.Column>
                    </Grid>
                </Header>
            </div>
        )
    }
    
    render() {
        return (
            <div>
                {this.findLocation()}
            </div>
        )
    }
}

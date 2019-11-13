import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { Menu } from 'semantic-ui-react';

export default class NavBar extends Component {
    state = {}
    handleItemClick = (e, { name }) => this.setState({ activeItem: name })

    
    render() {
        const { activeItem } = this.state

        return (
            <div>
                <Menu>
                    <Menu.Item
                        as={ Link } to="/"
                        name="Skincare Tracker"
                        active={activeItem === 'Skincare Tracker'}
                        onClick={this.handleItemClick}
                    >
                    </Menu.Item>

                    <Menu.Menu position='right'>
                        <Menu.Item
                            as={ Link } to="/products"
                            name="Products"
                            active={activeItem === 'Products'}
                            onClick={this.handleItemClick}
                            position="right"
                        >
                        </Menu.Item>

                        <Menu.Item
                            as={ Link } to="/ingredients"
                            name="Ingredients"
                            active={activeItem === 'ingredients'}
                            onClick={this.handleItemClick}
                            position="right"
                        >
                        </Menu.Item>
                    </Menu.Menu>
                </Menu>

            </div>
        )
    }
}
import React, { Component } from 'react';
import { Form } from 'semantic-ui-react';
import PageTitle from './PageTitle';
import ProductDetails from './ProductDetails';
import 'react-table/react-table.css';

export default class AddEditProduct extends Component {
    state = {
        product: {},
        user_id: null,
        product_id: null,
        current: null,
        rating: null,
        wishlist: null,
        opened: null,
        expires: null,
        caused_acne: null,
        notes: null
    }

    componentDidMount() {
        this.getProductDetails()
    }

    getProductDetails = () => {
        if (this.props.match.params.product_id !== null) {
            let product_id = this.props.match.params.product_id
            fetch(`http://localhost:3000/products/${product_id}`)
            .then(res => res.json())
            .then(data => this.setState({product: data}))
        }
    }

    handleChange = (e, d) => {
        this.setState({ [d.name]: d.value })
    }

    handleSubmit = () => {
        fetch("http://localhost:3000/user_products", {
            method: "POST",
            headers: {
                "Content_Type": "application/json",
                Accept: "application/json"
            },
            body: JSON.stringify({
                "current": this.state.current,
                "rating": this.state.rating,
                "wishlist": this.state.wishlist,
                "opened": null,
                "expires": null,
                "caused_acne": this.state.caused_acne,
                "notes": this.state.notes,
                "user_id": 13,
                "product_id": this.props.match.params.product_id,
            })
        })
            .then(res => res.json())
            .then(console.log)
    }

  render() {
    const { current, rating, wishlist, caused_acne } = this.state
  
    return (
      <div>
            <PageTitle location="addtoshelf" />
            <ProductDetails product={this.state.product}/>
            <Form onSubmit={this.handleSubmit}>
                <Form.Group>
                    <label>Rating</label>
                    <Form.Radio
                        label='1'
                        name="rating"
                        value={1}
                        checked={rating === 1}
                        onChange={this.handleChange}
                    />
                    <Form.Radio
                        label='2'
                        name="rating"
                        value={2}
                        checked={rating === 2}
                        onChange={this.handleChange}
                    />
                    <Form.Radio
                        label='3'
                        name="rating"
                        value={3}
                        checked={rating === 3}
                        onChange={this.handleChange}
                    />
                    <Form.Radio
                        label='4'
                        name="rating"
                        value={4}
                        checked={rating === 4}
                        onChange={this.handleChange}
                    />
                    <Form.Radio
                        label='5'
                        name="rating"
                        value={5}
                        checked={rating === 5}
                        onChange={this.handleChange}
                    />
                </Form.Group>
                <Form.Group>
                    <label>Are you currently using this product?</label>
                    <Form.Radio
                        label='Yes'
                        name="current"
                        value={true}
                        checked={current === true}
                        onChange={this.handleChange}
                    />
                    <Form.Radio
                        label='No'
                        name="current"
                        value={false}
                        checked={current === false}
                        onChange={this.handleChange}
                    />
                </Form.Group>
                <Form.Group>
                    <label>Is this product on your wishlist?</label>
                    <Form.Radio
                        label='Yes'
                        name="wishlist"
                        value={true}
                        checked={wishlist === true}
                        onChange={this.handleChange}
                    />
                    <Form.Radio
                        label='No'
                        name="wishlist"
                        value={false}
                        checked={wishlist === false}
                        onChange={this.handleChange}
                    />
                </Form.Group>
                <Form.Group>
                    <label>Did this product cause acne?</label>
                    <Form.Radio
                        label='Yes'
                        name="caused_acne"
                        value={true}
                        checked={caused_acne === true}
                        onChange={this.handleChange}
                    />
                    <Form.Radio
                        label='No'
                        name="caused_acne"
                        value={false}
                        checked={caused_acne === false}
                        onChange={this.handleChange}
                    />
                </Form.Group>
                <Form.Group>
                    <Form.TextArea
                        label="Notes"
                        name="notes"
                        placeholder="Your notes on this product."
                        onChange={this.handleChange}
                    />
                </Form.Group>
                <Form.Button>Submit</Form.Button>
            </Form>
      </div>
    )
  }

}
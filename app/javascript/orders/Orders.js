import React from 'react'
import OrderTable from './OrderTable'

export default class Orders extends React.Component {
  constructor(props) {
    super(props)
    this.state = {orders: [], isLoading: true}
  }

  componentDidMount() {
    fetch('/api/orders.json')
      .then((response) => response.json())
      .then((json) => this.setState({orders: json, isLoading: false}))
      .catch((e) => console.log(e))
  }

  render() {
    const {
       isLoading
    } = this.state;
    return isLoading ? <div className="spinner"></div> : <OrderTable orders={this.state.orders} />
  }
}

import React from 'react'
import OrderTable from './OrderTable'

export default class Orders extends React.Component {
  constructor(props) {
    super(props)
    this.state = {orders: []}
  }

  componentDidMount() {
    fetch('/api/orders.json')
      .then((response) => response.json())
      .then((json) => this.setState({orders: json}))
      .catch((e) => console.log(e))
  }

  render() {
    return (
      <OrderTable orders={this.state.orders} />
    )
  }
}

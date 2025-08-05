import React, { useState } from 'react';
import './App.css';

function App() {
  const [order, setOrder] = useState('');

  const handlePlaceOrder = (e) => {
    e.preventDefault();
    alert(`Order placed: ${order}`);
  };

  const handleCheckStatus = () => {
    alert('Order status: Pending...');
  };

  return (
    <div className="App">
      <h1>Welcome to the Order Portal</h1>
      <form onSubmit={handlePlaceOrder}>
        <input
          type="text"
          placeholder="Enter order details"
          value={order}
          onChange={(e) => setOrder(e.target.value)}
        />
        <button type="submit">Place Order</button>
      </form>
      <br />
      <button onClick={handleCheckStatus}>Check Order Status</button>
    </div>
  );
}

export default App;

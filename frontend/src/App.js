import React, { useState, useEffect } from 'react';
import './App.css';
import ExpenseForm from './ExpenseForm';

function App() {
  const [expenses, setExpenses] = useState([]);

  useEffect(() => {
    fetch('/api/expenses')
      .then(response => response.json())
      .then(data => setExpenses(data));
  }, []);

  const addExpense = (expense) => {
    fetch('/api/expenses', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(expense),
    })
    .then(response => response.json())
    .then(newExpense => setExpenses([...expenses, newExpense]));
  };

  const deleteExpense = (id) => {
    fetch(`/api/expenses/${id}`, {
      method: 'DELETE',
    }).then(() => {
      setExpenses(expenses.filter(expense => expense.id !== id));
    });
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Expense Tracker</h1>
      </header>
      <ExpenseForm onNewExpense={addExpense} />
      <table>
        <thead>
          <tr>
            <th>Title</th>
            <th>Amount</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {expenses.map(expense => (
            <tr key={expense.id}>
              <td>{expense.title}</td>
              <td>{expense.amount}</td>
              <td><button onClick={() => deleteExpense(expense.id)}>Delete</button></td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default App;

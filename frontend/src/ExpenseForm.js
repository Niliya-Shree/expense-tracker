import React, { useState } from 'react';

function ExpenseForm({ onNewExpense }) {
    const [title, setTitle] = useState('');
    const [amount, setAmount] = useState('');

    const handleSubmit = (e) => {
        e.preventDefault();
        onNewExpense({ title, amount });
        setTitle('');
        setAmount('');
    };

    return (
        <form onSubmit={handleSubmit}>
            <div>
                <label>Title</label>
                <input type="text" value={title} onChange={(e) => setTitle(e.target.value)} />
            </div>
            <div>
                <label>Amount</label>
                <input type="number" value={amount} onChange={(e) => setAmount(e.target.value)} />
            </div>
            <button type="submit">Add Expense</button>
        </form>
    );
}

export default ExpenseForm; 
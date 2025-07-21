package com.example.expensetracker.controller;

import com.example.expensetracker.model.Expense;
import com.example.expensetracker.repository.ExpenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:3000")
public class ExpenseController {

    @Autowired
    private ExpenseRepository expenseRepository;

    @GetMapping("/expenses")
    public List<Expense> getExpenses() {
        return expenseRepository.findAll();
    }

    @DeleteMapping("/expenses/{id}")
    public ResponseEntity<?> deleteExpense(@PathVariable Long id) {
        expenseRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
     @PostMapping("/expenses")
    public ResponseEntity<Expense> createExpense(@RequestBody Expense expense) throws URISyntaxException {
        Expense savedExpense = expenseRepository.save(expense);
        return ResponseEntity.created(new URI("/api/expenses/" + savedExpense.getId())).body(savedExpense);
    }
} 
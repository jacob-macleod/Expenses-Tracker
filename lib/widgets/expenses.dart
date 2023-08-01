import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      amount: 10.99,
      title: "Groceries",
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "New shoes",
      amount: 99.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _addNewExpense(
      String title, double amount, DateTime date, Category category) {
    final newExpense = Expense(
      amount: amount,
      title: title,
      date: date,
      category: category,
    );

    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(_addNewExpense),
    );
  }

  // Sort registered expenses in reverse order
  get _sortedExpenses => _registeredExpenses.reversed.toList();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expenses Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(expenses: _sortedExpenses),
          ),
        ],
      ),
    );
  }
}

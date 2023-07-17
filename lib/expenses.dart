import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';

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
  ]

  @override
  Widget build(context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("Hello world"),
        ],
      ),
    );
  }
}

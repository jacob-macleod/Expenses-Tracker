import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {required this.expenses, required this.removeExpense, super.key});
  final List<Expense> expenses;
  final Function(Expense expense) removeExpense;

  @override
  Widget build(context) {
    // ListView.builder is a list view, but where items are only built when they are visible or about to be visible
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.6),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}

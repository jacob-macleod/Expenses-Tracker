import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:flutter/rendering.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addNewExpense, {super.key});
  final Function addNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      // showDatePicker returns a future variable - a variable that will be available in the future when a date is selected
      // So this code is run when showDatePicker returns a value some time in the future
      // We could use async and await instead, and for the above line a few lines above, change it to:
      // final selectedDate = await showDatePicker(
    ).then((value) {
      setState(() {
        _selectedDate = value;
      });
    });
  }

  void _submitExpenseData() {
    // Validate the entered expense data
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Please enter corect details"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    widget.addNewExpense(
      _titleController.text,
      enteredAmount,
      _selectedDate!,
      _selectedCategory,
    );

    Navigator.pop(context);
  }

  // Delete controller when it is not needed
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text("Title"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  // Expanded here because TextField is a child of Row and needs to take up all avaliable space but is constrained bny parent row
                  child: TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      label: Text("Amount"),
                      prefixText: "\$ ",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                // Expanded here because a row within a row would cause problems - child row wants to take up all avaliable space but is constrained by the parent row
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? "No date chosen"
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                        onPressed: _presentDatePicker,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text("Save Expense"),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ],
        ));
  }
}

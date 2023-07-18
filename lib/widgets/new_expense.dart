import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

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
    ).then((value) {});
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
        padding: const EdgeInsets.all(16),
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
                      const Text("Selected Date"),
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
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    print(_titleController.text);
                    print(_amountController.text);
                  },
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

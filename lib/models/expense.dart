import 'package:uuid/uuid.dart';

const uuid = Uuid();

// Create a custom category enum - can only contain certain values
// Values are counted kind of as Strings
enum Category {
  food,
  travel,
  leisure,
  work,
}

class Expense {
  // Constructor function
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    // Sets id when creating a new expense
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}

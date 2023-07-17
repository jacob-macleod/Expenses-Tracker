import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

// Create a custom category enum - can only contain certain values
// Values are counted kind of as Strings
enum Category {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.sports_soccer,
  Category.work: Icons.work,
};

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

  String get formattedDate {
    return formatter.format(date);
  }
}

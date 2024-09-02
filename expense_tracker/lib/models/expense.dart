import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

//For generating unique id
const uuid = Uuid();

//utility object for formating dates
final formatter = DateFormat.yMd();

class Expense {
  final String id;
  final String title;
  final double ammount;
  final DateTime dateTime;
  final Category category;

  //Constructor function
  Expense(
      {required this.title,
      required this.ammount,
      required this.dateTime,
      required this.category})
      //Initializing properties using initializer list
      : id = uuid
            .v4(); //Generates a unique id and assign it to the variable 'id'

  String get formatedTime => formatter.format(dateTime);
}

enum Category { food, travel, leisure, work }

final Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.leisure: Icons.movie
};

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  //Name constructor

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            // $ .where()
            // where is a method that allow us to filter a list
            .where(
              //Only getting those category which category is equal to this.category

              (element) => element.category == category,
            )
            .toList();

  ExpenseBucket({required this.category, required this.expenses});

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.ammount;
    }
    return sum;
  }
}

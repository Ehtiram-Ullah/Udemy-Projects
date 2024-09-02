import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  //Storing the expenses
  final List<Expense> expenses;

  final Function(Expense expense) onRemove;
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        // $ Dismissible
        // It is used to remove items form a list by swapping left or right
        return Dismissible(
            background: Container(
              // $ colorScheme.error
              // This will give an error color for our app based on the color we provided in colorScheme
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onRemove(expenses[index]);
            },
            child: ExpenseItem(expense: expenses[index]));
      },
      //Length of the expense list
      itemCount: expenses.length,
    );
  }
}

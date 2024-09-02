import 'package:expense_tracker/screens/add_new_expense_screen.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenses = [
    Expense(
        title: "Buyed a food",
        ammount: 2000,
        dateTime: DateTime(2024),
        category: Category.food),
    Expense(
        title: "Buyed a ticket",
        ammount: 10000,
        dateTime: DateTime(2024),
        category: Category.travel),
    Expense(
        title: "Buyed a laptop",
        ammount: 200000,
        dateTime: DateTime(2024),
        category: Category.work),
    Expense(
        title: "Buyed a game",
        ammount: 1000,
        dateTime: DateTime(2024),
        category: Category.leisure),
    Expense(
        title: "Buyed a game",
        ammount: 1000,
        dateTime: DateTime(2024),
        category: Category.leisure),
    Expense(
        title: "Buyed GTA5",
        ammount: 1000,
        dateTime: DateTime(2024),
        category: Category.leisure),
  ];

  void _addNewExpense({required Expense newExpense}) {
    //Make sures the UI will also update after the change
    setState(() {
      expenses.add(newExpense);
    });
  }

  //Add the 'AddNewExpenseScreen' as a overlay in the top of 'HomeScreen'
  void _openAddExpenseOverlay() {
    // $ showModalBottomSheet
    //Add overlay widget/screen which not gonna take all the screen (by default), instead it gonna take half of the screen (from bottom to center of the screen)
    showModalBottomSheet(
      // $ useSafeArea
      // it make sures that our widget stay away from the device features like camera etc.
      useSafeArea: true,
      isScrollControlled:
          true, // This will ensure that the widget take the full screen
      context: context,
      builder: (context) => AddNewExpenseScreen(
        onTap: _addNewExpense,
      ),
    );
  }

  //Removing a expense from the list
  void _removeExpense(Expense expense) {
    //Index of the expense which we want to remove
    final expenseIndex = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });

    // $ ScaffoldMessenger.of(context).clearSnackBars
    // It is used ro remove all existing snackbars from the screen
    ScaffoldMessenger.of(context).clearSnackBars();

    // $ ScaffoldMessenger
    //ScaffoldMessenger is a utility object which is used for showing or hiding certain UI elements in the screen.
    // in here we are showing a snackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                setState(() {
                  //Inserting back the deleted expense to it's location
                  expenses.insert(expenseIndex, expense);
                });
              }),
          content: const Text("Expense deleted.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // width of current device screen
    final screenWidth = MediaQuery.of(context).size.width;

    //Store the current widget, if there are no expense , it gonna show the first widget else the second
    final Widget currentWidget = expenses.isEmpty
        ? const Center(
            child: Text(
              "No expenses found. Start adding some!",
              style:
                  TextStyle(fontSize: 20, color: Color.fromARGB(101, 0, 0, 0)),
            ),
          )
        : ExpensesList(expenses: expenses, onRemove: _removeExpense);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Expense Tracker",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(
                Icons.add,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: screenWidth < 600
            ? Column(
                children: [
                  Chart(expenses: expenses),
                  Expanded(child: currentWidget)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: expenses)),
                  Expanded(child: currentWidget)
                ],
              ),
      ),
    );
  }
}

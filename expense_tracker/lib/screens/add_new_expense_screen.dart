import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class AddNewExpenseScreen extends StatefulWidget {
  final Function({required Expense newExpense}) onTap;
  const AddNewExpenseScreen({super.key, required this.onTap});

  @override
  State<AddNewExpenseScreen> createState() => _AddNewExpenseScreenState();
}

class _AddNewExpenseScreenState extends State<AddNewExpenseScreen> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;

  //Picked date by user
  DateTime? _pickedDate;

  //Categories
  final categories = Category;

  Category _selectedCategory = Category.leisure;

  //Date picker widget
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month);

    // $ showDatePicker
    // Shows a widget for picking a date
    final date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _pickedDate = date;
    });
  }

  //Validating fields and saving the expense
  void _submitExpense() {
    // $ tryParse
    //Take a string and try to convert it into double, if it can't do it then it gonna return null
    final enteredAmount = double.tryParse(_amountController.text);

    // Checking whether amount is valid or not
    final isAmountValid = enteredAmount == null || enteredAmount <= 0;

    // $ trim
    //Trim gonna trim the whitespace in start and end of the text
    if (_titleController.text.trim().isEmpty ||
        isAmountValid ||
        _pickedDate == null) {
      // $ showDialog
      //Shows a dialog box
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure a valid title, amount and date was entered."),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(ctx), child: const Text("Okay"))
          ],
        ),
      );
      return;
    }

    // $ widget
    //If the inputs are valid, then save the new expense
    widget.onTap(
        newExpense: Expense(
            title: _titleController.text,
            ammount: enteredAmount,
            dateTime: _pickedDate!,
            category:
                _selectedCategory)); // Widget is used to access methods and properties from a class that extends "State class"

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    //Initializng Controllers
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    //Disposing Controllers (for cleaning the memory)
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // $ viewInsets
    //View insets object contains extra information about UI elements
    //that might be overlapping certain parts of the UI. For example,
    //if i we access view insets.bottom,
    //we get those UI elements that are overlapping the UI from the bottom.
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // $ LayoutBuilder
    //LayoutBuilder widget is used to make responsive apps.
    //It tells us about the applied constraints by the parent widget,
    //and the constraints object tells us the minimum and maximum amount of width and height we can use.
    // @ LayoutBuilder does not care about the screen orientation
    // @ it only cares about how much width and height is available for this specific widget (given by parent widget)
    return LayoutBuilder(
      builder: (context, constraints) {
        // Max width allowed by the parent widget
        final maxWidth = constraints.maxWidth;
        return SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                // $ fromLTRB
                padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    keyboardSpace +
                        16), // fromLTRB means (left, top, right , bottm), this gonna add padding on those sides
                child: Column(
                  children: [
                    if (maxWidth >= 600)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              maxLength: 50,
                              decoration:
                                  const InputDecoration(label: Text("Title")),
                              controller: _titleController,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  prefixText: r"$ ", label: Text("Amount")),
                            ),
                          ),
                        ],
                      )
                    else
                      TextField(
                        maxLength: 50,
                        decoration: const InputDecoration(label: Text("Title")),
                        controller: _titleController,
                      ),
                    if (maxWidth >= 600)
                      Row(
                        children: [
                          DropdownButton(
                            //Selected category
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                      //The value is type of category
                                      value: category,
                                      enabled: true,
                                      child: Text(category.name.toUpperCase())),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                          const Spacer(),
                          const Spacer(),
                          Text(_pickedDate != null
                              ? formatter.format(_pickedDate!)
                              : "No Date Selected"),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      )
                    else
                      Row(
                        children: [
                          // Flexible is used to devide the content on passed on screen size 'proportionally'
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  prefixText: r"$ ", label: Text("Amount")),
                            ),
                          ),
                          const Spacer(),
                          Text(_pickedDate != null
                              ? formatter.format(_pickedDate!)
                              : "No Date Selected"),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        if (maxWidth <= 600)
                          DropdownButton(
                            //Selected category
                            value: _selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                      //The value is type of category
                                      value: category,
                                      enabled: true,
                                      child: Text(category.name.toUpperCase())),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: _submitExpense,
                            child: const Text("Save Expense")),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}

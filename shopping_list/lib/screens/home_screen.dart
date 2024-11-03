import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<GroceryItem> _groceryItems = [];

  void _addNewItem({required GroceryItem newItem}) {
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItemScreen()));
    if (newItem == null) return;
    _addNewItem(newItem: newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: _groceryItems.isEmpty
          ? const Center(
              child: Text(
                "No items added yet.",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(174, 160, 155, 155)),
              ),
            )
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) {
                final item = _groceryItems[index];
                return Dismissible(
                  key: ValueKey(item.id),
                  onDismissed: (_) {
                    // _groceryItems.remove();
                    _groceryItems.remove(item);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("Item deleted successfully")));
                  },
                  child: ListTile(
                    leading: Container(
                      width: 20,
                      height: 20,
                      color: item.category.color,
                    ),
                    title: Text(item.name),
                    trailing: Text(item.quantity.toString()),
                  ),
                );
              },
            ),
    );
  }
}

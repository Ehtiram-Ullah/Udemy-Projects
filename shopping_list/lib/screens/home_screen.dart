import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GroceryItem> _groceryItems = [];
  bool isLoading = true;
  String? _error;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'shopping-list-udemy-project-default-rtdb.firebaseio.com',
        'shopping-list.json');

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = "Failed to fetch data. Please try again later";
          isLoading = false;
        });
        return;
      }
      final listData = jsonDecode(response.body);
      if (listData == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      final List<GroceryItem> loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.item == item.value['category'])
            .value;
        loadedItems.add(GroceryItem(
            id: item.key,
            name: item.value["name"],
            quantity: item.value["quantity"],
            category: category));
      }
      setState(() {
        _groceryItems = loadedItems;
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        _error = "Something went wrong! Please try again later";
        isLoading = false;
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItemScreen()));

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _groceryItems.length,
      itemBuilder: (context, index) {
        final item = _groceryItems[index];
        return Dismissible(
          key: ValueKey(item.id),
          onDismissed: (_) async {
            final index = _groceryItems.indexOf(item);
            // _groceryItems.remove();
            setState(() {
              _groceryItems.remove(item);
            });
            final url = Uri.https(
                "shopping-list-udemy-project-default-rtdb.firebaseio.com",
                "shopping-list/${item.id}.json");
            final response = await http.delete(url);
            if (response.statusCode >= 400) {
              setState(() {
                _groceryItems.insert(index, item);
              });
            }
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
    );

    if (_groceryItems.isEmpty) {
      content = const Center(
        child: Text(
          "No items added yet.",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(174, 160, 155, 155)),
        ),
      );
    }

    if (isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_error != null) {
      content = Center(
        child: Text(
          _error!,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(174, 160, 155, 155)),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Groceries"),
          actions: [
            IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
          ],
        ),
        /*
        $ FutureBuilder 
        @ A widget which listens to a future and automatically updates the UI as the future resolves.
        */
        body: content);
  }
}

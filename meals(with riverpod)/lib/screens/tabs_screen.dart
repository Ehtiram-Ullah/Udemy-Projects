import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorite_meals_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filter_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

//$ ConsumerStatefulWidget
//@ A StatefulWidget provided by the Riverpod package, which includes additional functionalities to listen to changes in a Provider object.
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key, this.title});
  final String? title;

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    //@ clearing all existing snackbars
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _setScreen({required String identifier}) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();

    String title = "Categories";
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);

      activePage = MealsScreen(
        favoriteMeals: favoriteMeals,
      );
      title = "Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      // $ bottomNavigationBar
      // It allow to set a bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Star")
        ],
        onTap: _selectPage,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filter_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, this.title});
  final String? title;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

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

  final List<MealModel> _favoriteMeals = [];

  void _toggleMealFavoriteStatus(MealModel meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
        _showInfoMessage("Meal is no longer a favorite.");
        return;
      }
      _favoriteMeals.add(meal);
      _showInfoMessage("Marked as a favorite!");
    });
  }

  void _setScreen({required String identifier}) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      final result = await Navigator.push<Map<Filter, bool>>(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FilterScreen(currentFilters: _selectedFilters),
          ));
      setState(() {
        _selectedFilters = result ?? _selectedFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleMealFavorite: _toggleMealFavoriteStatus,
      selectedFilters: _selectedFilters,
    );

    String title = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        favoriteMeals: _favoriteMeals,
        onToggleMealFavorite: _toggleMealFavoriteStatus,
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

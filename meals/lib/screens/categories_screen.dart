import 'package:flutter/material.dart';
import 'package:meals/models/data/dummy_data.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleMealFavorite});

  final Function(MealModel meal) onToggleMealFavorite;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate:
          // $ SliverGridDelegateWithFixedCrossAxisCount
          // This is just a fancy way of saying that, "i want x ammount of column in the grid"
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // $ childAspectRation
        //childAspectRation will impact the sizing of those GridView items.
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: availableCategories.map((meal) {
        return CategoryGridItem(
          category: meal,
          onToggleMealFavorite: onToggleMealFavorite,
        );
      }).toList(),
    );
  }
}

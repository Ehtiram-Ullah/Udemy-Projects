import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/providers/filter_provider.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({
    super.key,
    this.categoryID,
    this.title,
    this.favoriteMeals,
  });
  final String? categoryID;

  final String? title;

  final List<MealModel>? favoriteMeals;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (categoryID != null) {
      final availableMeals = ref.watch(filterMealsProvider);
      final List<MealModel> filteredMeals = availableMeals
          // $ .where()
          //.where is supported on all lists in dart to filter out data conditionally.
          .where((meal) =>
              meal.categories.any((meal) => meal.contains(categoryID!)))
          .toList();

      return filteredMeals.isEmpty
          ? Center(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Uh oh .. Nothing here!",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Try selecting a different category!",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                )
              ],
            ))
          : ListView.builder(
              itemBuilder: (context, index) {
                final currentMeal = filteredMeals[index];

                return MealItem(
                  meal: currentMeal,
                );
              },
              itemCount: filteredMeals.length,
            );
    }

    return favoriteMeals!.isEmpty
        ? Center(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Uh oh .. Nothing here!",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                "Try adding a meal to favorite!",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              )
            ],
          ))
        : ListView.builder(
            itemBuilder: (context, index) {
              final currentMeal = favoriteMeals![index];

              return MealItem(
                meal: currentMeal,
              );
            },
            itemCount: favoriteMeals!.length,
          );
  }
}

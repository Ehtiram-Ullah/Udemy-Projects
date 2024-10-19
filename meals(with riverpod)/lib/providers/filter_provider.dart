import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterProvider extends StateNotifier<Map<Filter, bool>> {
  FilterProvider()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    /*
    $ ...
     @ This spreads all the current entries from 'state' (existing filters)
     @ into a new map (a copy of the old state) .
     @ (separately)
    */
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterProvider, Map<Filter, bool>>(
  (ref) => FilterProvider(),
);

final filterMealsProvider = Provider((ref) {
  final dummyMeals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
  return dummyMeals.where(
    (meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }

      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }

      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    },
  );
});

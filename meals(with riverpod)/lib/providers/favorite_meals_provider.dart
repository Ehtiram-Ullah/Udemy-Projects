import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal_model.dart';

class FavoriteMealsProvider extends StateNotifier<List<MealModel>> {
  FavoriteMealsProvider() : super([]);

  bool toggleFavoriteMeals(MealModel meal) {
    if (state.contains(meal)) {
      // state.remove(meal);
      //Correct one
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }
    // state.add(meal);
    //Correct one
    state = [...state, meal];
    return true;
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsProvider, List<MealModel>>(
  (ref) => FavoriteMealsProvider(),
);

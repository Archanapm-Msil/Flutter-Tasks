import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';


class FavaroriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavaroriteMealsNotifier() : super([]);

  bool toggleFavoriteMeals(Meal meal) {
     final mealIsFavorite =  state.contains(meal);
      if(mealIsFavorite) {
        state = state.where((mealItem) => mealItem.id != meal.id ).toList();
        return false;
      } else {
           state = [...state,meal];
           return true;
      } 
  }
}

final favoriteMealProvider = StateNotifierProvider<FavaroriteMealsNotifier, List<Meal>>((ref) {
return FavaroriteMealsNotifier();
});

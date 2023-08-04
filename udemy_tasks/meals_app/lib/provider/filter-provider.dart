import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Utils/Constants.dart';
import 'package:meals_app/provider/meals-provider.dart';

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive ;

    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

  final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filterProvider);

 return meals.where((meal) {
      if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilter[Filter.lactoFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
});

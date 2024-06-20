import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_riverpod/models/meal.dart';
import 'package:meals_riverpod/providers/filter_provider.dart';
import 'package:meals_riverpod/providers/meals_provider.dart';

//we need to make the Notifier class which extends the StateNotifier which implements the logic for the Provider
class FavoriteNotifier extends StateNotifier<List<Meal>> {
  FavoriteNotifier() : super([]);

  //here the list passed to the StateNotifier is immutable i.e. we cannot edit or add any new elements to it but we should create a new list
  bool toggleFavoriteMeals(Meal meal) {
    //the state is the list we passed to the class above, we can only pass new list

    var isFavorite = state.contains(meal);

    //if the meal is already in favorite, we need to remove from the list, but we cannot modify the list direcly, hence we need to reassign the list which can be done with
    //where() which helps to check a condition and return a new list
    // print(state);
    if (isFavorite) {
      state = state.where((ml) => ml.id != meal.id).toList();
      // print(state);
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

//instead of using the Provider() we use the StateNotifierProvider. Provider can be used to pass the static data but StateNotifierProvider is helpful in passing the dynamic data which changes
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteNotifier, List<Meal>>(
  (ref) {
    return FavoriteNotifier();
  },
);

//everytime the changes occur in any provider the watch method rexecutes the overall provider if used in another provider as depenedent and if used inside the widget it re-renders the UI if the changes occur in the provider

final filteredAvailableMeals = Provider((ref) {
  
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);

  return meals.where(
    (meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    },
  ).toList();
});

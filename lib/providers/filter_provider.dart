import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter, bool> selectedFilters) {
    state = selectedFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    //we cannot set state[filter]= isActive cause the state here in provider is immutable and must be created new hence, we reassign the previous state with spread operator and then, set the filter to isActive which overrides the previous value,
    state = {...state, filter: isActive};
  }
}

var filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

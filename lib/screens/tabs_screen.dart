import 'package:flutter/material.dart';
import 'package:meals_riverpod/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_riverpod/screens/categories_screen.dart';
import 'package:meals_riverpod/screens/filters_screen.dart';
import 'package:meals_riverpod/screens/meals_screen.dart';
import 'package:meals_riverpod/widgets/my_drawer.dart';
import 'package:meals_riverpod/providers/filter_provider.dart';

final kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _currentPageIndex = 0;

  void _selectPage(var index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  //we can get teh values returned by pop of the filter screen here in the push of FilterScreen
  void onSelectMenuItem(String identifier) async {
    Navigator.pop(context);

    if (identifier == "filter") {
      Navigator.of(context)
          .push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) {
        return const FiltersScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final availableMeals = ref.watch(filteredAvailableMeals);

    Widget activeScreen = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activeTitle = "Categories";

    if (_currentPageIndex == 1) {
      activeScreen = MealsScreen(
        meals: favoriteMeals,
      );
      activeTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MyDrawer(
        onSelectDrawerMenu: onSelectMenuItem,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.food_bank,
                ),
                label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites"),
          ]),
    );
  }
}

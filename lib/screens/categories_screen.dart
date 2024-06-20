import 'package:flutter/material.dart';
import 'package:meals_riverpod/data/dummy_data.dart';
import 'package:meals_riverpod/models/category.dart';
import 'package:meals_riverpod/screens/meals_screen.dart';
import 'package:meals_riverpod/widgets/category_data_item.dart';
import 'package:meals_riverpod/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 0,
      upperBound: 5,
    );
    super.initState();
  }

  void _selectCategory(BuildContext context, Category category) {
    //alternative way
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) =>
    //           const MealsScreen(meals: [], title: "this is the title"),
    //     ));

    final filteredMealList = widget.availableMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList(); //remember to convert to list with .toList()

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MealsScreen(
              meals: filteredMealList,
              title: category.title,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        // ...availableCategories.map((category) => CategoryDataItem(category: category) ,),

        for (var category in availableCategories)
          CategoryDataItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}

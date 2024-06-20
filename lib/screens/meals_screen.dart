import 'package:flutter/material.dart';
import 'package:meals_riverpod/models/meal.dart';
import 'package:meals_riverpod/screens/meal_description.dart';
import 'package:meals_riverpod/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.meals, this.title});

  final String? title;
  final List<Meal> meals;
  

  void _onSelectMealItem(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealDescription(meal: meal),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Oopss nothing here right now!",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "try selecting a different category",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
        ),
      ],
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealItem(
            meal: meals[index],
            onSelectItem: () {
              _onSelectMealItem(context, meals[index]);
            },
          );
        },
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}

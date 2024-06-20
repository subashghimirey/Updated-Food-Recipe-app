import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_riverpod/models/meal.dart';
import 'package:meals_riverpod/providers/favorites_provider.dart';


class MealDescription extends ConsumerWidget {
  const MealDescription({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                var isAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleFavoriteMeals(meal);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: isAdded
                        ? const Text("Added to Favorite")
                        : const Text("Removed from favorite")));
              },
              icon: Icon(isFavorite ? Icons.star : Icons.star_border_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(
            meal.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
          const SizedBox(
            height: 12,
          ),
          Text("Igredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  )),
          const SizedBox(
            height: 8,
          ),
          for (var ingredient in meal.ingredients)
            Text(ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
          const SizedBox(
            height: 16,
          ),
          Text("Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  )),
          const SizedBox(
            height: 8,
          ),
          for (var step in meal.steps)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
        ]),
      ),
    );
  }
}

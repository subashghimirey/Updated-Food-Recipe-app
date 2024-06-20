import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_riverpod/providers/filter_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var activeFilters = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),

      
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text("Glutten-Free",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
            activeColor: Theme.of(context).colorScheme.tertiary,
            subtitle: Text("Only glutten free foods here",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white)),
            contentPadding: const EdgeInsets.only(left: 35, right: 44),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text("Lactose-Free",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
            activeColor: Theme.of(context).colorScheme.tertiary,
            subtitle: Text("Only Lactose free foods here",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white)),
            contentPadding: const EdgeInsets.only(left: 35, right: 44),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text("Vegetarian",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
            activeColor: Theme.of(context).colorScheme.tertiary,
            subtitle: Text("Only Vegetarian foods here",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white)),
            contentPadding: const EdgeInsets.only(left: 35, right: 44),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text("Vegan Foods",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white)),
            activeColor: Theme.of(context).colorScheme.tertiary,
            subtitle: Text("Only Vegan foods here",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white)),
            contentPadding: const EdgeInsets.only(left: 35, right: 44),
          ),
        ],
      ),
    );
  }
}

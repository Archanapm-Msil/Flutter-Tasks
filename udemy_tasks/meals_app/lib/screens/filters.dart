import 'package:flutter/material.dart';
import 'package:meals_app/Utils/Constants.dart';
import 'package:meals_app/provider/filter-provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key,});

  

   

   void _onGlutenFreeChanged(bool newValue, WidgetRef ref) {
    ref.read(filterProvider.notifier).setFilter(Filter.glutenFree, newValue);
  }

  void _onLactoFreeChanged(bool newValue,WidgetRef ref) {
    // setState(() {
    // islactoFree = newValue;
    // });
        ref.read(filterProvider.notifier).setFilter(Filter.lactoFree, newValue);
  }

  void _onVegetarianChanged(bool newValue,WidgetRef ref) {
    // setState(() {
    // isVegetarian = newValue;
    // });
    ref.read(filterProvider.notifier).setFilter(Filter.vegetarian, newValue);

  }

  void _onVeganChanged(bool newValue,WidgetRef ref) {
    // setState(() {
    // isVegan = newValue;
    // });
    ref.read(filterProvider.notifier).setFilter(Filter.vegan, newValue);

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          _buildFilter(Constants.glutenFreeTxt, Constants.glutenFreedesc, ref, context, Filter.glutenFree, (newValue) => _onGlutenFreeChanged(newValue, ref)),
          _buildFilter(Constants.lactoFree, Constants.lactoFreedesc, ref, context, Filter.lactoFree, (newValue) => _onLactoFreeChanged(newValue, ref)),
          _buildFilter(Constants.vegetarianTxt, Constants.vegetarianDesc, ref, context, Filter.vegetarian, (newValue) => _onVegetarianChanged(newValue, ref)),
          _buildFilter(Constants.veganTxt, Constants.veganDesc, ref, context, Filter.vegan, (newValue) => _onVeganChanged(newValue, ref)),
        ],
      ),
    );
  }

  SwitchListTile _buildFilter(
      String title,
      String subtitle,
      WidgetRef ref,
      BuildContext context,
      Filter selectedFilter,
      void Function(bool) onChangedCallback) {
    final activeFilter = ref.watch(filterProvider);
    return SwitchListTile(
      value: activeFilter[selectedFilter]!,
      onChanged: onChangedCallback,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.secondary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}


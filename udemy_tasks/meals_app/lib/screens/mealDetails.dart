import 'package:flutter/material.dart';
import 'package:meals_app/Utils/Constants.dart';
import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favorite-provider.dart';

class MealsDetailsScreen extends ConsumerWidget {
  const MealsDetailsScreen({super.key, required this.meal});

  final Meal meal;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealProvider);

final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(onPressed: (){
             final wasAdded = ref.read(favoriteMealProvider.notifier).toggleFavoriteMeals(meal);
               ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(wasAdded ? Constants.infoMessagefvrt : Constants.infoMessage )),
    );
            }, icon: Icon( isFavorite ? Icons.star : Icons.star_border))
          ],
        ),
        body: ListView(
          children: [_buildMealsColumn(context)],
        ));
  }

  Column _buildMealsColumn(BuildContext context) {
    return Column(
      children: [
        Image.network(
          meal.imageUrl,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 20,
        ),
        _buildMealRecipeScreenTitle(context, Constants.ingredientText),
        const SizedBox(
          height: 14,
        ),
        for (final ingredient in meal.ingredients)
          Text(ingredient,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
        const SizedBox(
          height: 24,
        ),
        _buildMealRecipeScreenTitle(context, Constants.stepTxt),
        for (final steps in meal.steps)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(steps,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
          ),
      ],
    );
  }

  Text _buildMealRecipeScreenTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold),
    );
  }
}

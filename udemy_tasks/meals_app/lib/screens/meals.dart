import 'package:flutter/material.dart';
import 'package:meals_app/Utils/Constants.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/mealDetails.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});
  final String? title;
  final List<Meal> meals;

  String _complexityText(Meal meal) {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String _affordabilityText(Meal meal) {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = meals.isEmpty
        ? _buildEmptyScreen(context)
        : _buildMealsList(context, meals);
    if (title == null) {
      return content;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }

  ListView _buildMealsList(BuildContext context, List<Meal> meal) {
    return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => _buildMealStack(context, meal[index]));
  }

  Center _buildEmptyScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(Constants.emptyText,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          const SizedBox(
            height: 16,
          ),
          Text(
            Constants.tryText,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ],
      ),
    );
  }

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsDetailsScreen(
              meal: meal,
            )));
  }

  Card _buildMealStack(BuildContext context, Meal meal) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: InkWell(
          onTap: () {
            _selectMeal(context, meal);
          },
          child: _buildStack(meal)),
    );
  }

  Stack _buildStack(Meal meal) {
    return Stack(
      children: [
        FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: NetworkImage(meal.imageUrl),
          fit: BoxFit.cover,
          height: 200,
          width: double.infinity,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black54,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: _buildItemCoulmn(meal)),
          ),
        )
      ],
    );
  }

  Column _buildItemCoulmn(Meal meal) {
    return Column(
      children: [
        Text(
          meal.title,
          maxLines: 2,
          textAlign: TextAlign.center,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMealsItemTrait(
                Icons.schedule, '${meal.duration.toString()} min'),
            const SizedBox(
              width: 12,
            ),
            _buildMealsItemTrait(Icons.work, _complexityText(meal)),
            const SizedBox(
              width: 12,
            ),
            _buildMealsItemTrait(Icons.attach_money, _affordabilityText(meal))
          ],
        )
      ],
    );
  }

  Row _buildMealsItemTrait(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}

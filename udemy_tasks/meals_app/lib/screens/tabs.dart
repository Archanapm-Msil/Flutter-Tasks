import 'package:flutter/material.dart';
import 'package:meals_app/Utils/Constants.dart';
import 'package:meals_app/provider/filter-provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/provider/meals-provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favorite-provider.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() {
    return _TabState();
  }
}

class _TabState extends ConsumerState<Tabs> {
  int _selectedTabInex = 0;

  // Map<Filter, bool> _selectedFilter = kInitialFilter;

  void _showInfoMessage(String message) {}

  // void _toggleMealFavoriteList(Meal meal) {
  //   final isExsting = _favoritelist.contains(meal);

  //   if (isExsting) {
  //     setState(() {
  //       _favoritelist.remove(meal);
  //     });
  //     _showInfoMessage(Constants.infoMessage);
  //   } else {
  //     _showInfoMessage(Constants.infoMessagefvrt);
  //     setState(() {
  //       _favoritelist.add(meal);
  //     });
  //   }
  // }

  void _selectTab(int index) {
    setState(() {
      _selectedTabInex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filter') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => const FiltersScreen()));
     
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.read(mealsProvider);
    final activeFilter = ref.watch(filterProvider);
    final availableMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = Constants.categoryTxt;
    if (_selectedTabInex == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = Constants.favoriteTxt;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: _buildDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        currentIndex: _selectedTabInex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: Constants.categoryTxt),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: Constants.favoriteTxt)
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Cooking up',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          _buildDrawerItems(
              'Meals',
              Icon(
                Icons.restaurant,
                size: 24,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              'meals'),
          _buildDrawerItems(
              'Filters',
              Icon(
                Icons.settings,
                size: 24,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              'filter')
        ],
      ),
    );
  }

  ListTile _buildDrawerItems(String title, Icon icon, String identifier) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 24),
      ),
      onTap: () {
        _setScreen(identifier);
      },
    );
  }
}

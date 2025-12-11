import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meal_service.dart';
import '../widgets/meal_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/empty_state.dart';
import 'recipe_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  final String category;

  const MealsScreen({
    super.key,
    required this.category,
  });

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final MealService _mealService = MealService();
  List<Meal> _meals = [];
  List<Meal> _filteredMeals = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadMeals();
    _searchController.addListener(_filterMeals);
  }

  Future<void> _loadMeals() async {
    try {
      final meals = await _mealService.getMealsByCategory(widget.category);
      setState(() {
        _meals = meals;
        _filteredMeals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading meals: $e')),
        );
      }
    }
  }

  Future<void> _searchMeals(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _filteredMeals = _meals;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _isLoading = true;
    });

    try {
      final meals = await _mealService.searchMeals(query);
      setState(() {
        _filteredMeals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error searching meals: $e')),
        );
      }
    }
  }

  void _filterMeals() {
    final query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _filteredMeals = _meals;
      });
    } else {
      _searchMeals(query);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          CustomSearchBar(
            controller: _searchController,
            hintText: 'Search meals...',
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredMeals.isEmpty
                    ? EmptyState(
                        message: _isSearching
                            ? 'No meals found'
                            : 'No meals in this category',
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: _filteredMeals.length,
                        itemBuilder: (context, index) {
                          return MealCard(
                            key: ValueKey(_filteredMeals[index].idMeal),
                            meal: _filteredMeals[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailScreen(
                                    mealId: _filteredMeals[index].idMeal,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
      backgroundColor: Colors.red.shade50,
    );
  }
}

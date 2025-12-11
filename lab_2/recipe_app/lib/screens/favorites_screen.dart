import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/meal.dart';
import '../services/favorites_service.dart';
import '../widgets/empty_state.dart';
import '../widgets/meal_card.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Recipe>>(
              stream: _favoritesService.getFavorites(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text('Error: ${snapshot.error}'),
                      ],
                    ),
                  );
                }

                final favorites = snapshot.data ?? [];

                if (favorites.isEmpty) {
                  return const EmptyState(
                    message: 'No favorite recipes yet.\nAdd some from the recipes list!',
                  );
                }

                final meals = favorites.map((recipe) {
                  return Meal(
                    idMeal: recipe.idMeal,
                    strMeal: recipe.strMeal,
                    strMealThumb: recipe.strMealThumb ?? '',
                    strCategory: recipe.strCategory,
                  );
                }).toList();

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    final recipe = favorites[index];
                    return MealCard(
                      key: ValueKey(meal.idMeal),
                      meal: meal,
                      isFavorite: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailScreen(recipe: recipe),
                          ),
                        );
                      },
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


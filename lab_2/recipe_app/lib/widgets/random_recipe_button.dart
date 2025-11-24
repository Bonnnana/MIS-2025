import 'package:flutter/material.dart';
import '../services/meal_service.dart';
import '../screens/recipe_detail_screen.dart';

class RandomRecipeButton extends StatelessWidget {
  final MealService mealService;

  const RandomRecipeButton({
    super.key,
    required this.mealService,
  });

  Future<void> _showRandomRecipe(BuildContext context) async {
    try {
      final recipe = await mealService.getRandomRecipe();
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.red.shade600,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () => _showRandomRecipe(context),
        backgroundColor: Colors.white,
        foregroundColor: Colors.red.shade600,
        elevation: 0,
        icon: const Icon(Icons.shuffle),
        label: const Text(
          'Random Recipe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


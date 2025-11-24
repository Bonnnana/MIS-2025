import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/recipe.dart';
import '../services/meal_service.dart';
import '../widgets/recipe_image.dart';
import '../widgets/section_title.dart';
import '../widgets/ingredient_item.dart';
import '../widgets/empty_state.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String? mealId;
  final Recipe? recipe;

  const RecipeDetailScreen({
    super.key,
    this.mealId,
    this.recipe,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  final MealService _mealService = MealService();
  Recipe? _recipe;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _recipe = widget.recipe;
      _isLoading = false;
    } else if (widget.mealId != null) {
      _loadRecipe();
    }
  }

  Future<void> _loadRecipe() async {
    try {
      final recipe = await _mealService.getRecipeById(widget.mealId!);
      setState(() {
        _recipe = recipe;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading recipe: $e')),
        );
      }
    }
  }

  Future<void> _launchYouTube(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open YouTube')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _recipe == null
              ? const EmptyState(message: 'Recipe not found')
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RecipeImage(imageUrl: _recipe!.strMealThumb),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _recipe!.strMeal,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            const SizedBox(height: 24),
                            const SectionTitle(title: 'Ingredients'),
                            const SizedBox(height: 12),
                            ..._recipe!.ingredients.map((ingredient) {
                              return IngredientItem(
                                ingredient: ingredient['ingredient']!,
                                measure: ingredient['measure']!,
                              );
                            }),
                            const SizedBox(height: 24),
                            const SectionTitle(title: 'Instructions'),
                            const SizedBox(height: 12),
                            Text(
                              _recipe!.strInstructions,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade800,
                                height: 1.5,
                              ),
                            ),
                            if (_recipe!.strYoutube != null &&
                                _recipe!.strYoutube!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 24),
                                child: Center(
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _launchYouTube(_recipe!.strYoutube!),
                                    icon: const Icon(Icons.play_circle_outline),
                                    label: const Text('Watch on YouTube'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red.shade600,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      backgroundColor: Colors.red.shade50,
    );
  }
}

import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/favorites_service.dart';
import '../services/meal_service.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  final VoidCallback onTap;
  final bool? isFavorite;
  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
    this.isFavorite,
  });

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  final FavoritesService _favoritesService = FavoritesService();
  final MealService _mealService = MealService();
  bool _isFavorite = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.isFavorite != null) {
      _isFavorite = widget.isFavorite!;
      _isLoading = false;
    } else {
      _checkFavoriteStatus();
    }
  }

  @override
  void didUpdateWidget(MealCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorite != null && widget.isFavorite != oldWidget.isFavorite) {
      setState(() {
        _isFavorite = widget.isFavorite!;
        _isLoading = false;
      });
    } else if (widget.isFavorite == null && oldWidget.meal.idMeal != widget.meal.idMeal) {
      _checkFavoriteStatus();
    }
  }

  Future<void> _checkFavoriteStatus() async {
    final isFav = await _favoritesService.isFavorite(widget.meal.idMeal);
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      if (_isFavorite) {
        await _favoritesService.removeFavorite(widget.meal.idMeal);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Removed from favorites'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      } else {
        // Get full recipe details to save to favorites
        final recipe = await _mealService.getRecipeById(widget.meal.idMeal);
        await _favoritesService.addFavorite(recipe);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to favorites'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
      if (mounted) {
        setState(() {
          _isFavorite = !_isFavorite;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.red.shade600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  meal.strMealThumb,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.red.shade100,
                      child: const Icon(Icons.image_not_supported, size: 40),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                meal.strMeal,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


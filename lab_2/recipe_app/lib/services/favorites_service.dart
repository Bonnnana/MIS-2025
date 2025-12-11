import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'favorites';

  List<Map<String, String>> _convertIngredients(dynamic ingredientsData) {
    if (ingredientsData == null) return [];
    
    if (ingredientsData is List) {
      return ingredientsData.map((item) {
        if (item is Map) {
          return Map<String, String>.from(
            item.map((key, value) => MapEntry(
              key.toString(),
              value?.toString() ?? '',
            )),
          );
        }
        return <String, String>{};
      }).toList();
    }
    
    return [];
  }

  Future<void> addFavorite(Recipe recipe) async {
    try {
      await _firestore.collection(_collection).doc(recipe.idMeal).set({
        'idMeal': recipe.idMeal,
        'strMeal': recipe.strMeal,
        'strMealThumb': recipe.strMealThumb,
        'strCategory': recipe.strCategory,
        'strArea': recipe.strArea,
        'strInstructions': recipe.strInstructions,
        'strTags': recipe.strTags,
        'strYoutube': recipe.strYoutube,
        'ingredients': recipe.ingredients,
        'addedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  Future<void> removeFavorite(String recipeId) async {
    try {
      await _firestore.collection(_collection).doc(recipeId).delete();
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }

  Future<bool> isFavorite(String recipeId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(recipeId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  Stream<List<Recipe>> getFavorites() {
    return _firestore
        .collection(_collection)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Recipe(
          idMeal: data['idMeal'] ?? '',
          strMeal: data['strMeal'] ?? '',
          strCategory: data['strCategory'] ?? '',
          strArea: data['strArea'],
          strInstructions: data['strInstructions'] ?? '',
          strMealThumb: data['strMealThumb'],
          strTags: data['strTags'],
          strYoutube: data['strYoutube'],
          ingredients: _convertIngredients(data['ingredients']),
        );
      }).toList();
    });
  }

  Future<List<Recipe>> getFavoritesList() async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .orderBy('addedAt', descending: true)
          .get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Recipe(
          idMeal: data['idMeal'] ?? '',
          strMeal: data['strMeal'] ?? '',
          strCategory: data['strCategory'] ?? '',
          strArea: data['strArea'],
          strInstructions: data['strInstructions'] ?? '',
          strMealThumb: data['strMealThumb'],
          strTags: data['strTags'],
          strYoutube: data['strYoutube'],
          ingredients: _convertIngredients(data['ingredients']),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get favorites: $e');
    }
  }
}


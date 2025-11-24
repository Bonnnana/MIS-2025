class Recipe {
  final String idMeal;
  final String strMeal;
  final String? strDrinkAlternate;
  final String strCategory;
  final String? strArea;
  final String strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final List<Map<String, String>> _ingredients;

  Recipe({
    required this.idMeal,
    required this.strMeal,
    this.strDrinkAlternate,
    required this.strCategory,
    this.strArea,
    required this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    required List<Map<String, String>> ingredients,
  }) : _ingredients = ingredients;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final ingredients = <Map<String, String>>[];
    
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'] as String?;
      final measure = json['strMeasure$i'] as String?;
      
      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredients.add({
          'ingredient': ingredient.trim(),
          'measure': (measure ?? '').trim(),
        });
      }
    }
    
    return Recipe(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strDrinkAlternate: json['strDrinkAlternate'],
      strCategory: json['strCategory'] ?? '',
      strArea: json['strArea'],
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
    );
  }

  List<Map<String, String>> get ingredients => _ingredients;
}

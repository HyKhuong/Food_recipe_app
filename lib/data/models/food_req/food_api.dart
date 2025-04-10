class FoodApi {
  final Map<String, dynamic>? recipeData; // Store the entire API response
  final String title; // Name of the recipe
  final String image; // URL of the recipe image
  final double calories; // Total calories in the recipe
  final String url;

  // Constructor for creating FoodApi from a Map (e.g., API response)
  FoodApi({required this.recipeData})
      : title = recipeData?['label'] ?? '',
        image = recipeData?['image'] ?? '',
        calories = (recipeData?['calories'] as num?)?.toDouble() ?? 0.0,
        url = (recipeData?['url']) ?? '';
}

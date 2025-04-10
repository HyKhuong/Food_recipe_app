class FoodRecipeItem {
  final Map<String, dynamic> recipeData;
  final String id;
  final String title; // Name of the recipe
  final String image; // URL of the recipe image
  final double calories; // Total calories in the recipe
  final String url;

  FoodRecipeItem({
    required this.recipeData,
  })  : id = recipeData['id'] ?? 'unknown id', // Extract id from recipeData
        title = recipeData['title'] ??
            'unknown title', // Extract title from recipeData
        image = recipeData['imageUrl'] ??
            'unknown image', // Extract image from recipeData
        calories = (recipeData['calories'] as num?)?.toDouble() ??
            0.0, // Extract calories from recipeData
        url = recipeData['url'] ?? "unkown link";

  Map<String, dynamic> toMap() {
    return {
      'recipeData': recipeData, // Include the original recipeData map
      'id': id, // Include the id
      'title': title, // Include the title
      'image': image, // Include the image URL
      'calories': calories, // Include the calories
      'url': url,
    };
  }
}

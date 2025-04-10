import 'package:food_recipe_app/domain/entities/food_item.dart';

class FoodGet {
  String? title;
  String? image;
  double? calories;
  String? id;
  String? url;
  final Map<String, dynamic>? recipeData; // Add recipeData field

  FoodGet({
    required this.title,
    required this.id,
    required this.calories,
    required this.image,
    required this.url,
    this.recipeData, // Initialize recipeData
  });

  // Factory constructor for parsing JSON
  factory FoodGet.fromJson(Map<String, dynamic> data) {
    return FoodGet(
      title: data['title'] as String? ??
          'unknown title', // Handle null or missing title
      id: data['id'] as String? ?? 'unknown id', // Handle null or missing id
      calories: (data['calories'] as num?)?.toDouble() ??
          0.0, // Handle null or missing calories
      image: data['imageUrl'] as String? ??
          'unknown image', // Handle null or missing image
      url: data['url'] as String? ?? 'unknow link',
      recipeData: data, // Pass the entire data map as recipeData
    );
  }
}

// Extension to convert FoodGet to FoodRecipeItem
extension FoodGetX on FoodGet {
  FoodRecipeItem toEntity() {
    return FoodRecipeItem(
      recipeData: recipeData ??
          {
            'id': id ?? 'unknown id',
            'title': title ?? 'unknown title',
            'imageUrl': image ?? 'unknown image',
            'calories': calories ?? 0.0,
            'url': url ?? 'unknow link'
          },
    );
  }
}

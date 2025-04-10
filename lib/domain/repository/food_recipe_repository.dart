import 'package:either_dart/either.dart';
import 'package:food_recipe_app/data/models/food_req/food_api.dart';

abstract class FoodRecipeRepository {
  Future<Either> addOrRemoveFavoriteFood(FoodApi recipeData);
  Future<bool> isFavoriteFood(String foodId);
  Future<Either> getUserFavoriteFood();
}

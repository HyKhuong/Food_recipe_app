import 'package:either_dart/either.dart';
import 'package:food_recipe_app/data/models/food_req/food_api.dart';
import 'package:food_recipe_app/data/sources/food_recipe_service.dart';
import 'package:food_recipe_app/domain/repository/food_recipe_repository.dart';
import 'package:food_recipe_app/service_locator.dart';

class FoodRecipeImplement extends FoodRecipeRepository {
  @override
  Future<Either> addOrRemoveFavoriteFood(FoodApi recipeData) async {
    return await locator<FoodRecipeService>()
        .addOrRemoveFavoriteFood(recipeData);
  }

  @override
  Future<bool> isFavoriteFood(String foodId) async {
    return await locator<FoodRecipeService>().isFavoriteFood(foodId);
  }

  @override
  Future<Either> getUserFavoriteFood() async {
    return await locator<FoodRecipeService>().getUserFavoriteFood();
  }
}

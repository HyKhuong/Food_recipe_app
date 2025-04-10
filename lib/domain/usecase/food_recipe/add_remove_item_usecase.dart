import 'package:either_dart/either.dart';
import 'package:food_recipe_app/common/usecase/usecase.dart';
import 'package:food_recipe_app/data/models/food_req/food_api.dart';
import 'package:food_recipe_app/domain/repository/food_recipe_repository.dart';
import 'package:food_recipe_app/service_locator.dart';

class AddOrRemoveUseCase implements UseCase<Either, FoodApi> {
  @override
  Future<Either> call({FoodApi? params}) async {
    return await locator<FoodRecipeRepository>()
        .addOrRemoveFavoriteFood(params!);
  }
}

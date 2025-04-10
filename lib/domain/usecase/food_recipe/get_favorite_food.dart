import 'package:either_dart/either.dart';
import 'package:food_recipe_app/common/usecase/usecase.dart';
import 'package:food_recipe_app/domain/repository/food_recipe_repository.dart';
import 'package:food_recipe_app/service_locator.dart';

class GetFavoriteFood implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await locator<FoodRecipeRepository>().getUserFavoriteFood();
  }
}

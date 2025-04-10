import 'package:food_recipe_app/common/usecase/usecase.dart';
import 'package:food_recipe_app/domain/repository/food_recipe_repository.dart';
import 'package:food_recipe_app/service_locator.dart';

class FavoriteItemUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await locator<FoodRecipeRepository>().isFavoriteFood(params!);
  }
}

import 'package:food_recipe_app/data/repository/auth_repository_impl.dart';
import 'package:food_recipe_app/data/repository/food_recipe_implement.dart';
import 'package:food_recipe_app/data/sources/auth_firebase_service.dart';
import 'package:food_recipe_app/data/sources/food_recipe_service.dart';
import 'package:food_recipe_app/domain/repository/auth_repository.dart';
import 'package:food_recipe_app/domain/repository/food_recipe_repository.dart';
import 'package:food_recipe_app/domain/usecase/auth/get_user.dart';
import 'package:food_recipe_app/domain/usecase/auth/login_usecase.dart';
import 'package:food_recipe_app/domain/usecase/auth/register_usecase.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/add_remove_item_usecase.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/favorite_item.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/get_favorite_food.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  locator.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  locator.registerSingleton<LoginUsecase>(LoginUsecase());
  locator.registerSingleton<RegisterUsecase>(RegisterUsecase());
  locator.registerSingleton<GetUserUseCase>(GetUserUseCase());

  locator.registerSingleton<FoodRecipeRepository>(FoodRecipeImplement());
  locator.registerSingleton<FoodRecipeService>(FoodRecipeServiceImpl());

  locator.registerSingleton<FavoriteItemUseCase>(FavoriteItemUseCase());
  locator.registerSingleton<AddOrRemoveUseCase>(AddOrRemoveUseCase());
  locator.registerSingleton<GetFavoriteFood>(GetFavoriteFood());
}

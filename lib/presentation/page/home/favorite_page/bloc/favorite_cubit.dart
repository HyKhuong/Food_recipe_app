import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/data/models/food_req/food_api.dart';
import 'package:food_recipe_app/domain/entities/food_item.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/add_remove_item_usecase.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/get_favorite_food.dart';
import 'package:food_recipe_app/presentation/page/home/favorite_page/bloc/favorite_state.dart';
import 'package:food_recipe_app/service_locator.dart';

class FavoriteFoodCubit extends Cubit<FavoriteState> {
  FavoriteFoodCubit() : super(FavoriteFoodLoading());

  List<FoodRecipeItem> favoriteFood = [];
  Future<void> getFavoriteFoods() async {
    try {
      var result = await locator<GetFavoriteFood>().call();

      result.fold(
        (l) => emit(FavoriteFoodError()),
        (r) {
          if (r.isEmpty) {
            emit(FavoriteFoodError());
          } else {
            favoriteFood = r;
            emit(FavoriteFoodLoaded(favoriteFood: favoriteFood));
          }
        },
      );
    } catch (e) {
      emit(FavoriteFoodError());
    }
  }

  Future<void> removeFood(int index) async {
    if (index >= 0 && index < favoriteFood.length) {
      final foodItem = favoriteFood[index];
      try {
        // Convert the foodItem to a Map<String, dynamic>
        final foodItemMap = foodItem.toMap();

        // Call the use case to remove the item from Firebase
        var result = await locator<AddOrRemoveUseCase>()
            .call(params: FoodApi(recipeData: foodItemMap));
        result.fold(
          (error) => emit(FavoriteFoodError()),
          (success) {
            // Remove the item from the local list
            favoriteFood.removeAt(index);
            emit(FavoriteFoodLoaded(favoriteFood: favoriteFood));
          },
        );
      } catch (e) {
        emit(FavoriteFoodError());
      }
    }
  }
}

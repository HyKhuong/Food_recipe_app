import 'package:food_recipe_app/domain/entities/food_item.dart';

abstract class FavoriteState {}

class FavoriteFoodLoaded extends FavoriteState {
  final List<FoodRecipeItem> favoriteFood;
  FavoriteFoodLoaded({required this.favoriteFood});
}

class FavoriteFoodLoading extends FavoriteState {}

class FavoriteFoodError extends FavoriteState {}

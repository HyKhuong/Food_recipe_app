import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_recipe_app/data/models/food_req/food_api.dart';
import 'package:food_recipe_app/data/models/food_req/food_get.dart';
import 'package:food_recipe_app/domain/entities/food_item.dart';

abstract class FoodRecipeService {
  Future<Either> addOrRemoveFavoriteFood(FoodApi recipeData);
  Future<bool> isFavoriteFood(String foodId);
  Future<Either> getUserFavoriteFood();
}

class FoodRecipeServiceImpl extends FoodRecipeService {
  @override
  Future<Either<String, String>> addOrRemoveFavoriteFood(
      FoodApi recipeData) async {
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      var user = firebaseAuth.currentUser;
      if (user == null) {
        return const Left('User is not authenticated.');
      }

      String uId = user.uid;

      // Query the user's favorites collection
      QuerySnapshot favoriteFoods = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('title') // Assuming recipeData has an 'id' field
          .get();

      if (favoriteFoods.docs.isNotEmpty) {
        // If the food item is already in favorites, remove it
        await favoriteFoods.docs.first.reference.delete();
        return const Right('Removed from favorites');
      } else {
        // If the food item is not in favorites, add it
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({
          // Assuming recipeData has an 'id' field
          'title': recipeData.title,
          'imageUrl': recipeData.image,
          'calories': recipeData.calories,
          'url': recipeData.url,
        });
        return const Right('Added to favorites');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }

  @override
  Future<bool> isFavoriteFood(String foodId) async {
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      var user = firebaseAuth.currentUser;
      if (user == null) {
        return false;
      }

      String uId = user.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('foodId', isEqualTo: foodId)
          .get();

      bool isFavorite = favoriteSongs.docs.isNotEmpty;
      return isFavorite;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteFood() async {
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      var user = firebaseAuth.currentUser;
      List<FoodRecipeItem> favoriteFoodItem = [];
      String uId = user!.uid;
      QuerySnapshot favoriteSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .get();

      for (var element in favoriteSnapshot.docs) {
        String documentId = element.id; // Get the document ID
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;

        // Add the documentId to the data map
        data['id'] = documentId;

        // Parse the data into a FoodGet object
        FoodGet foodget = FoodGet.fromJson(data);

        // Add the FoodGet object to the list
        favoriteFoodItem.add(foodget.toEntity());
      }
      return Right(favoriteFoodItem);
    } catch (e) {
      print(e);
      return const Left('An error has occurred');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/widget/ingredient_item.dart';

class IngredientList extends StatelessWidget {
  final List<dynamic> ingredients;

  const IngredientList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // Calculate the height based on the number of items
    double itemHeight = h * 0.12; // Adjust this value based on your item height
    double totalHeight = ingredients.length * itemHeight;

    return SizedBox(
      height: totalHeight, // Set the height to match the total height of items
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling
        shrinkWrap: true,
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          int quantity = ingredients[index]['quantity'].toInt();
          return IngredientItem(
            quantity: quantity.toString(),
            imageUrl: ingredients[index]['image'] ?? '',
            measure: ingredients[index]['measure'] ?? '',
            food: ingredients[index]['food'] ?? '',
          );
        },
      ),
    );
  }
}

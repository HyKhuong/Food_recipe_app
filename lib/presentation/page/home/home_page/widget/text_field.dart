import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/page/all_recipe_page.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      height: h * .06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ]),
      child: TextField(
        controller: search,
        style: TextStyle(fontSize: w * .04, color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'What do you want to cook today?',
          hintStyle: TextStyle(fontSize: w * .03, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllRecipe(recipe: search.text)));
            },
            child: Icon(Icons.search,
                color: const Color.fromARGB(255, 97, 231, 73), size: w * .07),
          ),
        ),
      ),
    );
  }
}

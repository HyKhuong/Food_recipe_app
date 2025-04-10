import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/page/all_recipe_page.dart';

class RecipeCategoryView extends StatelessWidget {
  final String image, name;
  const RecipeCategoryView(
      {super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AllRecipe(
                      recipe: name,
                    )));
      },
      child: SizedBox(
        height: h * .105,
        width: w * .2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: h * .07,
                width: w * .15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.cover),
                )),
            Center(
              child: Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black45),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_recipe_app/common/constants/search_tag.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/widget/text_field.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/page/all_recipe_page.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/widget/custom_app_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Search', back: false),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: h * 0.02,
          horizontal: w * 0.032,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextFieldWidget(),
            SizedBox(height: h * 0.04),
            Text(
              'Search Tags',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * .06),
            ),
            Wrap(
                spacing: 8,
                children: tags.map((label) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AllRecipe(recipe: label)));
                      },
                      child: Text(label));
                }).toList())
          ],
        ),
      ),
    );
  }
}

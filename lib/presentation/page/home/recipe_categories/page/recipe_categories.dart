import 'package:flutter/material.dart';
import 'package:food_recipe_app/common/constants/category_list.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/page/all_recipe_page.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/widget/recipe_category_view.dart';

class RecipeCategoriesPage extends StatelessWidget {
  const RecipeCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.1),
      body: SingleChildScrollView(
        // Make the content scrollable
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * .06), // Add spacing
              Text(
                'For You',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.06, // Adjusted font size
                ),
              ),
              SizedBox(height: height * .01), // Add spacing
              SizedBox(
                height: height * .15, // Increased height for the Row
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RecipeCategoryView(image: images[0], name: name[0]),
                    RecipeCategoryView(image: images[1], name: name[1]),
                    RecipeCategoryView(image: images[2], name: name[2]),
                    RecipeCategoryView(image: images[3], name: name[3]),
                  ],
                ),
              ),
              SizedBox(height: height * .01), // Add spacing
              Text(
                'For You',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05, // Adjusted font size
                ),
              ),
              SizedBox(
                height: height * .45,
                child: GridView.builder(
                  itemCount: categoryImage.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: height * .01,
                      mainAxisSpacing: width * .021),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllRecipe(
                                      recipe: categories[index],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height * .043,
                                width: width * .08,
                                child: Image.asset(categoryImage[index]),
                              ),
                              SizedBox(
                                height: height * .003,
                              ),
                              Text(categories[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Text(
                'Your Preference',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * .055),
              ),
              SizedBox(
                height: height * .13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RecipeCategoryView(image: images[0], name: 'Easy'),
                    RecipeCategoryView(image: images[1], name: 'Quick'),
                    RecipeCategoryView(image: images[2], name: 'Beef'),
                    RecipeCategoryView(image: images[3], name: 'Low fat'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

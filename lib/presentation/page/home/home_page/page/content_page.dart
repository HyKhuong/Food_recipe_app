import 'package:flutter/material.dart';
import 'package:food_recipe_app/common/path/image.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/widget/home_app_bar.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/widget/tab_bar.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/widget/text_field.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const HomeAppBar(),
            SizedBox(height: h * .022),
            const TextFieldWidget(),
            SizedBox(height: h * .022),
            Container(
              height: h * .3,
              width: w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.coverImage),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: h * .022),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: w * 0.0645,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('see all'),
              ],
            ),
            SizedBox(height: h * .022),
            const SizedBox(
              height: 400, // Provide a fixed height for the TabBarWidget
              child: TabBarWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

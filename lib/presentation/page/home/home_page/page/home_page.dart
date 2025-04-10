import 'package:flutter/material.dart';
import 'package:food_recipe_app/presentation/page/home/favorite_page/page/favorite.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/page/content_page.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/widget/custom_bottom_nav_bar.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/page/recipe_categories.dart';
import 'package:food_recipe_app/presentation/page/home/search_page/page/search.dart';
import 'package:food_recipe_app/presentation/page/home/shopping_cart/page/cart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: _currentIndex); // Initialize _pageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose _pageController
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const <Widget>[
          ContentPage(),
          RecipeCategoriesPage(), // Page 2
          SearchPage(), // Page 3
          FavoritePage(), // Page 3
          ShoppingCart()
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

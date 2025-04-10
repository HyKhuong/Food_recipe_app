import 'package:flutter/material.dart';
import 'package:food_recipe_app/common/path/image.dart';
import 'package:food_recipe_app/presentation/page/auth/login_page.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            // Background Image
            Positioned(
              top: 0,
              child: Container(
                height: h * 0.79,
                width: w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagePath.onboarding),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Bottom Container with Gradient and Shadow
            Positioned(
              bottom: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: h * 0.35,
                width: w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(117, 196, 72, 1),
                      Color.fromRGBO(85, 160, 45, 1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.03),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Title
                        Text(
                          'Let\'s Get Cooking',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: h * 0.01),
                        // Subtitle
                        Text(
                          'Discover the best recipes from around the world',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: h * 0.03),
                        // Get Started Button
                        SizedBox(
                          width: w * 0.8,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

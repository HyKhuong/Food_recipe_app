import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/models/user_req/login_req.dart';
import 'package:food_recipe_app/domain/usecase/auth/login_usecase.dart';
import 'package:food_recipe_app/presentation/page/auth/register_page.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/page/home_page.dart';
import 'package:food_recipe_app/service_locator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 231, 73),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              // Title
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 97, 231, 73),
                ),
              ),
              const SizedBox(height: 30),
              // Email Field
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Enter email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 97, 231, 73),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 97, 231, 73),
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              // Password Field
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passWord,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 97, 231, 73),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 97, 231, 73),
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 30),
              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (email.text.isEmpty || passWord.text.isEmpty) {
                      var snackbar = SnackBar(
                        content: Text('Please fill in all the fields'),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      return;
                    }

                    // Kiểm tra định dạng email
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(email.text)) {
                      var snackbar = SnackBar(
                        content: Text('Please enter a valid email'),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      return;
                    }

                    var result = await locator<LoginUsecase>().call(
                      params: LoginReq(
                        password: passWord.text.trim(),
                        email: email.text.trim(),
                      ),
                    );

                    result.fold(
                      (l) {
                        var snackbar = SnackBar(
                          content: Text(l),
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      (r) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext content) => HomePage()),
                          (route) => false,
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 97, 231, 73),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Register Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 97, 231, 73),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

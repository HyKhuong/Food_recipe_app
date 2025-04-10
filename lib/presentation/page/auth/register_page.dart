import 'package:flutter/material.dart';
import 'package:food_recipe_app/data/models/user_req/register_req.dart';
import 'package:food_recipe_app/domain/usecase/auth/register_usecase.dart';
import 'package:food_recipe_app/presentation/page/auth/login_page.dart';
import 'package:food_recipe_app/service_locator.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 97, 231, 73),
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Color.fromARGB(255, 3, 3, 3)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                "Register",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 97, 231, 73),
                ),
              ),
              const SizedBox(height: 30),
              // Full Name Field
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Full Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _fullName,
                decoration: InputDecoration(
                  hintText: "Enter your full name",
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
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
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
                controller: _email,
                decoration: InputDecoration(
                  hintText: "Enter your email",
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
                controller: _passWord,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
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
              // Register Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_fullName.text.isEmpty ||
                        _email.text.isEmpty ||
                        _passWord.text.isEmpty) {
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
                    if (!emailRegex.hasMatch(_email.text)) {
                      var snackbar = SnackBar(
                        content: Text('Please enter a valid email'),
                        behavior: SnackBarBehavior.floating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      return;
                    }

                    var result = await locator<RegisterUsecase>().call(
                      params: RegisterReq(
                        fullName: _fullName.text.trim(),
                        password: _passWord.text.trim(),
                        email: _email.text.trim(),
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
                              builder: (BuildContext content) => LoginScreen()),
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
                    "Register",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

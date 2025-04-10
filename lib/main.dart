import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_app/firebase_options.dart';
import 'package:food_recipe_app/presentation/page/get_started/get_started_page.dart';
import 'package:food_recipe_app/service_locator.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox('shopping');

  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetStartedPage(),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class ConstantFunction {
  static Future<List<Map<String, dynamic>>> getResponse(
      String findRecipe) async {
    String id = "f01a0c00";
    String apiKey = "d592e14bcb110727f143ecf30338706b";
    String api =
        "https://api.edamam.com/search?q=$findRecipe&app_id=$id&app_key=$apiKey&from=0&to=3&calories=591-722&health=alcohol-free";

    try {
      final response = await http.get(Uri.parse(api));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Check if the 'hits' key exists and is a list
        if (data.containsKey('hits') && data['hits'] is List) {
          // Extract recipes from the 'hits' list
          final List<Map<String, dynamic>> recipes = [];
          for (var hit in data['hits']) {
            if (hit is Map<String, dynamic> && hit.containsKey('recipe')) {
              recipes.add(hit['recipe']);
            }
          }
          return recipes;
        } else {
          // Log or handle the case where 'hits' is missing or not a list
          print('Invalid API response: "hits" key is missing or not a list');
          return [];
        }
      } else {
        // Handle HTTP errors
        print('Failed to load data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle any exceptions that occur during the HTTP request
      print('An error occurred: $e');
      return [];
    }
  }
}

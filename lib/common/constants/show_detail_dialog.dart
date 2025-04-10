import 'package:flutter/material.dart';

class ShowDetailDialog {
  static Future<void> showCalories(
      Map<String, dynamic> item, BuildContext context) async {
    // Ensure the keys match the Edamam API response structure
    double fat = item['FAT']?['quantity'] ?? 0.0;
    double sFat = item['FASAT']?['quantity'] ?? 0.0; // Corrected key
    double cholesterol = item['CHOLE']?['quantity'] ?? 0.0;
    double sodium = item['NA']?['quantity'] ?? 0.0;
    double carbohydrate = item['CHOCDF']?['quantity'] ?? 0.0; // Corrected key
    double sugar = item['SUGAR']?['quantity'] ?? 0.0;
    double protein = item['PROCNT']?['quantity'] ?? 0.0; // Corrected key

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: const Color.fromRGBO(111, 214, 102, 1),
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                'Nutritional Fact',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          content: Container(
            constraints: BoxConstraints(maxHeight: 300), // Flexible height
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNutritionRow("Total Fat", fat.toStringAsFixed(1)),
                    _buildNutritionRow(
                        "Saturated Fat", sFat.toStringAsFixed(1)),
                    _buildNutritionRow(
                        "Cholesterol", cholesterol.toStringAsFixed(1)),
                    _buildNutritionRow("Sodium", sodium.toStringAsFixed(1)),
                    _buildNutritionRow(
                        "Total Carbohydrate", carbohydrate.toStringAsFixed(1)),
                    _buildNutritionRow("Sugar", sugar.toStringAsFixed(1)),
                    _buildNutritionRow("Protein", protein.toStringAsFixed(1)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

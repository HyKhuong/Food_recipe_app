import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class IngredientItem extends StatelessWidget {
  final String quantity, measure, food, imageUrl;
  const IngredientItem({
    super.key,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    var myBox = Hive.box('shopping');

    return SizedBox(
      height: h * 0.12, // Fixed height for each item
      child: Container(
        margin: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.02),
        padding:
            EdgeInsets.symmetric(vertical: h * 0.005, horizontal: w * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: w * 0.15,
                height: h * 0.08,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: w * 0.02),
            Expanded(
              child: Text(
                "$food\n$quantity $measure",
                style: TextStyle(
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(width: w * 0.02),
            ValueListenableBuilder(
              valueListenable: myBox.listenable(),
              builder: (context, box, _) {
                bool exists = box.containsKey(food);
                if (exists) {
                  return GestureDetector(
                    onTap: () {
                      myBox.delete(food);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('item deleted')),
                      );
                    },
                    child: Icon(
                      Icons.done_rounded,
                      color: Colors.green,
                      size: w * .07,
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      String value = '$food $measure $quantity';
                      myBox.put(food, value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('item added successfully')),
                      );
                    },
                    child: Icon(
                      Icons.add_circle_outline_rounded,
                      color: Colors.red,
                      size: w * .07,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

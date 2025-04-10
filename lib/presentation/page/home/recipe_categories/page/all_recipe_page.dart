import 'package:flutter/material.dart';
import 'package:food_recipe_app/common/constants/constants_function.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/page/detail_page.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/widget/custom_app_bar.dart';

class AllRecipe extends StatelessWidget {
  final String recipe;

  const AllRecipe({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        title: recipe,
        back: true,
      ),
      body: FutureBuilder(
        future: ConstantFunction.getResponse(recipe),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75, // Adjust based on your design
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> snap = snapshot.data![index];
                int time = snap['totalTime']?.toInt() ?? 0;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(item: snap),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              snap['image'] ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey[400],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snap['label'] ?? 'No Label',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.04,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.timer,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 4),
                                  Text(
                                    "${time.toString()} min",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

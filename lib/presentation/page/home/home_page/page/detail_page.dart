import 'package:flutter/material.dart';
import 'package:food_recipe_app/common/constants/show_detail_dialog.dart';
import 'package:food_recipe_app/common/constants/show_tabel.dart';
import 'package:food_recipe_app/data/models/food_req/food_api.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/add_remove_item_usecase.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/share_usecase.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/start_cooking_usecase.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/widget/circle_button.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/widget/custom_clip_path.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/widget/ingredientList.dart';
import 'package:food_recipe_app/service_locator.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> item;
  const DetailPage({super.key, required this.item});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    String time = widget.item['totalTime'].toString();
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: h * .44,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.item['image']),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                      top: h * .04,
                      left: w * .05,
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 97, 231, 73),
                        child: BackButton(color: Colors.white),
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * .04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      widget.item['label'],
                      style: TextStyle(
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      "$time minutes",
                    ),
                    SizedBox(
                      height: h * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Share Button
                        GestureDetector(
                          onTap: () {
                            ShareRecipeUsecase.share(widget.item['url']);
                          },
                          child: const CircleButton(
                            icon: Icons.share,
                            label: 'Share',
                          ),
                        ),

                        // Save Button
                        GestureDetector(
                          onTap: () async {
                            var result = await locator<AddOrRemoveUseCase>()
                                .call(params: FoodApi(recipeData: widget.item));

                            result.fold(
                              (error) {
                                // Show error message in SnackBar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: $error'),
                                    backgroundColor:
                                        Colors.red, // Red for errors
                                  ),
                                );
                              },
                              (success) {
                                // Show success message in SnackBar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Success: $success'),
                                    backgroundColor:
                                        Colors.green, // Green for success
                                  ),
                                );
                              },
                            );
                          },
                          child: const CircleButton(
                            icon: Icons.bookmark_border,
                            label: 'Save',
                          ),
                        ),

                        // Calories Button
                        GestureDetector(
                          onTap: () {
                            ShowDetailDialog.showCalories(
                                widget.item['totalNutrients'], context);
                          },
                          child: const CircleButton(
                            icon: Icons.monitor_heart_outlined,
                            label: 'Calories',
                          ),
                        ),

                        // Unit Chart Button
                        GestureDetector(
                          onTap: () {
                            ShowTable.showTable(context);
                          },
                          child: const CircleButton(
                            icon: Icons.table_chart_outlined,
                            label: 'Unit Chart',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Direction',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: w * .06),
                        ),
                        SizedBox(
                          width: w * .34,
                          child: ElevatedButton(
                              onPressed: () {
                                StartCookingUsecase.startcooking(
                                    widget.item['url']);
                              },
                              child: const Text('Start')),
                        ),
                      ],
                    ),
                    SizedBox(height: h * .02),
                    Container(
                        height: h * .07,
                        width: w,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: ClipPath(
                                  clipper: CustomCliPath(),
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 97, 231, 73),
                                    child: Center(
                                      child: Text('Ingredients Required',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: w * .05,
                                          )),
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.white,
                                  child: const Center(child: Text('6\nItems')),
                                ))
                          ],
                        )),
                    SizedBox(
                      height: h * 1.8,
                      child: IngredientList(
                        ingredients: widget.item['ingredients'],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

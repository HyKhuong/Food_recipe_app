import 'package:flutter/material.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/share_usecase.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/widget/custom_app_bar.dart';
import 'package:hive_flutter/adapters.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    var myBox = Hive.box('shopping');
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Shopping', back: false),
      body: ValueListenableBuilder(
        valueListenable: myBox.listenable(),
        builder: (context, box, _) {
          var data = box.values.toList();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                  height: h * .085,
                  color: Colors.grey[100],
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(data[index]),
                      ),
                      PopupMenuButton(itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            value: 'share',
                            child: Text("share"),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text("delete"),
                          ),
                        ];
                      }, onSelected: (String value) async {
                        if (value == 'delete') {
                          deleteItem(index);
                        } else if (value == 'share') {
                          ShareRecipeUsecase.share(data[index]);
                        }
                      }),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> deleteItem(int index) async {
    var myBox = Hive.box('shopping');
    await myBox.deleteAt(index);
  }
}

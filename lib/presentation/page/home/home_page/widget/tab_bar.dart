import 'package:flutter/material.dart';
import 'package:food_recipe_app/common/constants/constants_function.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/page/detail_page.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Column(
        children: [
          // TabBar placed at the top
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: h * 0.01),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: const Color.fromRGBO(18, 18, 18, 1),
              labelColor: Colors.white,
              indicator: BoxDecoration(
                color: const Color.fromRGBO(251, 248, 248, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: w * 0.04),
              tabs: const [
                TabItem(title: 'Breakfast'),
                TabItem(title: 'Lunch'),
                TabItem(title: 'Dinner'),
                TabItem(title: 'Snack'),
              ],
            ),
          ),
          // Show recipe using API
          const Expanded(
            child: TabBarView(
              children: [
                HomeTabBarView(recipe: 'Breakfast'),
                HomeTabBarView(recipe: 'Lunch'),
                HomeTabBarView(recipe: 'Dinner'),
                HomeTabBarView(recipe: 'Snack'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  final String title;
  const TabItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 97, 231, 73),
        border: Border.all(color: const Color.fromRGBO(246, 245, 245, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class HomeTabBarView extends StatelessWidget {
  final String recipe;
  const HomeTabBarView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: ConstantFunction.getResponse(recipe),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        }

        return SizedBox(
          height: h * 0.28, // Fixed height for the container
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Map<String, dynamic> snap = snapshot.data![index];
              int time = snap['totalTime'].toInt();
              int calories = snap['calories'].toInt();
              return Container(
                margin: EdgeInsets.only(right: w * 0.02),
                width: w * 0.5, // Fixed width for each item
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(item: snap)));
                      },
                      child: Container(
                        width: w * 0.5, // Fixed width for the image container
                        height:
                            h * 0.17, // Fixed height for the image container
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(snap['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    Text(
                      snap['label'],
                      style: TextStyle(
                        fontSize: w * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: h * 0.01),
                    Row(
                      children: [
                        Text(
                          "Calories: ${calories.toString()} - Time to Make: ${time.toString()}",
                          style:
                              TextStyle(fontSize: w * .03, color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 15);
            },
            itemCount: snapshot.data!.length,
          ),
        );
      },
    );
  }
}

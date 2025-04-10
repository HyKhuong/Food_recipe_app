import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/domain/usecase/food_recipe/share_usecase.dart';
import 'package:food_recipe_app/presentation/page/home/favorite_page/bloc/favorite_cubit.dart';
import 'package:food_recipe_app/presentation/page/home/favorite_page/bloc/favorite_state.dart';
import 'package:food_recipe_app/presentation/page/home/favorite_page/bloc/profile_cutbit.dart';
import 'package:food_recipe_app/presentation/page/home/favorite_page/bloc/profile_state.dart';
import 'package:food_recipe_app/presentation/page/home/home_page/page/detail_page.dart';
import 'package:food_recipe_app/presentation/page/home/recipe_categories/widget/custom_app_bar.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteFoodCubit()..getFavoriteFoods(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Favorite', back: false),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị thông tin profile phía trên
            _profileInfo(context),
            const SizedBox(height: 10),
            // Hiển thị danh sách yêu thích
            Expanded(
              child: _favoriteFood(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    state.userEntity.email!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            }
            if (state is ProfileInfoLoadFailure) {
              return const Center(
                child: Text('Please try again'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteFood() {
    return BlocBuilder<FavoriteFoodCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteFoodLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          );
        }
        if (state is FavoriteFoodLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.favoriteFood.length,
            itemBuilder: (context, index) {
              final food = state.favoriteFood[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(item: food.recipeData),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Calories: ${food.calories}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'delete') {
                              context
                                  .read<FavoriteFoodCubit>()
                                  .removeFood(index);
                            } else if (value == 'share') {
                              ShareRecipeUsecase.share(food.url);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'share',
                                child: Text('Share'),
                              ),
                            ];
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (state is FavoriteFoodError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You don't have any favorite recipes yet!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

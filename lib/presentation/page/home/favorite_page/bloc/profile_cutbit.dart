import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe_app/domain/usecase/auth/get_user.dart';
import 'package:food_recipe_app/presentation/page/home/favorite_page/bloc/profile_state.dart';
import 'package:food_recipe_app/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await locator<GetUserUseCase>().call();

    user.fold((l) {
      emit(ProfileInfoLoadFailure());
    }, (userEntity) {
      emit(ProfileInfoLoaded(userEntity: userEntity));
    });
  }
}

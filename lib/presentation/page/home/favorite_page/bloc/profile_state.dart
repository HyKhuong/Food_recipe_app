import 'package:food_recipe_app/domain/entities/user.dart';

abstract class ProfileInfoState {}

class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity userEntity;
  ProfileInfoLoaded({required this.userEntity});
}

class ProfileInfoLoadFailure extends ProfileInfoState {}

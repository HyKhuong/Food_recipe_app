import 'package:food_recipe_app/domain/entities/user.dart';

class UserModel {
  String? fullName;
  String? email;

  UserModel({this.fullName, this.email});

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email ?? 'Unknown email',
      fullName: fullName ?? 'Unknown name',
    );
  }
}

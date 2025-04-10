import 'package:either_dart/either.dart';
import 'package:food_recipe_app/data/models/user_req/login_req.dart';
import 'package:food_recipe_app/data/models/user_req/register_req.dart';
import 'package:food_recipe_app/data/sources/auth_firebase_service.dart';
import 'package:food_recipe_app/domain/repository/auth_repository.dart';
import 'package:food_recipe_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  Future<Either> login(LoginReq loginuser) async {
    return await locator<AuthFirebaseService>().login(loginuser);
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either> register(RegisterReq registeruser) async {
    return await locator<AuthFirebaseService>().register(registeruser);
  }

  @override
  Future<Either> getUser() async {
    return await locator<AuthFirebaseService>().getUser();
  }
}

import 'package:either_dart/either.dart';
import 'package:food_recipe_app/data/models/user_req/login_req.dart';
import 'package:food_recipe_app/data/models/user_req/register_req.dart';

abstract class AuthRepository {
  Future<Either> login(LoginReq userReq);
  Future<Either> register(RegisterReq userReq);
  Future<Either> getUser();
  Future<void> logout();
}

import 'package:either_dart/either.dart';
import 'package:food_recipe_app/common/usecase/usecase.dart';
import 'package:food_recipe_app/data/models/user_req/login_req.dart';
import 'package:food_recipe_app/domain/repository/auth_repository.dart';
import 'package:food_recipe_app/service_locator.dart';

class LoginUsecase implements UseCase<Either, LoginReq> {
  @override
  Future<Either> call({LoginReq? params}) async {
    return locator<AuthRepository>().login(params!);
  }
}

import 'package:either_dart/either.dart';
import 'package:food_recipe_app/common/usecase/usecase.dart';
import 'package:food_recipe_app/data/models/user_req/register_req.dart';
import 'package:food_recipe_app/domain/repository/auth_repository.dart';
import 'package:food_recipe_app/service_locator.dart';

class RegisterUsecase implements UseCase<Either, RegisterReq> {
  @override
  Future<Either> call({RegisterReq? params}) async {
    return locator<AuthRepository>().register(params!);
  }
}

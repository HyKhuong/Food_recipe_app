import 'package:either_dart/either.dart';
import 'package:food_recipe_app/common/usecase/usecase.dart';
import 'package:food_recipe_app/domain/repository/auth_repository.dart';
import 'package:food_recipe_app/service_locator.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await locator<AuthRepository>().getUser();
  }
}

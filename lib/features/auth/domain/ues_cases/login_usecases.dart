import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/login_entities.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repository/auth_repositories.dart';

class LoginUsecases {
  final AuthRepositories authRepositories;
  LoginUsecases(this.authRepositories);

  Future<Either<Failure, LoginEntities>> invoke(LoginRequest loginRequest) =>
  authRepositories.login(loginRequest)
  ;
}

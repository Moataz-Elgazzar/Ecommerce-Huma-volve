import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/signup_entities.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repository/auth_repositories.dart';

class SignupUsecases {
  final AuthRepositories authRepositories;
  SignupUsecases(this.authRepositories);

  Future<Either<Failure , SignupEntities>> invoke(SignupResponse signupResponse) => 
  authRepositories.signUp(signupResponse)
   ;
}

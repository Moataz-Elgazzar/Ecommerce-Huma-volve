import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/login_entities.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/signup_entities.dart';

abstract class AuthRepositories {
  Future<Either<Failure, LoginEntities>> login(LoginRequest loginRequest);
  Future<Either<Failure , SignupEntities>> signUp(SignupResponse signupResponse);
}

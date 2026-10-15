import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/error_handler/failure.dart';
import 'package:ecommerce_app_huma_volve/core/storage/secure_storage.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/login_entities.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/signup_entities.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repository/auth_repositories.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoriesImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, LoginEntities>> login(LoginRequest loginRequest) async {
    try {
      final login = await authRemoteDataSource.login(loginRequest);
      if (login == null) {
        return const Left(Failure('Login failed. Please try again.'));
      }
      final accessToken = login.accessToken;
      final refreshToken = login.refreshToken;

      if (accessToken == null || accessToken.isEmpty) {
        return const Left(Failure('The server did not return a valid access token.'));
      }
      await SecureStorage.saveAccessToken(login.accessToken ?? '');

      if (refreshToken != null && refreshToken.isNotEmpty) {
        await SecureStorage.saveRefreshToken(refreshToken);
      }

      return right(login.toEntity());
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, SignupEntities>> signUp(SignupResponse signupResponse) async {
    try {
      final signup = await authRemoteDataSource.signUp(signupResponse);
      if (signup == null) {
        return const Left(Failure('Registration failed. Please try again.'));
      }
      return Right(signup.toEntity());
    } on Exception catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}

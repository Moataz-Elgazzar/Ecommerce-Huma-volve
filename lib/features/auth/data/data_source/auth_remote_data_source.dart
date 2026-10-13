import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse?> login(LoginRequest loginRequest);
  Future<SignupResponse?> signUp(SignupResponse signupResponse);
}

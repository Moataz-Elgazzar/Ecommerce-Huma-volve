import 'package:ecommerce_app_huma_volve/core/services/dio_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/services/dio_provider.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_response.dart';

class AuthRemoteDataSourceImpl  implements AuthRemoteDataSource{
  @override
  Future<LoginResponse?> login(LoginRequest loginRequest) async {
    final logResponse = await DioProvider.post(
        path: DioEndpoint.loginEndPoint,
        data: loginRequest.toJson(),
      );
      if (logResponse.statusCode == 201) {
        return LoginResponse.fromJson(logResponse.data);
        
      }
      return null;
  }

  @override
  Future<SignupResponse?> signUp(SignupResponse signupResponse) async {
    final signUpResponse = await DioProvider.post(path: DioEndpoint.registerEndPoint, data: signupResponse.toJson());
    if (signUpResponse.statusCode == 201) {
      return SignupResponse.fromJson(signUpResponse.data);
    }
    return null;
  }
}
import 'package:ecommerce_app_huma_volve/core/services/dio_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/services/dio_provider.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_response.dart';

class LoginRepo {
  static Future<LoginResponse?> login(LoginRequest loginRequest) async {
    {
      final logResponse = await DioProvider.post(
        path: DioEndpoint.loginEndPoint,
        data: loginRequest.toJson(),
      );
      if (logResponse.statusCode == 201) {
        return LoginResponse.fromJson(logResponse.data);
      }
      return null;
    }
  }
}

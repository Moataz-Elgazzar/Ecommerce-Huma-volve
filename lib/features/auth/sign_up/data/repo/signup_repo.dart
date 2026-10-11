import 'package:ecommerce_app_huma_volve/core/services/dio_endpoint.dart';
import 'package:ecommerce_app_huma_volve/core/services/dio_provider.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/register_response.dart';

class SignupRepo {
  static Future<RegisterResponse?> signUp(RegisterResponse registerResponse) async {
    final signUpResponse = await DioProvider.post(path: DioEndpoint.registerEndPoint, data: registerResponse.toJson());
    if (signUpResponse.statusCode == 201) {
      return RegisterResponse.fromJson(signUpResponse.data);
    }
    return null;
  }
}

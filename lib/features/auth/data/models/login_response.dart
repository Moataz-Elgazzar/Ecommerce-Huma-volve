import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/login_entities.dart';

class LoginResponse extends LoginEntities {
  LoginResponse({super.accessToken, super.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(accessToken: json['access_token'], refreshToken: json['refresh_token']);

  Map<String, dynamic> toJson() => {'access_token': accessToken, 'refresh_token': refreshToken};

  LoginResponse toEntity() {
    return LoginResponse(
      accessToken:accessToken,
      refreshToken:refreshToken
    );
  }
}

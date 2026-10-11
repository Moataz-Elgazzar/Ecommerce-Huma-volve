class LoginResponse {
  String? accessToken;
  String? refreshToken;

  LoginResponse({this.accessToken, this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json['access_token'] as String?,
    refreshToken: json['refresh_token'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };
}

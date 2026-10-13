import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/signup_entities.dart';

class SignupResponse extends SignupEntities {
  SignupResponse({super.id, super.email, super.password, super.name, super.role, super.avatar, super.creationAt, super.updatedAt});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(id: json['id'] as int?, email: json['email'] as String?, password: json['password'] as String?, name: json['name'] as String?, role: json['role'] as String?, avatar: json['avatar'] as String?, creationAt: json['creationAt'] == null ? null : DateTime.parse(json['creationAt'] as String), updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt'] as String));
  }

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'password': password, 'name': name, 'role': role, 'avatar': avatar, 'creationAt': creationAt?.toIso8601String(), 'updatedAt': updatedAt?.toIso8601String()};

  SignupResponse toEntity() {
    return SignupResponse(
      id:id,
      email:email,
      password:password,
      name:name,
      role:role,
      avatar:avatar,
      creationAt:creationAt,
      updatedAt:updatedAt,
    );
  }
}

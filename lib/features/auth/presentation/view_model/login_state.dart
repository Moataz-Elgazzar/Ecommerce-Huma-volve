import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/login_entities.dart';

abstract class LoginState {}

class LoginIntialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccesState extends LoginState {
  final LoginEntities loginEntities;
  LoginSuccesState({required this.loginEntities,});
}

class LoginErrorState extends LoginState {
  final String? error;
  LoginErrorState(this.error);
}

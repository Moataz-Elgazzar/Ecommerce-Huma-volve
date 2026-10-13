import 'package:ecommerce_app_huma_volve/features/auth/domain/entity/signup_entities.dart';

abstract class SignupState {}

class SignupIntialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccesState extends SignupState {
  final SignupEntities signupEntities;
  SignupSuccesState({required this.signupEntities,});
}

class SignupErrorState extends SignupState {
  final String? error;
  SignupErrorState(this.error);
}

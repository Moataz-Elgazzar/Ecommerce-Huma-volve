import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_response.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/ues_cases/signup_usecases.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/view_model/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUsecases signupUsecases;

  SignupCubit({required this.signupUsecases}) : super(SignupIntialState());

  Future<void> signup(SignupResponse signupResponse) async {
    emit(SignupLoadingState());

    final signup = await signupUsecases.invoke(signupResponse);
    signup.fold((failure) => emit(SignupErrorState(failure.failureMessage)), (signup) => emit(SignupSuccesState(signupEntities: signup)));
  }
}

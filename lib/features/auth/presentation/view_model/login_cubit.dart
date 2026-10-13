import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_request.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/ues_cases/login_usecases.dart';
import 'package:ecommerce_app_huma_volve/features/auth/presentation/view_model/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecases loginUsecases;
  LoginCubit({required this.loginUsecases}) : super(LoginIntialState());

  Future<void> login(LoginRequest loginRequest) async {
    emit(LoginLoadingState());

    final login = await loginUsecases.invoke(loginRequest);
    login.fold((failure) => emit(LoginErrorState(failure.failureMessage)), (login) {
      return emit(LoginSuccesState(loginEntities: login));
    });
  }
}

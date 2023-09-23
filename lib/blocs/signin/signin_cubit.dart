import 'package:equatable/equatable.dart';
import 'package:firebase_auth_app/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/custom_error.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository authRepository;

  SigninCubit({required this.authRepository}) : super(SigninState.initial());

  Future<void> signin({required String email, required String password}) async {
    emit(state.copyWith(signinStatus: SigninStatus.submitting));

    try {
      await authRepository.signin(email: email, password: password);

      emit(state.copyWith(signinStatus: SigninStatus.success));
    } on CustomError catch (e) {
      emit(state.copyWith(signinStatus: SigninStatus.error, error: e));
    }
  }
}

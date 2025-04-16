import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ResetPasswordEvent>((event, emit) async {
      emit(ForgotPasswordLoading());
      try {
        // Simulate network call
        await Future.delayed(const Duration(seconds: 2));
        emit(ForgotPasswordSuccess());
      } catch (_) {
        emit(ForgotPasswordFailure("Failed to reset password"));
      }
    });
  }
}

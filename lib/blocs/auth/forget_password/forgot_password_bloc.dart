//forget_password_bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/services/auth_service.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthService authService;

  ForgotPasswordBloc(this.authService) : super(ForgotPasswordInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter emit) async {
    print("🔔 Event received with email: ${event.email}");

    emit(ForgotPasswordLoading());

    try {
      final result = await authService.sendOtp(event.email);
      print("🌐 AuthService.sendOtp() called with: ${event.email}");

      result.fold(
        (error) {
          print("❌ Error in sendOtp: $error");
          emit(ForgotPasswordError(error));
        },
        (_) {
          print("✅ OTP Sent Successfully");
          emit(OtpSentSuccess());
        },
      );
    } catch (e, stackTrace) {
      print("🚨 Exception in _onSendOtp: $e");
      print(stackTrace);
      emit(ForgotPasswordError("Unexpected error occurred"));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter emit) async {
    emit(ForgotPasswordLoading());
    final result = await authService.verifyOtp(event.email, event.otp);
    result.fold(
      (error) => emit(ForgotPasswordError(error)),
      (_) => emit(OtpVerifiedSuccess()),
    );
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter emit) async {
    emit(ForgotPasswordLoading());
    final result =
        await authService.resetPassword(event.email, event.newPassword);
    result.fold(
      (error) => emit(ForgotPasswordError(error)),
      (_) => emit(PasswordResetSuccess()),
    );
  }
}

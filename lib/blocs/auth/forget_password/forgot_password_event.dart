part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object?> get props => [];
}

class ResetPasswordEvent extends ForgotPasswordEvent {
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordEvent(this.newPassword, this.confirmPassword);
}

abstract class SignupEvent {}

class EmailChanged extends SignupEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends SignupEvent {
  final String password;
  PasswordChanged(this.password);
}

class SignupSubmitted extends SignupEvent {}

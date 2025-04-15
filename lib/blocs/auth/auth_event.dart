abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;
  final String password;

  SignUpRequested({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
    required this.password,
  });
}

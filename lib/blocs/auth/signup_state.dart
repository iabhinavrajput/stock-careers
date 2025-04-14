class SignupState {
  final String email;
  final String password;
  final bool isPasswordVisible;

  SignupState({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
  });

  SignupState copyWith({
    String? email,
    String? password,
    bool? isPasswordVisible,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}

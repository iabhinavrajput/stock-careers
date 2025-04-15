import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  AuthBloc(this._authService) : super(AuthInitial()) {
    // LOGIN
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _authService.login(event.email, event.password);
        print("Login response: ${response.toJson()}");

        if (response.status) {
          // Store token if needed
          await secureStorage.write(key: 'access_token', value: response.accessToken);
          emit(AuthSuccess(response.message));
        } else {
          emit(AuthFailure(response.message));
        }
      } catch (e) {
        print("Login error: $e");
        emit(AuthFailure("Login failed. Please try again."));
      }
    });

    // SIGNUP
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _authService.signUp(
          event.firstName,
          event.lastName,
          event.email,
          event.mobileNo,
          event.password,
        );

        print("SignUp response: $response");

        if (response['status'] == true) {
          await secureStorage.write(
            key: 'access_token',
            value: response['access_token'],
          );
          emit(AuthSuccess(response['message']));
        } else {
          emit(AuthFailure(response['message']));
        }
      } catch (e) {
        print("Signup error: $e");
        emit(AuthFailure("Signup failed. Please try again."));
      }
    });
  }
}

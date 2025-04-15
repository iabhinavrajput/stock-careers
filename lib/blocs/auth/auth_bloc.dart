import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _authService.login(event.email, event.password);
        print("Login response: ${response.toJson()}");

        if (response.status) {
          print("Login successful: ${response.message}");
          emit(AuthSuccess(response.message));
        } else {
          emit(AuthFailure(response.message));
        }
      } catch (e) {
        print("Login error: $e");
        emit(AuthFailure("Login failed. Please try again."));
      }
    });
  }
}


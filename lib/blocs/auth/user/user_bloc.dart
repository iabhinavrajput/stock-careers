import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/data/models/user_model.dart'; // Only import user_model.dart

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserFromToken>((event, emit) {
      final user = UserModel.fromMap(event.decodedToken); // Use UserModel's fromMap
      emit(UserLoaded(user)); // Emit UserLoaded with UserModel
    });
  }
}

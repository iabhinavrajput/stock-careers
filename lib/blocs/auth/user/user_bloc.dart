import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/data/models/user_model.dart'; // UserModel
import 'package:stock_careers/data/services/user_service.dart'; // UserService for API calls

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService _userService = UserService(); // Instance of UserService

  UserBloc() : super(UserInitial()) {
    // Event for loading user from token
    on<LoadUserFromToken>((event, emit) {
      final user = UserModel.fromMap(event!.decodedToken); // Use UserModel's fromMap
      emit(UserLoaded(user)); // Emit UserLoaded with UserModel
    });

    // Event for updating user profile
    on<UpdateUserProfile>((event, emit) async {
      emit(UserLoading()); // Show loading state during API call

      try {
        final success = await _userService.updateUserProfile(
          
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          mobileNo: event.mobileNo, userId: event.uid,
        );

        if (success) {
          emit(UserUpdated("Profile updated successfully!")); // Success state
        } else {
          emit(UserError("Failed to update profile.")); // Error state
        }
      } catch (e) {
        emit(UserError("An error occurred: $e")); // Error handling
      }
    });
  }
}

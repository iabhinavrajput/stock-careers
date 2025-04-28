import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/data/models/user_model.dart'; // Only import user_model.dart
import 'package:stock_careers/data/models/user_model.dart';

// Then use UserModel from user_model.dar

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user; // Use UserModel instead of User

  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

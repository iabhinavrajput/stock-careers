import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/data/models/user_model.dart'; // UserModel

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;

  UserLoaded(this.user);
}

class UserUpdated extends UserState {
  final String message;

  UserUpdated(this.message);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

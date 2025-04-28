abstract class UserEvent {}

class LoadUserFromToken extends UserEvent {
  final Map<String, dynamic> decodedToken;

  LoadUserFromToken(this.decodedToken);
}


abstract class UserEvent {}

class LoadUserFromToken extends UserEvent {
  final Map<String, dynamic> decodedToken;

  LoadUserFromToken(this.decodedToken);
}

class UpdateUserProfile extends UserEvent {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;

  UpdateUserProfile({
     required this.uid,

    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
  });
}

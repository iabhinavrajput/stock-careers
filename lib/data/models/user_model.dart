class UserModel {
  final String username;
  final String email;
  final String phone;
  final String firstname;
  final String lastname;

  UserModel({
    required this.username,
    required this.email,
    required this.phone,
    required this.firstname,
    required this.lastname,
  });

  // Factory constructor to create UserModel from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    // Split the username into first and last name
    final nameParts = map['username']?.split(' ') ?? ['Unknown', 'Unknown'];

    return UserModel(
      username: map['username'] ?? 'Unknown', // Ensure these keys match the decoded token
      firstname: nameParts[0], // First part as first name
      lastname: nameParts.length > 1 ? nameParts[1] : 'Unknown', // Second part as last name
      email: map['email'] ?? 'Unknown',
      phone: map['mobile_no'] ?? 'Unknown', // Map mobile_no to phone
    );
  }
}

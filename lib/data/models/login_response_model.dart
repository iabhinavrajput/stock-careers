class LoginResponseModel {
  final String accessToken;
  final bool status;
  final String message;
  final String note;

  LoginResponseModel({
    required this.accessToken,
    required this.status,
    required this.message,
    required this.note,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
      status: json['status'],
      message: json['message'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'status': status,
      'message': message,
      'note': note,
    };
  }
}

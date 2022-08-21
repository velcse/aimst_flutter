class LoginModel {
  bool status;
  String jwt;
  String message;
  UserModel userDetails;
  LoginModel(
      {required this.status,
      required this.jwt,
      required this.message,
      required this.userDetails});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        status: json['status'],
        jwt: json['jwt'],
        message: json['message'],
        userDetails: UserModel.fromJson(json['result']));
  }
}

class UserModel {
  final int? userId;
  int roleId;
  String? firstName;
  String lastName;
  String email;
  int mobileNumber;

  UserModel(
      {this.userId,
      required this.roleId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.mobileNumber});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: (json['user_id'] != null) ? json['user_id'] : "",
        roleId: json['role_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        mobileNumber: json['mobile_number']);
  }
}

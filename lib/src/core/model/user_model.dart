class UserModel {
  final String email;
  final String password;
  final String fullName;
  final String role;

  UserModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.role,
  });

  /// **Factory Constructor untuk dari JSON**
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      role: json['role'],
    );
  }

  /// **Convert Object ke JSON**
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'role': role,
    };
  }

  /// **Buat Dummy UserModel sesuai data yang diberikan**
  static UserModel get sampleUser => UserModel(
        email: "interviewcaliana@gmail.com",
        password: "R3cruitment!",
        fullName: "Operator My",
        role: "admin",
      );

  @override
  String toString() {
    return 'UserModel(email: $email, fullName: $fullName, role: $role)';
  }
}

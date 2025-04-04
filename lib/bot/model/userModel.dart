class UserModel {
  final String id;
  final String username;
  final String email;
  final String? lastSignIn;
  final String? createdAt;

  UserModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.lastSignIn,
      required this.createdAt});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "email": email,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      lastSignIn: json["last_sign_in_at"],
      createdAt: json["created_at"]);
}

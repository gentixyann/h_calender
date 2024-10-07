class UserModel {
  final String uid;
  final String email;
  final String? displayName; // オプションのフィールド

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
  });
}

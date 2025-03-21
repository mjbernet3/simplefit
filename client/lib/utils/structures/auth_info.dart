class AuthInfo {
  final String email;
  final String password;
  final String? username;

  AuthInfo({
    required this.email,
    required this.password,
    this.username,
  });
}

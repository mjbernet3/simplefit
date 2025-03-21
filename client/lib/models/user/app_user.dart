class AppUser {
  final String uid;
  final String? email;
  final bool emailVerified;

  AppUser({
    required this.uid,
    this.email,
    required this.emailVerified,
  });
}

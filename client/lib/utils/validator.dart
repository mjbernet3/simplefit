class Validator {
  static const String EMAIL_EMPTY = 'Email address cannot be empty';
  static const String EMAIL_INVALID = 'Email address must be valid';
  static const String PASSWORD_SHORT = 'Password must be at least 6 characters';

  static String validateEmail(String email) {
    if (email.isEmpty) {
      return EMAIL_EMPTY;
    } else if (!email.contains('@') || !email.contains('.')) {
      return EMAIL_INVALID;
    }

    return null;
  }

  static String validatePassword(String password) {
    if (password.length < 6) {
      return PASSWORD_SHORT;
    }

    return null;
  }
}

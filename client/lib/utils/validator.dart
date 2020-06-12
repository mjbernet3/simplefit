class Validator {
  static const String EMAIL_EMPTY = 'Please enter an email address';
  static const String EMAIL_INVALID = 'Please enter a valid email address';
  static const String USERNAME_EMPTY = 'Please enter a username';
  static const String PASSWORD_EMPTY = 'Please enter a password';
  static const String PASSWORD_SHORT =
      'Passwords must be at least 6 characters';

  static String validateEmail(String email) {
    if (email.isEmpty) {
      return EMAIL_EMPTY;
    } else if (!email.contains('@') || !email.contains('.')) {
      return EMAIL_INVALID;
    }

    return null;
  }

  static String validateUsername(String username) {
    if (username.isEmpty) {
      return USERNAME_EMPTY;
    }

    return null;
  }

  static String validatePassword(String password) {
    if (password.isEmpty) {
      return PASSWORD_EMPTY;
    } else if (password.length < 6) {
      return PASSWORD_SHORT;
    }

    return null;
  }
}

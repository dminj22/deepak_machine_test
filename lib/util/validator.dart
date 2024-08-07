String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }

  String pattern = r'^[^@]+@[^@]+\.[^@]+$';
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }

  return null;
}
String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }

  if (value.length <= 4) {
    return 'Password must be greater than 4 characters';
  }

  return null;
}


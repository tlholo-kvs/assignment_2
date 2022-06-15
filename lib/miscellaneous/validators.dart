String? validateEmail(String? value) {
  String message = '';
  RegExp emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  if (!emailPattern.hasMatch(value!)) {
    message = 'Email invalid! Please enter valid email, e.g example@site.com';
  } else {
    message = '';
  }

  return message;
}

String? validatePassword(String? value) {
  String message = '';
  //Rejex for password format
  RegExp passwordPattern =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');

  if (!passwordPattern.hasMatch(value!)) {
    message = '''Password format incorrect! Password should contain at least one
    uppercase letter, at least one lower case letter, one digit and at least 
    one special character!
     ''';
  }
  //testing seperately for the password length
  if (value.length < 8) {
    message = 'Please make sure your password is at least 8 characters long!';
  } else {
    message = '';
  }
  return message;
}

String? validateEmptyTitle(String? value) {
  return null;
}

String? validateEmptyMessage(String? value) {
  return null;
}

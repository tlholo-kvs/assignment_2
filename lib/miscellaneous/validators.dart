String? validateEmail(String? value) {
  String message = '';
  //Regex For The Email
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
  //Regex For Password
  RegExp passwordPattern =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');

  if (!passwordPattern.hasMatch(value!)) {
    message = '''Password format incorrect! Password should contain at least one
    uppercase letter, at least one lower case letter, one digit and at least 
    one special character!
     ''';
  }
  //Testing Seperately For The Password Length
  if (value.length < 8) {
    message = 'Please make sure your password is at least 8 characters long!';
  } else {
    message = '';
  }
  return message;
}

String? validateEmptyTitle(String? value) {
  String message = 'Please enter the title of the note before trying to save';

  if (value != null) {
    if (value.isEmpty) {
      message = message;
    } else {
      message = '';
    }
  } else {
    message = 'Value is null';
  }

  return message;
}

String? validateEmptyMessage(String? value) {
  String message = '';

  if (value != null) {
    if (value.isEmpty) {
      message = 'Please enter content';
    } else {
      message = '';
    }
  } else {
    message = 'Value is equal to null';
  }
  return message;
}

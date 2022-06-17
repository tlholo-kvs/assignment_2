import 'package:assignment2_2022/services/locator_service.dart';

import '../services/navigation_and_dialog_service.dart';

String? validateEmail(String? value) {
  String message = '';
  //Regax For The Email
  RegExp emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  if (!emailPattern.hasMatch(value!)) {
    locator.get<NavigationAndDialogService>().showSnackBar(
        message:
            'Email invalid! Please enter valid email, e.g example@site.com',
        title: 'Email Error');
  } else {
    message = '';
  }

  return message;
}

String? validatePassword(String? value) {
  String message = '';
  //Regax For Password
  RegExp passwordPattern =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');

  if (!passwordPattern.hasMatch(value!)) {
    message = '''Password format incorrect! Password should contain at least one
    uppercase letter, at least one lower case letter, one digit and at least 
    one special character!
     ''';
    locator
        .get<NavigationAndDialogService>()
        .showSnackBar(message: message, title: 'Password Error');
  }
  //Testing Seperately For The Password Length
  if (value.length < 8) {
    message = 'Please make sure your password is at least 8 characters long!';
    locator
        .get<NavigationAndDialogService>()
        .showSnackBar(message: message, title: 'Password error');
  } else {
    message = '';
  }
  return message;
}

String? validateEmptyTitle(String? value) {
  String message = 'Please enter the title of the note before trying to save';

  if (value != null) {
    if (value.isEmpty) {
      locator.get<NavigationAndDialogService>().showSnackBar(
            message: message,
            title: 'Empty title',
          );
    } else {
      message = '';
    }
  } else {
    locator.get<NavigationAndDialogService>().showSnackBar(
          message: 'Value is null...',
          title: 'Null title',
        );
  }

  return message;
}

String? validateEmptyMessage(String? value) {
  String message = '';

  if (value != null) {
    if (value.isEmpty) {
      locator.get<NavigationAndDialogService>().showSnackBar(
            message: message,
            title: 'Empty message',
          );
    } else {
      message = '';
    }
  } else {
    locator.get<NavigationAndDialogService>().showSnackBar(
          message: 'Value is null...',
          title: 'Null message',
        );
  }
  return message;
}

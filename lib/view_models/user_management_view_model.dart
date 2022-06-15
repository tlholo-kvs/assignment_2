import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';

class UserManagementViewModel with ChangeNotifier {
  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  BackendlessUser? _currentUser;
  BackendlessUser? get currentUser => _currentUser;

  void setCurrentUserToNull() {
    _currentUser = null;
  }

  bool _existingUser = false;
  bool get existingUser => _existingUser;

  set existingUser(bool value) {
    _existingUser = value;
    notifyListeners();
  }

  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  String _userProgressText = '';
  String get userProgressText => _userProgressText;

  Future<String> resetPassword(String username) async {
    String result = 'OK';
    return result;
  }

  Future<String> loginUser(String username, String password) async {
    String result = 'OK';
    return result;
  }

  Future<String> logoutUser() async {
    String result = 'OK';
    return result;
  }

  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';
    return result;
  }

  void checkIfUserExists(String username) async {}

  Future<String> createNewUser(BackendlessUser user) async {
    String result = 'OK';
    return result;
  }
}

String getHumanReadableError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please check your inbox and confirm your email address and try to login again.';
  }
  if (message.contains('User already exists')) {
    return 'This user already exists in our database. Please create a new user.';
  }
  if (message.contains('Invalid login or password')) {
    return 'Please check your username or password. The combination do not match any entry in our database.';
  }
  if (message
      .contains('User account is locked out due to too many failed logins')) {
    return 'Your account is locked due to too many failed login attempts. Please wait 30 minutes and try again.';
  }
  if (message.contains('Unable to find a user with the specified identity')) {
    return 'Your email address does not exist in our database. Please check for spelling mistakes.';
  }
  if (message.contains(
      'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
    return 'It seems as if you do not have an internet connection. Please connect and try again.';
  }
  return message;
}

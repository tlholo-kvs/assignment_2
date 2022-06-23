import 'package:assignment2_2022/models/note_entry.dart';
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

  // bool _displayUserProcessStatus = false;
  // bool get displayUserProcessStatus => _displayUserProcessStatus;

  // String _userProcessInfo = '';
  // String get userProcessInfo => _userProcessInfo;

  Future<String> resetPassword(String username) async {
    String response = 'OK';

    // _displayUserProcessStatus = true;
    // _userProcessInfo = 'Sending password instructions...';
    notifyListeners();

    await Backendless.userService
        .restorePassword(username)
        .onError((error, stackTrace) {
      response = getHumanReadableError(error.toString());
    });

    //_displayUserProcessStatus = false;
    return response;
  }

  Future<String> loginUser(String username, String password) async {
    String response = 'OK';

    //_displayUserProcessStatus = true;
    //_userProcessInfo = 'busy logging you in ......please wait';
    notifyListeners();

    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, stackTrace) {
      response = getHumanReadableError(error.toString());
    });

    if (user != null) {
      _currentUser = user;
    }
    //_displayUserProcessStatus = false;
    notifyListeners();
    return response;
  }

  Future<String> logoutUser() async {
    String response = 'OK';

    //_displayUserProcessStatus = true;
    //_userProcessInfo = 'Logging out...';
    notifyListeners();

    await Backendless.userService.logout().onError((error, stackTrace) {
      response = error.toString();
    });

    //_displayUserProcessStatus = false;
    notifyListeners();
    return response;
  }

  Future<String> checkIfUserLoggedIn() async {
    String response = 'OK';

    bool? validLogin = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      response = error.toString();
    });

    if (validLogin != null && validLogin) {
      String? currentUserObjectId = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        response = error.toString();
      });
      if (currentUserObjectId != null) {
        Map<dynamic, dynamic>? mapOfCurrentUser = await Backendless.data
            .of("users")
            .findById(currentUserObjectId)
            .onError((error, stackTrace) {
          response = error.toString();
        });
        if (mapOfCurrentUser != null) {
          _currentUser = BackendlessUser.fromJson(mapOfCurrentUser);
          notifyListeners();
        }
      } else {
        response = 'NOT OK';
      }
    } else {
      response = 'NOT OK';
    }
    return response;
  }

  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username' ";
    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.isEmpty) {
        _existingUser = false;
        notifyListeners();
      } else {
        _existingUser = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  Future<String> createNewUser(BackendlessUser user) async {
    String response = 'OK';
    // _displayUserProcessStatus = true;
    // _userProcessInfo = 'Busy Creating A new user please wait';

    try {
      await Backendless.userService.register(user);
      NoteEntry nothingOnEntry = NoteEntry(notes: {}, username: user.email);
      await Backendless.data
          .of('NoteEntry')
          .save(nothingOnEntry.toJson())
          .onError((error, stackTrace) {
        response = error.toString();
      });
    } catch (e) {
      response = getHumanReadableError(e.toString());
    }
    //_displayUserProcessStatus = false;
    notifyListeners();

    return response;
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

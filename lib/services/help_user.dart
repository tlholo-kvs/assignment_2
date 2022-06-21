import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/warning.dart';

void createNewUserInUI(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'Enter All Fields!');
  } else {
    BackendlessUser user = BackendlessUser()
      ..email = email.trim()
      ..password = password.trim();

    String result =
        await context.read<UserManagementViewModel>().createNewUser(user);

    if (result != 'OK') {
      locator
          .get<NavigationAndDialogService>()
          .showSnackBar(message: 'Error', title: result);
    } else {
      locator.get<NavigationAndDialogService>().showSnackBar(
          message: 'New User Successfully Created', title: 'Result');
      locator<NavigationAndDialogService>().navigateTo(RouteManager.loginPage);
    }
  }
}

Future<void> loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'Enter All Fields!');
  } else {
    String result = await context
        .read<UserManagementViewModel>()
        .loginUser(email.trim(), password.trim());

    if (result != 'Ok') {
      locator.get<NavigationAndDialogService>().showSnackBar(
          message: 'Logging you in. please wait', title: 'Result');
    } else {
      locator<NavigationAndDialogService>().goBack();
    }
  }
}

void resetPasswordInUI(BuildContext context, {required String email}) async {
  final userVM = context.read<UserManagementViewModel>();
  if (email.isEmpty) {
    locator.get<NavigationAndDialogService>().showSnackBar(
        message: 'Enter your email to which reset instructions must be sent',
        title: 'Error');
  } else {
    String response = await userVM.resetPassword(email.trim());
    if (response == 'OK') {
      locator.get<NavigationAndDialogService>().showSnackBar(
          message: 'Password reset sent! Please check your email',
          title: 'Success Message');
    } else {
      locator
          .get<NavigationAndDialogService>()
          .showSnackBar(message: response, title: 'Error response');
    }
  }
}

void logoutUserInUI(BuildContext context) async {
  final userVm = context.read<UserManagementViewModel>();
  String response = await context.read<UserManagementViewModel>().logoutUser();

  if (response == 'OK') {
    userVm.setCurrentUserToNull();
    locator
        .get<NavigationAndDialogService>()
        .popAndNavigateTo(RouteManager.loginPage);
  } else {
    locator
        .get<NavigationAndDialogService>()
        .showSnackBar(message: response, title: 'Error');
  }
}

import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:assignment2_2022/view_models/note_view_model.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitApp {
  static const String apiKeyAndroid =
      'B17A4C68-6ADB-4EBC-BFEC-CF70AE036FCC'; //add your own key
  static const String apiKeyIOS =
      '35EC0E1A-25CA-401F-8A35-0CA1A27D1957'; //add your own key
  static const String appID =
      '22773525-9A31-21B8-FF5D-8DBE06A5F700'; // add your own key

  static void initializeApp(BuildContext context) async {
    //To prevent the use of BuildContexts across async gaps,
    //I've used these variables to save the userVm provider,
    //notesVM
    final userVM = context.read<UserManagementViewModel>();
    final notesVM = context.read<NoteViewModel>();

    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID);

    String result = await userVM.checkIfUserLoggedIn();
    if (result == 'OK') {
      notesVM.getNotes(userVM.currentUser!.email);
      locator
          .get<NavigationAndDialogService>()
          .popAndNavigateTo(RouteManager.noteListPage);
    } else {
      locator
          .get<NavigationAndDialogService>()
          .popAndNavigateTo(RouteManager.loginPage);
    }
  }
}

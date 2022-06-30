import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:assignment2_2022/view_models/note_view_model.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void createNewNoteInUI(BuildContext context,
    {required TextEditingController titleController,
    required TextEditingController messageController}) async {
  //Variables to hold my reference to provider
  //to avoid the linting error and just to keep
  //the code clean

  final nMv = context.read<NoteViewModel>();
  final uMv = context.read<UserManagementViewModel>();

  if (titleController.text.isEmpty && messageController.text.isEmpty) {
    locator.get<NavigationAndDialogService>().showSnackBar(
        message: 'Please enter something in both fields, and then save',
        title: 'Empty fields');
  }
  //error handling to make sure the user enters both fields
  //before saving
  else if (titleController.text.isEmpty || messageController.text.isEmpty) {
    locator.get<NavigationAndDialogService>().showSnackBar(
        message: 'Both fields must have a value', title: 'Empty fields');
  } else {
    Note note = Note(
      title: titleController.text.trim(),
      message: messageController.text.trim(),
    );

    if (nMv.notes.contains(note)) {
      locator.get<NavigationAndDialogService>().showSnackBar(
          message:
              'This is a duplicate entry. Please check what you have typed!',
          title: 'Error');
    } else {
      nMv.createNote(note);

      //every note will be saved individually to the database
      nMv.saveNewNote(
        uMv.currentUser!.email,
        messageController.text.trim(),
        titleController.text.trim(),
        true,
      );

      locator
          .get<NavigationAndDialogService>()
          .navigateTo(RouteManager.noteListPage);
    }
  }
}

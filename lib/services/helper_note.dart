import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:assignment2_2022/view_models/note_view_model.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void refreshNotesInUI(BuildContext context) async {
  //Variables to hold my references to provider
  //to avoid the linting error and just to keep
  //the code clean
  final uVm = context.read<UserManagementViewModel>();
  final nMv = context.read<NoteViewModel>();
  String response = await nMv.getNotes(uVm.currentUser!.email);

  if (response != 'OK') {
    locator
        .get<NavigationAndDialogService>()
        .showSnackBar(message: response, title: 'Error');
  } else {
    locator
        .get<NavigationAndDialogService>()
        .showSnackBar(message: 'Data retrieved fromDB', title: 'Success');
  }
}

//Do we need this?
void saveAllNotessInUI(BuildContext context) async {}

void createNewNoteInUI(BuildContext context,
    {required TextEditingController titleController,
    required TextEditingController messageController}) async {
  //Variables to hold my reference to provider
  //to avoid the linting error and just to keep
  //the code clean

  final nMv = context.read<NoteViewModel>();

  if (titleController.text.isEmpty && messageController.text.isEmpty) {
    locator.get<NavigationAndDialogService>().showSnackBar(
        message: 'Please enter something in both fields, and then save',
        title: 'Empty fields');
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
      titleController.text = '';
      messageController.text = '';
      nMv.createNote(note);

      locator.get<NavigationAndDialogService>().goBack();
    }
  }
}

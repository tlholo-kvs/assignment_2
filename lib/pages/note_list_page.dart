import 'package:assignment2_2022/services/help_user.dart';
import 'package:assignment2_2022/view_models/note_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/route_manager.dart';
import '../services/locator_service.dart';
import '../services/navigation_and_dialog_service.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logoutUserInUI(context);
            },
            icon: const Icon(Icons.lock),
          ),
          IconButton(
            onPressed: () {
              locator
                  .get<NavigationAndDialogService>()
                  .navigateTo(RouteManager.noteCreatePage);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text('List of Notes'),
      ),
      body: Consumer<NoteViewModel>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.popAndPushNamed(context, RouteManager.noteViewPage);
                },
                title: Text(value.notes[index].title),
              );
            },
          );
        },
      ),
    );
  }
}

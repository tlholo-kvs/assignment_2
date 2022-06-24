import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:assignment2_2022/view_models/note_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../miscellaneous/constants.dart';

class NoteViewPage extends StatelessWidget {
  const NoteViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('View Note'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                locator
                    .get<NavigationAndDialogService>()
                    .navigateTo(RouteManager.noteListPage);
              },
              icon: const Icon(Icons.navigate_before),
            ),
          ],
        ),
        body: Consumer<NoteViewModel>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.notes[index].title,
                        style: titleStyle,
                      ),
                      const SizedBoxH20(),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          value.notes[index].message,
                          style: style14Blue,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}

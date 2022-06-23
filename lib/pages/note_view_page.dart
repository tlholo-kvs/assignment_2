import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/locator_service.dart';
import 'package:assignment2_2022/services/navigation_and_dialog_service.dart';
import 'package:flutter/material.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Title',
                style: titleStyle,
              ),
              SizedBoxH20(),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Message',
                  style: style14Blue,
                ),
              ),
            ],
          ),
        ));
  }
}

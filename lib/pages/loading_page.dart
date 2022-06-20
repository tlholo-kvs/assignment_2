import 'package:assignment2_2022/pages/login_page.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import '../widgets/app_progress_indicator.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: provider.Selector<UserManagementViewModel, BackendlessUser?>(
        selector: (context, value) => value.currentUser,
        builder: (context, value, child) {
          return value == null
              ? const LoginPage()
              : const AppProgressIndicator(text: 'Loading Data...please wait');
        },
      ),
    );
  }
}

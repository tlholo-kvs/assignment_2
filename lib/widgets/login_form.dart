import 'package:assignment2_2022/services/help_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../miscellaneous/constants.dart';
import '../miscellaneous/validators.dart';
import '../routes/route_manager.dart';
import '../services/locator_service.dart';
import '../services/navigation_and_dialog_service.dart';
import '../view_models/user_management_view_model.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UserManagementViewModel>().loginFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Login a User',
              style: headingStyle,
            ),
            const SizedBoxH30(),
            TextFormField(
              validator: validateEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: emailController,
              decoration: formDecoration('Email', Icons.mail),
            ),
            const SizedBoxH10(),
            TextFormField(
              validator: validatePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: passwordController,
              decoration: formDecoration('Password', Icons.lock),
            ),
            const SizedBoxH20(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                loginUserInUI(
                  context,
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
              child: const Text('Login'),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    minimumSize: const Size(140, 40),
                  ),
                  onPressed: () {
                    locator
                        .get<NavigationAndDialogService>()
                        .navigateTo(RouteManager.registerPage);
                  },
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    minimumSize: const Size(140, 40),
                  ),
                  onPressed: () {
                    resetPasswordInUI(
                      context,
                      email: emailController.text,
                    );
                  },
                  child: const Text('Reset Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

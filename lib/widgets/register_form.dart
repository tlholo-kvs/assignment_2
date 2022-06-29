import 'package:assignment2_2022/services/help_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../miscellaneous/constants.dart';
import '../miscellaneous/validators.dart';
import '../view_models/user_management_view_model.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController retypePasswordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    retypePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UserManagementViewModel>().registerFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Register a new User',
              style: headingStyle,
            ),
            const SizedBoxH30(),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validateEmail,
              controller: emailController,
              decoration: formDecoration('Email', Icons.mail),
            ),
            const SizedBoxH10(),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validatePassword,
              controller: passwordController,
              decoration: formDecoration('Password', Icons.lock),
            ),
            const SizedBoxH10(),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (passwordController.text != retypePasswordController.text) {
                  return 'Passwords do not match. Please make sure passwords match.';
                } else {
                  return '';
                }
              },
              controller: retypePasswordController,
              decoration: formDecoration('Re-Type Password', Icons.lock),
            ),
            const SizedBoxH20(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                createNewUserInUI(
                  context,
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

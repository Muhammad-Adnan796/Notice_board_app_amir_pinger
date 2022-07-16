import 'package:auth_firebase_amir_pinger/Widgets/customTextField.dart';
import 'package:auth_firebase_amir_pinger/Widgets/custom_button.dart';
import 'package:auth_firebase_amir_pinger/authes/authservices.dart';
import 'package:auth_firebase_amir_pinger/authes/signup.dart';
import 'package:auth_firebase_amir_pinger/constants/app_strings.dart';
import 'package:auth_firebase_amir_pinger/constants/errors.dart';
import 'package:auth_firebase_amir_pinger/notice_board_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  Authservice authService = Authservice();

  Future<void> login() async {
    
    if (email.isEmpty || password.isEmpty) {
      Alert(
        context: context,
        title: ErrorStrings.errorAlert,
        desc: ErrorStrings.enterValidCredentials,
      ).show();
    }

    EasyLoading.show(status: AppStrings.loading);
    User? loggedInUser = await authService.login(email, password);
    EasyLoading.dismiss();

    if (loggedInUser != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoticeBoardScreen(),
        ),
      );
    } else {
      Alert(
        context: context,
        title: ErrorStrings.errorAlert,
        desc: ErrorStrings.userNotFound,
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // this helps show keyboard appear at top and do not affect other widgets
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(AppStrings.appTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Login"),
              Icon(Icons.login),
              CustomTextField(
                onChange: (value) => setState(() => email = value),
                hintText: AppStrings.enterEmail,
                leading: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  size: 32,
                ),
              ),
              CustomTextField(
                onChange: (value) => setState(() => password = value),
                hintText: AppStrings.enterPassword,
                obscureText: true,
                leading: Icon(
                  Icons.password_outlined,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  size: 32,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: Text(
                      AppStrings.signup,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: CustomButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      title: Text(AppStrings.login),
                      onPress: login,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

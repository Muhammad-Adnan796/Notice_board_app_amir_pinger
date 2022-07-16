import 'dart:ffi';

import 'package:auth_firebase_amir_pinger/Widgets/customTextField.dart';
import 'package:auth_firebase_amir_pinger/Widgets/custom_button.dart';
import 'package:auth_firebase_amir_pinger/authes/authservices.dart';
import 'package:auth_firebase_amir_pinger/constants/app_strings.dart';
import 'package:auth_firebase_amir_pinger/constants/errors.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Authservice authservice = Authservice();

  String email = "";
  String password = "";
  String repassword = "";

  Future<void> signup() async {
    try {
      final user = await authservice.createuser(email, password);
      if (user != null) {
        Navigator.pop(context);
      }
    } catch (e) {
      Alert(context: context,title: ErrorStrings.errorAlert,desc: ErrorStrings.userCreationFailed).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // this helps show keyboard appear at top and do not affect other widgets
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(AppStrings.signup),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Signup"),
              Icon(Icons.login),
              CustomTextField(
                onChange: (value) {
                  setState(() {
                    email = value;
                  });
                },
                hintText: AppStrings.enterEmail,
                leading: Icon(
                  Icons.email_outlined,
                  size: 32,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
              ),
              CustomTextField(
                obscureText: true,
                onChange: (value) {
                  setState(() {
                    password = value;
                  });
                },
                hintText: AppStrings.enterPassword,
                leading: Icon(
                  Icons.password_outlined,
                  size: 32,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
              ),
              CustomTextField(
                obscureText: true,
                onChange: (value) {
                  setState(() {
                    repassword = value;
                  });
                },
                hintText: AppStrings.reEnterPassword,
                leading: Icon(
                  Icons.password_outlined,
                  size: 32,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      title: Text(AppStrings.register),
                      onPress: signup,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

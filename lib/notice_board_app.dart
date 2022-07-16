import 'package:auth_firebase_amir_pinger/Widgets/custom_button.dart';
import 'package:auth_firebase_amir_pinger/authes/authservices.dart';
import 'package:auth_firebase_amir_pinger/authes/login.dart';
import 'package:auth_firebase_amir_pinger/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NoticeBoardScreen extends StatefulWidget {


  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  Authservice authService = Authservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // this helps show keyboard appear at top and do not affect other widgets
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Text(AppStrings.appTitle),
        centerTitle: true,
        actions: [
          CustomButton(
            backgroundColor: Theme.of(context).primaryColor,
            title: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPress: () {
              EasyLoading.show(status: AppStrings.loading);
              authService.signout();
              EasyLoading.dismiss();

              Alert(
                context: context,
                title: AppStrings.appTitle,
                desc: AppStrings.signOutSuccess,
                type: AlertType.success,
              ).show();

              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName, (route) => false);
            },
          ),
        ],
      ),
      body: Text(
        'Notice board screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
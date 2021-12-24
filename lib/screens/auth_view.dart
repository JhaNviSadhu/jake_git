import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jake_git/constants.dart';
import 'package:jake_git/screens/main_screen.dart';
import 'dart:io' show Platform;
import '../controllers/auth_controller.dart';

// check biometric authentication is avaliable
class AuthView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: (Platform.isIOS) ? true : false,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Avaliable Biometric',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          biometricAuthenticationAva('Finger Print Authentication'),
          SizedBox(
            height: 10,
          ),
          biometricAuthenticationAva('Face Authentication'),
          SizedBox(
            height: 16,
          ),
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                child: Text('Login'),
                //user authenticate
                onPressed: () => controller.authenticateUser(),
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(MainScreen());
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: kPrimaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container biometricAuthenticationAva(String text) {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => controller.hasFingerPrintLock.value
                  ? Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Spacer(),
          ],
        ));
  }
}

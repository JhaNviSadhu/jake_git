import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jake_git/constants.dart';
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Text(
              'Avaliable Biometric',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
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
                    'Finger Print Authentication',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Obx(
                    () => controller.hasFaceLock.value
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
                    'Face Authentication',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              )),
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
            ],
          )
        ],
      ),
    );
  }
}

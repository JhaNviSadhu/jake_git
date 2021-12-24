import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jake_git/bindings/bindings.dart';

import 'package:jake_git/screens/auth_view.dart';
import 'package:jake_git/screens/main_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        smartManagement: SmartManagement.full,
        initialBinding: JakeBindings(),
        title: 'Jake_Git',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //LOGIN SCREEN
        home: AuthView());
  }
}

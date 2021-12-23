import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jake_git/auth/auth_page.dart';
import 'package:jake_git/auth/auth_state.dart';
import 'package:jake_git/bindings/bindings.dart';
import 'package:jake_git/controllers/auth_controller.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

@override
void initState() {
  Get.lazyPut(() => AuthController());
}

class MyApp extends GetWidget<AuthController> {
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
      home: Obx(() {
        if (controller.authState is UnAuthenticated) {
          return AuthPage();
        } else {
          return MainScreen();
        }
      }),
    );
  }
}

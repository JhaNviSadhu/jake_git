import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jake_git/constants.dart';
import 'package:jake_git/controllers/repo_controller.dart';
import 'package:jake_git/responsive.dart';
import 'package:jake_git/view/desktop.dart';
import 'package:jake_git/view/mobile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<RepoController>().getRepoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: kPrimaryColor,
        title: Text("Jake's Git"),
      ),
      body: Responsive(
        mobile: MobileView(),
        tablet: DesktopView(),
        desktop: DesktopView(),
      ),
    );
  }
}

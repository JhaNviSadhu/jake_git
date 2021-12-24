import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jake_git/constants.dart';
import 'package:jake_git/controllers/repo_controller.dart';
import 'package:jake_git/responsive.dart';
import 'package:jake_git/view/desktop.dart';
import 'package:jake_git/view/mobile.dart';
import 'dart:io' show Platform;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var isLoading = false;
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
      //for identify which view it is
      body: Responsive(
        //for mobile
        mobile: MobileView(),
        //for tablet
        tablet: DesktopView(),
        //for desctop
        desktop: DesktopView(),
      ),
    );
  }

  // _loadFromApi() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   var apiProvider = RepoApiProvider();
  //   await apiProvider.getRepoList();

  //   // wait for 2 seconds to simulate loading of data
  //   await Future.delayed(const Duration(seconds: 2));

  //   setState(() {
  //     isLoading = false;
  //   });
  // }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jake_git/constants.dart';
import 'package:jake_git/controllers/repo_controller.dart';
import 'package:jake_git/responsive.dart';

class DesktopView extends StatefulWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  //object of repocontroller
  RepoController _repoController = Get.find<RepoController>();

  ScrollController gridScrollController = ScrollController();

  //pagination
  pagination() {
    if ((gridScrollController.position.pixels ==
            gridScrollController.position.maxScrollExtent) &&
        (_repoController.isLoading == false)) {
      setState(() {
        _repoController.page += 1;
        _repoController.isLoading = true;
        //fetch more data
        _repoController.getRepoList();
      });
    }
  }

  @override
  void initState() {
    //add listener for Listview
    gridScrollController.addListener(pagination);
  }

  @override
  Widget build(BuildContext context) {
    //dynamic width
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(
        () => GridView.builder(
          physics: BouncingScrollPhysics(),
          controller: gridScrollController,
          itemCount: _repoController.arrRepoLists.length + 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / 0.52,
              crossAxisCount: (Responsive.isDesktop(context)) ? 3 : 2),
          itemBuilder: (context, index) {
            if (index == _repoController.arrRepoLists.length) {
              return Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            }
            return repoContainer(context, width, _repoController, index);
          },
        ),
      ),
    );
  }

  Container repoContainer(BuildContext context, double width,
      RepoController _repoController, int index) {
    return Container(
      decoration: BoxDecoration(
          border: Border.symmetric(
              horizontal: BorderSide(), vertical: BorderSide())),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.book,
            size: (Responsive.isDesktop(context)) ? 100 : 70,
          ),
          repoInfo(context, width, _repoController, index),
        ],
      ),
    );
  }

  Widget repoInfo(BuildContext context, double width,
      RepoController _repoController, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        SizedBox(
          width: (Responsive.isDesktop(context)) ? width / 5.5 : width / 3,
          child: Text(
            _repoController.arrRepoLists[index].name ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: titleTextStyle,
          ),
        ),
        SizedBox(height: 8),
        (_repoController.arrRepoLists[index].description != null)
            ? SizedBox(
                width:
                    (Responsive.isDesktop(context)) ? width / 5.5 : width / 3,
                child: Column(
                  children: [
                    Text(
                      _repoController.arrRepoLists[index].description ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: subTitleTextStyle,
                      maxLines: (Responsive.isDesktop(context)) ? 3 : 2,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              )
            : SizedBox(),
        (_repoController.arrRepoLists[index].language != null)
            ? buildRow(_repoController.arrRepoLists[index].language ?? '',
                Icons.code_rounded)
            : SizedBox(),
        (_repoController.arrRepoLists[index].openIssues != 0)
            ? buildRow(
                "${_repoController.arrRepoLists[index].openIssues ?? 0}",
                Icons.bug_report,
              )
            : SizedBox(),
        (_repoController.arrRepoLists[index].watchers != 0)
            ? buildRow(
                "${_repoController.arrRepoLists[index].watchers ?? 0}",
                Icons.face,
              )
            : SizedBox(),
      ],
    );
  }

  Row buildRow(String? data, IconData? icon) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 5),
        Text(data ?? ''),
      ],
    );
  }
}

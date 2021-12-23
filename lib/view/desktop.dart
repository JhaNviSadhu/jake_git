import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jake_git/constants.dart';
import 'package:jake_git/controllers/repo_controller.dart';
import 'package:jake_git/responsive.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RepoController _repoController = Get.find<RepoController>();
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GridView.builder(
        itemCount: _repoController.arrRepoLists.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1 / 0.52,
            crossAxisCount: (Responsive.isDesktop(context)) ? 3 : 2),
        itemBuilder: (context, index) {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    SizedBox(
                      width: (Responsive.isDesktop(context))
                          ? width / 5.5
                          : width / 3,
                      child: Text(
                        _repoController.arrRepoLists[index].name ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: titleTextStyle,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: (Responsive.isDesktop(context))
                          ? width / 5.5
                          : width / 3,
                      child: Text(
                        _repoController.arrRepoLists[index].description ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: subTitleTextStyle,
                        maxLines: (Responsive.isDesktop(context)) ? 3 : 2,
                      ),
                    ),
                    SizedBox(height: 8),
                    buildRow(_repoController.arrRepoLists[index].language ?? '',
                        Icons.code_rounded),
                    buildRow(
                      "${_repoController.arrRepoLists[index].openIssues ?? 0}",
                      Icons.bug_report,
                    ),
                    buildRow(
                        "${_repoController.arrRepoLists[index].watchers ?? 0}",
                        Icons.face),
                  ],
                ),
              ],
            ),
          );
        },
      ),
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

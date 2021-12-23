import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jake_git/constants.dart';
import 'package:jake_git/controllers/repo_controller.dart';

class MobileView extends StatelessWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RepoController _repoController = Get.find<RepoController>();
    return Scaffold(
        body: Obx(
      () => ListView.builder(
        itemCount: _repoController.arrRepoLists.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.black,
                  size: 50,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Text(
                    _repoController.arrRepoLists[index].name ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: titleTextStyle,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        _repoController.arrRepoLists[index].description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: subTitleTextStyle,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.code_rounded),
                        SizedBox(width: 5),
                        Text(
                          _repoController.arrRepoLists[index].language ?? "",
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.bug_report),
                        SizedBox(width: 5),
                        Text(
                            "${_repoController.arrRepoLists[index].openIssues ?? 0}"),
                        SizedBox(width: 10),
                        Icon(Icons.face),
                        SizedBox(width: 5),
                        Text(
                            "${_repoController.arrRepoLists[index].watchers ?? 0}"),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    ));
  }
}

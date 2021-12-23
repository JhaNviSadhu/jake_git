import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jake_git/constants.dart';
import 'package:jake_git/controllers/repo_controller.dart';
import 'package:jake_git/provider/db_provider.dart';

class RepoView extends StatelessWidget {
  const RepoView({Key? key}) : super(key: key);

  @override
  void initState() {
    DBProvider.db.initDB();
  }

  @override
  Widget build(BuildContext context) {
    RepoController _repoController = Get.find<RepoController>();
    return FutureBuilder(
      future: DBProvider.db.getAllRepo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
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
                        snapshot.data[index].name ?? "",
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
                            snapshot.data[index].description ?? "",
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
                              snapshot.data[index].language ?? "",
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.bug_report),
                            SizedBox(width: 5),
                            Text("${snapshot.data[index].openIssues ?? 0}"),
                            SizedBox(width: 10),
                            Icon(Icons.face),
                            SizedBox(width: 5),
                            Text("${snapshot.data[index].watchers ?? 0}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jake_git/constants.dart';
import 'package:jake_git/controllers/repo_controller.dart';

class MobileView extends StatefulWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  //object of repocontroller
  RepoController _repoController = Get.find<RepoController>();

  var scrollcontroller = ScrollController();

  //pagination
  void pagination() {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
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
    scrollcontroller.addListener(pagination);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.separated(
          controller: scrollcontroller,
          itemCount: _repoController.arrRepoLists.length + 1,
          itemBuilder: (context, index) {
            if (index == _repoController.arrRepoLists.length) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return repoListTile(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }

  Widget repoListTile(int index) {
    return ListTile(
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
              Text("${_repoController.arrRepoLists[index].openIssues ?? 0}"),
              SizedBox(width: 10),
              Icon(Icons.face),
              SizedBox(width: 5),
              Text("${_repoController.arrRepoLists[index].watchers ?? 0}"),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:jake_git/api_provider.dart';
import 'package:jake_git/model/modelrepo.dart';

class RepoController extends GetxController {
  var arrRepoLists = <ModelRepo>[].obs;
  int page = 1;
  bool isLoading = false;

  getRepoList() {
    print(page);

    APIProvider()
        .getAPICall("users/JakeWharton/repos?page=$page&per_page=15")
        .then((response) {
      List<ModelRepo> _modelRepo = modelRepoFromJson(response.data);
      arrRepoLists.addAll(_modelRepo);
      isLoading = false;
    });
  }
}

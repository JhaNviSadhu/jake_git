import 'package:get/get.dart';
import 'package:jake_git/api_provider.dart';
import 'package:jake_git/model/modelrepo.dart';

class RepoController extends GetxController {
  var arrRepoLists = <ModelRepo>[].obs;

  getRepoList() {
    APIProvider()
        .getAPICall("users/JakeWharton/repos?page=1&per_page=15")
        .then((response) {
      List<ModelRepo> _modelRepo = modelRepoFromJson(response.data);
      arrRepoLists.value = _modelRepo;
    });
  }
}

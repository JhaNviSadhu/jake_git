import 'package:get/get.dart';
import 'package:jake_git/controllers/auth_controller.dart';

import 'package:jake_git/controllers/repo_controller.dart';

//binding of controller
class JakeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RepoController(), fenix: true);
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

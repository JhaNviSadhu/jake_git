import 'dart:io';
import 'package:get/get.dart';
import 'package:jake_git/api_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:jake_git/model/modelrepo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RepoApiProvider extends GetxController {
  var arrRepoLists = <ModelRepo>[].obs;
  getRepoList() {
    APIProvider()
        .getAPICall("users/JakeWharton/repos?page=1&per_page=15")
        .then((response) {
      List<ModelRepo> _modelRepo = modelRepoFromJson(response.data);
      arrRepoLists.value = _modelRepo;
      return (response.data).map((repo) {
        print('Inserting $repo');
        DBProvider.db.createEmployee(ModelRepo.fromJson(repo));
      }).toList();
    });
  }
}

class DBProvider {
  Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'repo_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Repo('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'fullName TEXT,'
          'description TEXT,'
          'openIssues INTEGER,'
          'watchers INTEGER,'
          'language TEXT'
          ')');
    });
  }

  // Insert employee on database
  createEmployee(ModelRepo repo) async {
    final db = await database;
    final res = await db?.insert('Repo', repo.toJson());

    return res;
  }

  Future<List<ModelRepo>> getAllRepo() async {
    final db = await database;
    final res = await db?.rawQuery("SELECT * FROM REPO");

    List<ModelRepo> list =
        res!.isNotEmpty ? res.map((c) => ModelRepo.fromJson(c)).toList() : [];
    print(list);
    return list;
  }
}

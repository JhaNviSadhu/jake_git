import 'dart:convert';

List<ModelRepo> modelRepoFromJson(String str) =>
    List<ModelRepo>.from(json.decode(str).map((x) => ModelRepo.fromJson(x)));

String modelRepoToJson(List<ModelRepo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelRepo {
  ModelRepo(
      {this.id,
      this.name,
      this.fullName,
      this.description,
      this.openIssues,
      this.watchers,
      this.language});

  int? id;
  String? name;
  String? fullName;
  String? description;
  String? language;
  int? openIssues;
  int? watchers;

  factory ModelRepo.fromJson(Map<String, dynamic> json) => ModelRepo(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        description: json["description"] == null ? null : json["description"],
        openIssues: json["open_issues"] == null ? null : json["open_issues"],
        watchers: json["watchers"] == null ? null : json["watchers"],
        language: json["language"] == null ? null : json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "full_name": fullName == null ? null : fullName,
        "description": description == null ? null : description,
        "open_issues": openIssues == null ? null : openIssues,
        "watchers": watchers == null ? null : watchers,
        "language": language == null ? null : language,
      };
}

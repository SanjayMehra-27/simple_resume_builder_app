// Projects Model [project, description, year]
class ProjectModel {
  int? id;
  final String? project;
  final String? description;
  final String? year;

  ProjectModel({
    this.project,
    this.description,
    this.year,
    int? id,
  });

  // generate id
  int generateId() {
    return DateTime.now().microsecondsSinceEpoch;
  }

  // convert toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id ?? generateId(),
      'project': project,
      'description': description,
      'year': year,
    };
  }

  // convert fromJson
  factory ProjectModel.fromJson(Map<dynamic, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      project: json['project'],
      description: json['description'],
      year: json['year'],
    );
  }
}

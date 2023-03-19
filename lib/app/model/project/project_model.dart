// Projects Model [project, description, year]
class ProjectModel {
  int? id;
  final String? project;
  final String? description;
  final String? techStack;
  final String? year;

  ProjectModel({
    this.project,
    this.description,
    this.techStack,
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
      'tech_stack': techStack,
      'description': description,
      'year': year,
    };
  }

  // convert fromJson
  factory ProjectModel.fromJson(Map<dynamic, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      project: json['project'],
      techStack: json['tech_stack'],
      description: json['description'],
      year: json['year'],
    );
  }
}

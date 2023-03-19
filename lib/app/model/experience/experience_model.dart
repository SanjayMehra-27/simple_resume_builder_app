// Experience Model [company, designation, duration, description]
class ExperienceModel {
  int? id;
  final String? company;
  final String? designation;
  final String? duration;
  final String? description;

  ExperienceModel({
    this.company,
    this.designation,
    this.duration,
    this.description,
    int? id,
  });

  // generate id
  int generateId() {
    return 5;
  }

  // convert toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id ?? generateId(),
      'company': company,
      'designation': designation,
      'duration': duration,
      'description': description,
    };
  }

  // convert fromJson
  factory ExperienceModel.fromJson(Map<dynamic, dynamic> json) {
    return ExperienceModel(
      id: json['id'],
      company: json['company'],
      designation: json['designation'],
      duration: json['duration'],
      description: json['description'],
    );
  }
}

// Education Model [institute, degree, duration]
class EducationModel {
  int? id;
  final String? institute;
  final String? degree;
  final String? duration;

  EducationModel({
    this.institute,
    this.degree,
    this.duration,
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
      'institute': institute,
      'degree': degree,
      'duration': duration,
    };
  }

  // convert fromJson
  factory EducationModel.fromJson(Map<dynamic, dynamic> json) {
    return EducationModel(
      id: json['id'],
      institute: json['institute'],
      degree: json['degree'],
      duration: json['duration'],
    );
  }
}

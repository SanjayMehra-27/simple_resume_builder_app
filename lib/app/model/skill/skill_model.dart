// Skills Model [skill, level]
class SkillModel {
  final int? id;
  final String? skill;

  SkillModel({
    this.id,
    this.skill,
  });

  // generate id
  int generateId() {
    return DateTime.now().microsecondsSinceEpoch;
  }

  // convert toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id ?? generateId(),
      'skill': skill,
    };
  }

  // convert fromJson
  factory SkillModel.fromJson(Map<dynamic, dynamic> json) {
    return SkillModel(
      id: json['id'],
      skill: json['skill'],
    );
  }
}

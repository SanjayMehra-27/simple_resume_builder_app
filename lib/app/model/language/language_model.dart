// Languages Model [language, level]
class LanguageModel {
  int? id;
  final String? language;
  final String? level;

  LanguageModel({
    this.language,
    this.level,
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
      'language': language,
      'level': level,
    };
  }

  // convert fromJson
  factory LanguageModel.fromJson(Map<dynamic, dynamic> json) {
    return LanguageModel(
      id: json['id'],
      language: json['language'],
      level: json['level'],
    );
  }
}

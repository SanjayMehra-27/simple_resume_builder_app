import 'package:get/get.dart';

class ResumeModel {
  final ProfileModel? profile;
  final List<EducationModel>? education;
  final List<ExperienceModel>? experience;
  final List<SkillModel>? skills;
  final List<LanguagesModel>? languages;
  final List<ProjectsModel>? projects;

  ResumeModel({
    this.profile,
    this.education,
    this.experience,
    this.skills,
    this.languages,
    this.projects,
  });
}

class ResumeItem {
  final int id;
  final String name;
  final Object? data;

  ResumeItem({
    required this.id,
    required this.name,
    this.data,
  });
}

// Profile Model [image, name, email, phone, address, designation]
class ProfileModel {
  final String? image;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final String? designation;

  ProfileModel({
    this.image,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.designation,
  });
}

// Education Model [institute, degree, duration]
class EducationModel {
  final String? institute;
  final String? degree;
  final String? duration;

  EducationModel({
    this.institute,
    this.degree,
    this.duration,
  });
}

// Experience Model [company, designation, duration, description]
class ExperienceModel {
  final String? company;
  final String? designation;
  final String? duration;
  final String? description;

  ExperienceModel({
    this.company,
    this.designation,
    this.duration,
    this.description,
  });
}

// Skills Model [skill, level]
class SkillModel {
  final int? id;
  final String? skill;

  SkillModel({
    this.id,
    this.skill,
  });
}

// Languages Model [language, level]
class LanguagesModel {
  final String? language;
  final String? level;

  LanguagesModel({
    this.language,
    this.level,
  });
}

// Projects Model [project, description, year]
class ProjectsModel {
  final String? project;
  final String? description;
  final String? year;

  ProjectsModel({
    this.project,
    this.description,
    this.year,
  });
}

class ResumeController extends GetxController {
  final profileSection = ProfileModel().obs;
  final educationSection = <EducationModel>[].obs;
  final experienceSection = <ExperienceModel>[].obs;
  final skillsSection = <SkillModel>[].obs;
  final languagesSection = <LanguagesModel>[].obs;
  final projectsSection = <ProjectsModel>[].obs;

  final sectionIndex = 0.obs;
  final dragging = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  final List<ResumeItem> _resumeItems = [
    ResumeItem(
      id: 1,
      name: 'Profile',
      data: ProfileModel(
        name: 'John Doe',
        email: 'john@gmail.com',
        phone: '+91 1234567890',
        address: '123, ABC Street, XYZ City, 123456',
        designation: 'Software Engineer',
      ),
    ),
    ResumeItem(
      id: 2,
      name: 'Education',
      data: [
        EducationModel(
          institute: 'ABC University',
          degree: 'B.Tech',
          duration: '2015 - 2019',
        ),
        EducationModel(
          institute: 'XYZ School',
          degree: 'HSC',
          duration: '2013 - 2015',
        ),
        EducationModel(
          institute: 'ABC School',
          degree: 'SSC',
          duration: '2011 - 2013',
        ),
      ],
    ),
    ResumeItem(
      id: 3,
      name: 'Experience',
      data: [
        ExperienceModel(
          company: 'ABC Company',
          designation: 'Software Engineer',
          duration: '2019 - Present',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
        ExperienceModel(
          company: 'XYZ Company',
          designation: 'Software Engineer',
          duration: '2018 - 2019',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        ),
      ],
    ),
    ResumeItem(
      id: 4,
      name: 'Skills',
      data: [
        SkillModel(
          id: 1,
          skill: 'Flutter',
        ),
        SkillModel(
          id: 2,
          skill: 'Dart',
        ),
        SkillModel(
          id: 3,
          skill: 'Firebase',
        ),
        SkillModel(
          id: 4,
          skill: 'NodeJS',
        ),
        SkillModel(
          id: 5,
          skill: 'MongoDB',
        ),
      ],
    ),

    ResumeItem(
      id: 5,
      name: 'Languages',
      data: [
        LanguagesModel(
          language: 'English',
          level: 'Fluent',
        ),
        LanguagesModel(
          language: 'Hindi',
          level: 'Fluent',
        ),
        LanguagesModel(
          language: 'Marathi',
          level: 'Fluent',
        ),
      ],
    ),

    ResumeItem(
      id: 6,
      name: 'Projects',
      data: [
        ProjectsModel(
          project: 'Project 1',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          year: '2020',
        ),
        ProjectsModel(
          project: 'Project 2',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          year: '2020',
        ),
        ProjectsModel(
          project: 'Project 3',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          year: '2020',
        ),
      ],
    ),
    // add more items here
  ].obs;

  List<ResumeItem> get resumeItems => _resumeItems.toList();

  void onSwitch(int index1, int index2) {
    final item1 = _resumeItems[index1];
    final item2 = _resumeItems[index2];
    _resumeItems[index1] = item2;
    _resumeItems[index2] = item1;
  }
}

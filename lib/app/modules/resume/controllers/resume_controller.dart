import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_resume_builder_app/app/model/language/language_model.dart';
import 'package:simple_resume_builder_app/app/model/resume_item/resume_item_model.dart';

import '../../../constants/app_constatnt.dart';
import '../../../model/education/education_model.dart';
import '../../../model/experience/experience_model.dart';
import '../../../model/profile/profile_model.dart';
import '../../../model/project/project_model.dart';
import '../../../model/skill/skill_model.dart';

class ResumeController extends GetxController {
  final profileSection = ProfileModel().obs;
  final educationSection = <EducationModel>[].obs;
  final experienceSection = <ExperienceModel>[].obs;
  final skillsSection = <SkillModel>[].obs;
  final languagesSection = <LanguageModel>[].obs;
  final projectsSection = <ProjectModel>[].obs;

  // Profile Section
  final nameTextEditingController = TextEditingController().obs;
  final designationTextEditingController = TextEditingController().obs;
  final emailTextEditingController = TextEditingController().obs;
  final phoneTextEditingController = TextEditingController().obs;
  final addressTextEditingController = TextEditingController().obs;

  // Education Section
  final educationDegreeTextEditingController = TextEditingController().obs;
  final educationInstituteTextEditingController = TextEditingController().obs;
  final educationDurationTextEditingController = TextEditingController().obs;

  // Experience Section
  final experienceCompanyTextEditingController = TextEditingController().obs;
  final experienceDesignationTextEditingController =
      TextEditingController().obs;
  final experienceDurationTextEditingController = TextEditingController().obs;
  final experienceSummaryTextEditingController = TextEditingController().obs;

  // Skills Section
  final skillsTextEditingController = TextEditingController().obs;

  // Projects Section
  final projectsNameTextEditingController = TextEditingController().obs;
  final projectsSummaryTextEditingController = TextEditingController().obs;
  final projectsTechStackTextEditingController = TextEditingController().obs;
  final projectsYearTextEditingController = TextEditingController().obs;

  final sectionIndex = 0.obs;
  final dragging = false.obs;

  final isLoading = false.obs;

  // Resume Box
  late Box<dynamic> resumeBox;

  @override
  Future<void> onInit() async {
    // Get the resume box
    resumeBox = Hive.box(resume_box_name);
    // resumeBox.deleteFromDisk();
    await getProfileSection();
    await getEducationSection();
    await getExperienceSection();
    await getSkillsSection();
    await getLanguages();
    await getProjects();
    getResume();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    resumeBox.close();
    super.onClose();
  }

  // ignore: slash_for_doc_comments
  /**
   *  Profile Section APIs
   */
  // Add or update the profile section
  Future<bool> addOrUpdateProfileSection(ProfileModel profile) async {
    bool isUpdated = false;
    try {
      await resumeBox.put('profile', profile.toJson());
      await getProfileSection();
      isUpdated = true;
    } catch (e) {
      log(e.toString());
    }
    return isUpdated;
  }

  // Get the profile section
  Future<ProfileModel> getProfileSection() async {
    try {
      isLoading(true);
      final data = await resumeBox.get('profile');
      log(data.toString());
      profileSection.value = ProfileModel.fromJson(data);
      return profileSection.value;
    } catch (e) {
      log(e.toString());
      return ProfileModel();
    } finally {
      isLoading(false);
    }
  }

  // ignore: slash_for_doc_comments
  /**
   *  Education Section APIs
   */

  // Add the education section to the resume
  Future<bool> addEducationSection(EducationModel education) async {
    bool isAdded = false;
    try {
      final data = await resumeBox.get('education', defaultValue: []);
      if (data.length > 0) {
        final List<EducationModel> educations =
            (data as List).map((e) => EducationModel.fromJson(e)).toList();
        educations.add(education);
        await resumeBox.put(
            'education', educations.map((e) => e.toJson()).toList());
        await getEducationSection(); // Update the education section
        getResume();
        isAdded = true;
      } else {
        await resumeBox.put('education', [education.toJson()]);
      }
    } catch (e) {
      log(e.toString());
    }
    return isAdded;
  }

  // Get education section from the resume
  Future<void> getEducationSection() async {
    try {
      isLoading(true);
      final data = await resumeBox.get('education', defaultValue: []);
      if (data != null) {
        log(educationSection.toString());
        final List<EducationModel> educations =
            (data as List).map((e) => EducationModel.fromJson(e)).toList();
        educationSection.value = educations;
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Update the education by id
  Future<bool> updateEducationSection(EducationModel education) async {
    bool isUpdate = false;
    try {
      final data = await resumeBox.get('education');
      if (data != null) {
        final List<EducationModel> educations =
            (data as List).map((e) => EducationModel.fromJson(e)).toList();
        final index =
            educations.indexWhere((element) => element.id == education.id);
        if (index != -1) {
          educations[index] = education;
          await resumeBox.put(
              'education', educations.map((e) => e.toJson()).toList());
        }
        await getEducationSection(); // Update the education section
        getResume();
        isUpdate = true;
      }
    } catch (e) {
      log(e.toString());
    }
    return isUpdate;
  }

  // Delete the education by id
  Future<void> deleteEducationSection(EducationModel education) async {
    try {
      final data = await resumeBox.get('education');
      if (data != null) {
        final List<EducationModel> educations =
            (data as List).map((e) => EducationModel.fromJson(e)).toList();
        final index =
            educations.indexWhere((element) => element.id == education.id);
        if (index != -1) {
          educations.removeAt(index);
          await resumeBox.put(
              'education', educations.map((e) => e.toJson()).toList());
        }
        await getEducationSection(); // Update the education section
        getResume();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // ignore: slash_for_doc_comments
  /**
   *  Experience Section APIs
   */

  // Add the experience section to the resume
  Future<void> addExperienceSection(ExperienceModel experience) async {
    try {
      final data = await resumeBox.get('experience', defaultValue: []);
      if (data.length > 0) {
        final List<ExperienceModel> experiences =
            (data as List).map((e) => ExperienceModel.fromJson(e)).toList();
        experiences.add(experience);
        await resumeBox.put(
            'experience', experiences.map((e) => e.toJson()).toList());
      } else {
        await resumeBox.put('experience', [experience.toJson()]);
      }
      await getExperienceSection(); // Update the experience section
      getResume();
      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }

  // Get experience section from the resume
  Future<void> getExperienceSection() async {
    try {
      isLoading(true);
      final data = await resumeBox.get('experience', defaultValue: []);
      if (data.length > 0) {
        final List<ExperienceModel> experiences =
            (data as List).map((e) => ExperienceModel.fromJson(e)).toList();
        experienceSection.value = experiences;
      } else {
        experienceSection.value = [];
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Update the experience by id
  Future<void> updateExperienceSection(ExperienceModel experience) async {
    // if (experience.id == null) return;
    try {
      final data = await resumeBox.get('experience', defaultValue: []);
      if (data.length > 0) {
        final List<ExperienceModel> experiences =
            (data as List).map((e) => ExperienceModel.fromJson(e)).toList();
        final index =
            experiences.indexWhere((element) => element.id == experience.id);
        if (index != -1) {
          experiences[index] = experience;
          await resumeBox.put(
              'experience', experiences.map((e) => e.toJson()).toList());
          await getExperienceSection(); // Update the experience section
          getResume();
          Get.back();
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Delete the experience by id
  Future<void> deleteExperienceSection(ExperienceModel experience) async {
    try {
      final data = await resumeBox.get('experience', defaultValue: []);
      if (data.length > 0) {
        final List<ExperienceModel> experiences =
            (data as List).map((e) => ExperienceModel.fromJson(e)).toList();
        final index =
            experiences.indexWhere((element) => element.id == experience.id);
        if (index != -1) {
          experiences.removeAt(index);
          await resumeBox.put(
              'experience', experiences.map((e) => e.toJson()).toList());

          await getExperienceSection(); // Update the experience section
          getResume();
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // ignore: slash_for_doc_comments
  /**
   *  Skills Section APIs
   */

  // Add the skills section to the resume
  Future<void> addSkillsSection(SkillModel skills) async {
    if (skills.skill == null || skills.skill?.trim() == '') return;
    try {
      final data = await resumeBox.get('skills', defaultValue: []);
      if (data.length > 0) {
        final List<SkillModel> skillsList =
            (data as List).map((e) => SkillModel.fromJson(e)).toList();
        skillsList.add(skills);
        await resumeBox.put(
            'skills', skillsList.map((e) => e.toJson()).toList());
      } else {
        await resumeBox.put('skills', [skills.toJson()]);
      }
      await getSkillsSection(); // Update the skills section
      getResume();
    } catch (e) {
      log(e.toString());
    }
  }

  // Get skills section from the resume
  Future<void> getSkillsSection() async {
    try {
      isLoading(true);
      final data = await resumeBox.get('skills', defaultValue: []);
      if (data.length > 0) {
        final List<SkillModel> skills =
            (data as List).map((e) => SkillModel.fromJson(e)).toList();
        skillsSection.value = skills;
        log(skills.toString());
      } else {
        skillsSection.value = [];
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Update the skills by id
  Future<void> updateSkillsSection(SkillModel skill) async {
    try {
      final data = await resumeBox.get('skills');
      if (data != null) {
        final List<SkillModel> skills =
            (data as List).map((e) => SkillModel.fromJson(e)).toList();
        final index = skills.indexWhere((element) => element.id == skill.id);
        if (index != -1) {
          skills[index] = skill;
          await resumeBox.put('skills', skills.map((e) => e.toJson()).toList());
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Delete the skills by id
  Future<void> deleteSkillsSection(SkillModel skill) async {
    try {
      final data = await resumeBox.get('skills', defaultValue: []);
      if (data.length > 0) {
        final List<SkillModel> skills =
            (data as List).map((e) => SkillModel.fromJson(e)).toList();
        final index = skills.indexWhere((element) => element.id == skill.id);
        if (index != -1) {
          skills.removeAt(index);
          await resumeBox.put('skills', skills.map((e) => e.toJson()).toList());
          await getSkillsSection(); // Update the skills section
          getResume();
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // ignore: slash_for_doc_comments
  /**
   *  Projects Section APIs
   */

  // Add the projects section to the resume
  Future<void> addProjectSection(ProjectModel project) async {
    try {
      final data = await resumeBox.get('projects', defaultValue: []);
      if (data.length > 0) {
        final List<ProjectModel> projects =
            (data as List).map((e) => ProjectModel.fromJson(e)).toList();
        projects.add(project);
        await resumeBox.put(
            'projects', projects.map((e) => e.toJson()).toList());
      } else {
        await resumeBox.put('projects', [project.toJson()]);
      }
      await getProjects(); // Update the projects section
      getResume();
      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }

  // Get projects
  Future<void> getProjects() async {
    try {
      isLoading(true);
      final data = await resumeBox.get('projects', defaultValue: []);
      if (data.length > 0) {
        final List<ProjectModel> projects =
            (data as List).map((e) => ProjectModel.fromJson(e)).toList();
        projectsSection.value = projects;
        log(projects.toString());
      } else {
        projectsSection.value = [];
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Update the project by id
  Future<void> updateProjectSection(ProjectModel project) async {
    try {
      final data = await resumeBox.get('projects');
      if (data != null) {
        final List<ProjectModel> projects =
            (data as List).map((e) => ProjectModel.fromJson(e)).toList();
        final index =
            projects.indexWhere((element) => element.id == project.id);
        if (index != -1) {
          projects[index] = project;
          await resumeBox.put(
              'projects', projects.map((e) => e.toJson()).toList());
          await getProjects(); // Update the projects section
          getResume();
          Get.back();
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Delete the project by id
  Future<void> deleteProjectSection(ProjectModel project) async {
    try {
      final data = await resumeBox.get('projects');
      if (data != null) {
        final List<ProjectModel> projects =
            (data as List).map((e) => ProjectModel.fromJson(e)).toList();
        final index =
            projects.indexWhere((element) => element.id == project.id);
        if (index != -1) {
          projects.removeAt(index);
          await resumeBox.put(
              'projects', projects.map((e) => e.toJson()).toList());
          await getProjects(); // Update the projects section
          getResume();
        }
      } else {
        await getProjects(); // Update the projects section
        getResume();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // ignore: slash_for_doc_comments
  /**
   *  Language Section APIs
   */

  // Add the language section to the resume
  Future<void> addLanguageSection(LanguageModel language) async {
    try {
      final data = await resumeBox.get('languages', defaultValue: []);
      if (data.length > 0) {
        final List<LanguageModel> languages =
            (data as List).map((e) => LanguageModel.fromJson(e)).toList();
        languages.add(language);
        await resumeBox.put(
            'languages', languages.map((e) => e.toJson()).toList());
      } else {
        await resumeBox.put('languages', [language.toJson()]);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Get languages
  Future<void> getLanguages() async {
    try {
      isLoading(true);
      final data = await resumeBox.get('languages', defaultValue: []);
      if (data.length > 0) {
        final List<LanguageModel> languages =
            (data as List).map((e) => LanguageModel.fromJson(e)).toList();
        languagesSection.value = languages;
        log(languages.toString());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Update the language by id
  Future<void> updateLanguageSection(LanguageModel language) async {
    try {
      final data = await resumeBox.get('languages');
      if (data != null) {
        final List<LanguageModel> languages =
            (data as List).map((e) => LanguageModel.fromJson(e)).toList();
        final index =
            languages.indexWhere((element) => element.id == language.id);
        if (index != -1) {
          languages[index] = language;
          await resumeBox.put(
              'languages', languages.map((e) => e.toJson()).toList());
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Delete the language by id
  Future<void> deleteLanguageSection(LanguageModel language) async {
    try {
      final data = await resumeBox.get('languages');
      if (data != null) {
        final List<LanguageModel> languages =
            (data as List).map((e) => LanguageModel.fromJson(e)).toList();
        final index =
            languages.indexWhere((element) => element.id == language.id);
        if (index != -1) {
          languages.removeAt(index);
          await resumeBox.put(
              'languages', languages.map((e) => e.toJson()).toList());
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // ignore: slash_for_doc_comments
  /**
   *  Get Resume APIs
   */

  // Get the resume
  List<ResumeItemModel> getResume() {
    List<ResumeItemModel> resume = [];
    isLoading(true);
    resume.add(ResumeItemModel(
      id: 1,
      name: 'Profile',
      data: profileSection.value,
    ));

    resume.add(ResumeItemModel(
      id: 2,
      name: 'Education',
      data: educationSection.value,
    ));

    resume.add(ResumeItemModel(
      id: 3,
      name: 'Experience',
      data: experienceSection.value,
    ));

    resume.add(ResumeItemModel(
      id: 4,
      name: 'Skills',
      data: skillsSection.value,
    ));

    resume.add(ResumeItemModel(
      id: 5,
      name: 'Projects',
      data: projectsSection.value,
    ));

    resume.add(ResumeItemModel(
      id: 6,
      name: 'Languages',
      data: languagesSection.value,
    ));
    _resumeItemModelResumeItemModels.assignAll(resume);
    isLoading(false);
    return resume;
  }

  List<ResumeItemModel> _resumeItemModelResumeItemModels = [
    ResumeItemModel(
      id: 1,
      name: 'Profile',
      data: null,
    ),
    ResumeItemModel(
      id: 2,
      name: 'Education',
      data: [],
    ),
    ResumeItemModel(
      id: 3,
      name: 'Experience',
      data: [],
    ),
    ResumeItemModel(
      id: 4,
      name: 'Skills',
      data: [],
    ),

    ResumeItemModel(
      id: 5,
      name: 'Languages',
      data: [],
    ),

    ResumeItemModel(
      id: 6,
      name: 'Projects',
      data: [],
    ),
    // add more items here
  ].obs;

  set resumeItems(List<ResumeItemModel> value) =>
      _resumeItemModelResumeItemModels = value;

  List<ResumeItemModel> get resumeItems =>
      _resumeItemModelResumeItemModels.toList();

  void onSwitch(int index1, int index2) {
    final item1 = _resumeItemModelResumeItemModels[index1];
    final item2 = _resumeItemModelResumeItemModels[index2];
    _resumeItemModelResumeItemModels[index1] = item2;
    _resumeItemModelResumeItemModels[index2] = item1;
  }
}

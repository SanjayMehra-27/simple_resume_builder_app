import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/resume/widgets/education_page.dart';
import '../../modules/resume/widgets/experience_page.dart';
import '../../modules/resume/widgets/languages_page.dart';
import '../../modules/resume/widgets/profile_page.dart';
import '../../modules/resume/widgets/projects_page.dart';
import '../../modules/resume/widgets/skills_page.dart';

class ResumeSection {
  final int id;
  final String title;
  final IconData icon;
  final Function? onTap;

  ResumeSection({
    required this.id,
    required this.title,
    required this.icon,
    this.onTap,
  });
}

List<ResumeSection> resumeSections = [
  ResumeSection(
    id: 1,
    title: 'Profile',
    icon: Icons.person,
    onTap: () {
      // Open Profile Page
      Get.to(
        () => const ProfilePage(),
        transition: Transition.rightToLeft,
      );
    },
  ),
  ResumeSection(
    id: 2,
    title: 'Education',
    icon: Icons.school,
    onTap: () {
      // Open Education Page
      Get.to(
        () => const EducationPage(),
        transition: Transition.rightToLeft,
      );
    },
  ),
  ResumeSection(
    id: 3,
    title: 'Experience',
    icon: Icons.work,
    onTap: () {
      // Open Experience Page
      Get.to(
        () => const ExperiencePage(),
        transition: Transition.rightToLeft,
      );
    },
  ),
  ResumeSection(
    id: 4,
    title: 'Skills',
    icon: Icons.emoji_objects,
    onTap: () {
      // Open Skills Page
      Get.to(
        () => const SkillsPage(),
        transition: Transition.rightToLeft,
      );
    },
  ),
  ResumeSection(
    id: 5,
    title: 'Projects',
    icon: Icons.code,
    onTap: () {
      // Open Projects Page
      Get.to(
        () => const ProjectsPage(),
        transition: Transition.rightToLeft,
      );
    },
  ),
  ResumeSection(
    id: 6,
    title: 'Languages',
    icon: Icons.language,
    onTap: () {
      // Open Languages Page
      Get.to(
        () => const LanguagesPage(),
        transition: Transition.rightToLeft,
      );
    },
  ),
];

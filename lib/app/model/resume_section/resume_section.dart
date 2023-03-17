import 'package:flutter/material.dart';

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
    onTap: () {},
  ),
  ResumeSection(
    id: 2,
    title: 'Education',
    icon: Icons.school,
    onTap: () {},
  ),
  ResumeSection(
    id: 3,
    title: 'Experience',
    icon: Icons.work,
    onTap: () {},
  ),
  ResumeSection(
    id: 4,
    title: 'Skills',
    icon: Icons.emoji_objects,
    onTap: () {},
  ),
  ResumeSection(
    id: 5,
    title: 'Projects',
    icon: Icons.code,
    onTap: () {},
  ),
  ResumeSection(
    id: 6,
    title: 'Contact',
    icon: Icons.contact_mail,
    onTap: () {},
  ),
  ResumeSection(
    id: 7,
    title: 'Languages',
    icon: Icons.language,
    onTap: () {},
  ),
];
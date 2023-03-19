import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';
import '../controllers/resume_controller.dart';
import 'add_details_view.dart';

class ResumeView extends GetView<ResumeController> {
  const ResumeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Open the Add Details page
              Get.to(
                () => const AddDetailsView(),
                transition: Transition.downToUp,
                fullscreenDialog: true,
              );
            },
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text(
              'Your Resume'.toUpperCase(),
              style: AppTextStyleConst.heading.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ProfileWidget(
                      profile: controller.resumeItems[0].data as ProfileModel),
                ),
                Expanded(
                  child: GridView.builder(
                    // scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    dragStartBehavior: DragStartBehavior.down,
                    itemCount: controller.resumeItems.length - 1,
                    itemBuilder: (BuildContext context, int index) {
                      final item = controller.resumeItems[index + 1];
                      controller.sectionIndex.value = index + 1;
                      return Draggable(
                          data: index + 1,
                          onDragStarted: () {
                            controller.dragging.value = true;
                          },
                          onDragEnd: (details) {
                            controller.dragging.value = false;
                          },
                          onDragCompleted: () =>
                              controller.dragging.value = false,
                          onDraggableCanceled: (velocity, offset) =>
                              controller.dragging.value = false,
                          feedback: Obx(() => controller.dragging.value == true
                              ? Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      item.name,
                                      style: AppTextStyleConst.heading.copyWith(
                                          color: Colors.black,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                )
                              : _buildGridItem(item, isFeedback: false)),
                          childWhenDragging:
                              Obx(() => controller.dragging.value == true
                                  ? Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Hey! where you taking me?',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    )
                                  : _buildGridItem(item, isFeedback: false)),
                          child: Obx(
                            () => _buildGridItem(item,
                                isFeedback: controller.dragging.value),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildGridItem(ResumeItem item, {bool isFeedback = false}) {
    return Material(
      elevation: isFeedback ? 0.5 : 0,
      child: DragTarget<int>(
        hitTestBehavior: HitTestBehavior.translucent,
        builder: (BuildContext context, List<int?> candidateData,
            List<dynamic> rejectedData) {
          return isFeedback
              ? Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      item.name,
                      style: AppTextStyleConst.heading.copyWith(
                          color: Colors.black, decoration: TextDecoration.none),
                    ),
                  ),
                )
              : ItemBuilder(item: item);
        },
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {
          final draggedIndex = data;
          final targetIndex = controller.resumeItems.indexOf(item);
          controller.onSwitch(draggedIndex, targetIndex);
        },
      ),
    );
  }
}

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ResumeItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: AppTextStyleConst.heading,
          ),
          const SizedBox(
            height: 4,
          ),
          // dashed line
          Divider(
            thickness: 0.6,
            color: Colors.grey[400],
          ),
          const SizedBox(
            height: 4,
          ),
          _getResumeItem(item),
        ],
      ),
    );
  }

  // return widget based on the name of item [Profile, Education, Experience, Skills, Languages, Projects]
  Widget _getResumeItem(ResumeItem item) {
    switch (item.name) {
      case 'Profile':
        return ProfileWidget(profile: item.data as ProfileModel);
      case 'Education':
        return EducationWidget(education: item.data as List<EducationModel>);
      case 'Experience':
        return ExperienceWidget(experience: item.data as List<ExperienceModel>);
      case 'Skills':
        return SkillsWidget(skills: item.data as List<SkillModel>);
      case 'Languages':
        return LanguagesWidget(languages: item.data as List<LanguagesModel>);
      case 'Projects':
        return ProjectsWidget(projects: item.data as List<ProjectsModel>);
      default:
        return const Text(
          'Empty',
          style: AppTextStyleConst.subtitle,
        );
    }
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 50,
              backgroundImage: profile.image == null
                  ? Image.asset(
                      'assets/images/profile_avatar.png',
                    ).image
                  : NetworkImage(profile.image ?? ''),
              onBackgroundImageError: (exception, stackTrace) {
                print(exception);
              },
              backgroundColor: Colors.grey[200],
            ),

            // Name and Designation
            const SizedBox(
              width: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name ?? '',
                  style: AppTextStyleConst.heading,
                ),
                Text(
                  profile.designation ?? '',
                  style: AppTextStyleConst.subtitle,
                ),
              ],
            ),

            // Email and Phone, Address
            // const Spacer(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       profile.email ?? '',
            //       style: AppTextStyleConst.subtitle,
            //     ),
            //     Text(
            //       profile.phone ?? '',
            //       style: AppTextStyleConst.subtitle,
            //     ),
            //     Text(
            //       profile.address ?? '',
            //       style: AppTextStyleConst.subtitle,
            //     ),
            //   ],
            // ),
          ],
        )
      ],
    );
  }
}

class EducationWidget extends StatelessWidget {
  const EducationWidget({
    Key? key,
    required this.education,
  }) : super(key: key);
  final List<EducationModel> education;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: education.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Degree
                Text(
                  education[index].degree ?? '',
                  style: AppTextStyleConst.subtitle,
                ),

                // Institute
                Text(
                  education[index].institute ?? '',
                  style: AppTextStyleConst.body,
                ),

                // Duration
                Text(
                  education[index].duration ?? '',
                  style: AppTextStyleConst.caption,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({
    Key? key,
    required this.experience,
  }) : super(key: key);
  final List<ExperienceModel> experience;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        itemCount: experience.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(
            experience[index].company ?? '',
            style: AppTextStyleConst.subtitle,
          );
        },
      ),
    );
  }
}

class SkillsWidget extends StatelessWidget {
  const SkillsWidget({
    Key? key,
    required this.skills,
  }) : super(key: key);
  final List<SkillModel> skills;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        itemCount: skills.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(
            skills[index].skill ?? '',
            style: AppTextStyleConst.subtitle,
          );
        },
      ),
    );
  }
}

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({
    Key? key,
    required this.languages,
  }) : super(key: key);
  final List<LanguagesModel> languages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        itemCount: languages.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Text(
            languages[index].language ?? '',
            style: AppTextStyleConst.subtitle,
          );
        },
      ),
    );
  }
}

class ProjectsWidget extends StatelessWidget {
  const ProjectsWidget({
    Key? key,
    required this.projects,
  }) : super(key: key);
  final List<ProjectsModel> projects;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        itemCount: projects.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Text(
            projects[index].project ?? '',
            style: AppTextStyleConst.subtitle,
          );
        },
      ),
    );
  }
}

class EmptyScreenMessage extends StatelessWidget {
  const EmptyScreenMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.person_add,
            size: 100,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Please add your details to see your resume.',
            textAlign: TextAlign.center,
            style: AppTextStyleConst.subtitle,
          ),
        ],
      ),
    );
  }
}

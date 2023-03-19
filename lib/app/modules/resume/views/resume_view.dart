import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_resume_builder_app/app/constants/text_style_const/text_style_const.dart';
import '../../../model/education/education_model.dart';
import '../../../model/experience/experience_model.dart';
import '../../../model/language/language_model.dart';
import '../../../model/profile/profile_model.dart';
import '../../../model/project/project_model.dart';
import '../../../model/resume_item/resume_item_model.dart';
import '../../../model/skill/skill_model.dart';
import '../controllers/resume_controller.dart';
import 'add_details_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          body: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Obx(
                          () => ProfileWidget(
                              profile:
                                  controller.profileSection.value.name != null
                                      ? controller.profileSection.value
                                      : ProfileModel()),
                        ),
                      ),
                      Expanded(
                          child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 10,
                        axisDirection: AxisDirection.down,
                        children: [
                          for (int i = 1; i < 6; i++)
                            StaggeredGridTile.fit(
                              crossAxisCellCount: 1,
                              child: Draggable(
                                data: i,
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
                                feedback: Obx(() => controller.dragging.value ==
                                        true
                                    ? DraggingFeedbackWidget(
                                        controller: controller, i: i)
                                    : _buildGridItem(controller.resumeItems[i],
                                        isFeedback: false)),
                                childWhenDragging: const SizedBox.shrink(),
                                child: Obx(
                                  () => _buildGridItem(
                                      controller.resumeItems[i],
                                      isFeedback: controller.dragging.value),
                                ),
                              ),
                            ),
                        ],
                      )),
                      // ),
                    ],
                  ),
                ),
        ));
  }

  Widget _buildGridItem(ResumeItemModel item, {bool isFeedback = false}) {
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

class DraggingChildWidget extends StatelessWidget {
  const DraggingChildWidget({
    Key? key,
    required this.controller,
    required this.i,
  }) : super(key: key);

  final ResumeController controller;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          controller.resumeItems[i].name,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class DraggingFeedbackWidget extends StatelessWidget {
  const DraggingFeedbackWidget({
    Key? key,
    required this.controller,
    required this.i,
  }) : super(key: key);

  final ResumeController controller;
  final int i;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
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
            controller.resumeItems[i].name,
            style: AppTextStyleConst.heading
                .copyWith(color: Colors.black, decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ResumeItemModel item;

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
  Widget _getResumeItem(ResumeItemModel item) {
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
        return LanguagesWidget(languages: item.data as List<LanguageModel>);
      case 'Projects':
        return ProjectsWidget(projects: item.data as List<ProjectModel>);
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
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: education.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: SingleChildScrollView(
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
          ),
        );
      },
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
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: experience.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company
              Text(
                experience[index].company ?? '',
                style: AppTextStyleConst.subtitle,
              ),

              // Duration
              Text(
                experience[index].duration ?? '',
                style: AppTextStyleConst.caption,
              ),

              // Description
              Text(
                experience[index].description ?? '',
                style: AppTextStyleConst.body,
              ),
            ],
          ),
        );
      },
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
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: skills.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
          skills[index].skill ?? '',
          style: AppTextStyleConst.body,
        );
      },
    );
  }
}

class LanguagesWidget extends StatelessWidget {
  const LanguagesWidget({
    Key? key,
    required this.languages,
  }) : super(key: key);
  final List<LanguageModel> languages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: languages.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
          languages[index].language ?? '',
          style: AppTextStyleConst.body,
        );
      },
    );
  }
}

class ProjectsWidget extends StatelessWidget {
  const ProjectsWidget({
    Key? key,
    required this.projects,
  }) : super(key: key);
  final List<ProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Name
              Text(
                projects[index].project ?? '',
                style: AppTextStyleConst.subtitle,
              ),

              // Duration
              Text(
                projects[index].year ?? '',
                style: AppTextStyleConst.caption,
              ),

              // Description
              Text(
                projects[index].description ?? '',
                style: AppTextStyleConst.body,
              ),
            ],
          ),
        );
      },
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

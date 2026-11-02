import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';
import '../widgets/cache_image.dart';
import '../widgets/common_sliver_scaffold.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final GroupController groupController = Get.put(GroupController());
  final List<String> interests = ['Mountain Biking', 'Trail Riding', 'Enduro', 'Cross Country (XC)', 'Downhill', 'Trail Maintenance', 'Outdoor Adventure', 'Local Trails', 'Fitness', 'Gear & Equipment', 'Beginner Friendly', 'Other...'];
  final Set<String> selectedInterests = {'Mountain Biking', 'Trail Riding', 'Enduro', 'Cross Country (XC)', 'Local Trails', 'Beginner Friendly'};
  final audienceOptions = [
    (title: 'Everyone (all skill levels welcome)', description: 'Open to beginners through expert riders.', icon: CupertinoIcons.person_2),
    (title: 'Specific skill level', description: 'Focus on a particular skill level or experience.', icon: Icons.bar_chart),
    (title: 'Specific type of riders', description: 'For example, women riders, younger riders, or e-bike riders.', icon: CupertinoIcons.person),
    (title: 'Invite only (by description)', description: 'Describe who you would like to invite into the group.', icon: CupertinoIcons.lock),
  ];
  String audience = 'Everyone (all skill levels welcome)';

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    final blue = AppColor.blue(context);
    final blueSoft = AppColor.createGroupBlueSoft(context);
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15, bottom: Dimensions.h_20, top: Dimensions.h_5),
        child: GetBuilder<GroupController>(
          id: ControllerBuilders.groupController,
          builder: (controller) {
            final isLastStep = controller.currentStep >= 5;
            final nextButtonText = controller.currentStep > 5 ? "Create Group" :'Next Step';

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (controller.currentStep > 0) {
                      controller.previousStep();
                    } else {
                      Get.back();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: blueSoft,
                      border: Border.all(color: blue, width: 0.5),
                      borderRadius: BorderRadius.circular(Dimensions.h_4),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.arrow_left, size: Dimensions.h_12, color: blue),
                        SizedBox(width: Dimensions.w_5),
                        Text(
                          controller.currentStep == 0 ? 'Cancel' : 'Previous',
                          style: TextStyle(color: blue, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ) ,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          border: Border.all(color: Theme.of(context).highlightColor, width: 0.2),
                          borderRadius: BorderRadius.circular(Dimensions.h_4),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
                        child: Text(
                          'Save Draft',
                          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_10),
                    GestureDetector(
                      onTap: () {
                        if (isLastStep) {
                        } else {
                          controller.nextStep();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
                        child: Row(
                          children: [
                            Text(
                              nextButtonText,
                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: Dimensions.w_5),
                            Icon(isLastStep ? CupertinoIcons.check_mark : CupertinoIcons.arrow_right, size: Dimensions.h_12, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      body: CommonScrollBlurScaffold(
        showBack: true,
        expandedHeight: Dimensions.h_160,
        expandedColor: Colors.white,
        collapsedColor: Theme.of(context).highlightColor,
        hero: buildHeroHeader(isLight),
        slivers: [
          SliverToBoxAdapter(
            child: GetBuilder<GroupController>(
              id: ControllerBuilders.createGroupController,
              builder: (controller) {
                const steps = ['Group Details', 'Location & Coverage', 'Description & Media', 'Privacy & Membership', 'Discussion Settings', 'Rules & Guidelines', 'Review & Launch'];

                final step = controller.currentStep.clamp(0, steps.length - 1);
                final completedStep = step + 1;
                final percentage = (completedStep / steps.length * 100).round();

                return CommonCard(
                  margin: EdgeInsets.only(top: Dimensions.h_5, left: Dimensions.w_10, right: Dimensions.w_10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              steps[step],
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(color: blueSoft, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_2),
                            child: Text(
                              '${completedStep.toString().padLeft(2, '0')} / 07',
                              style: TextStyle(color: blue, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      Row(
                        children: List.generate(steps.length, (index) {
                          return Expanded(
                            child: Container(
                              height: Dimensions.h_5,
                              margin: EdgeInsets.only(right: index == steps.length - 1 ? 0 : Dimensions.w_5),
                              decoration: BoxDecoration(color: index < completedStep ? blue : const Color(0xFFDCE4EF), borderRadius: BorderRadius.circular(20)),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: Dimensions.h_10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.check_mark_circled, size: Dimensions.h_13, color: blue),
                              SizedBox(width: Dimensions.w_5),
                              Text(
                                'Step $completedStep of ${steps.length}',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text(
                            '$percentage% Complete',
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: GetBuilder(
              init: groupController,
              id: ControllerBuilders.createGroupController,
              builder: (controller) {
                return buildSteps(context, blueSoft, blue);
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_20)),
        ],
      ),
    );
  }

  Widget buildSteps(BuildContext context, Color blueSoft, Color blue) {
    switch (groupController.currentStep) {
      case 0:
        return buildGroupDetails(context, blueSoft, blue);

      case 1:
        return buildLocationCoverage(context, blueSoft, blue, groupController);

      case 2:
        return buildDescription(context, blueSoft, blue, groupController);

      case 3:
        return buildPrivacy(context, blueSoft, blue, groupController);

      case 4:
        return buildDiscussion(context, blueSoft, blue, groupController);

      case 5:
        return buildRules(context, blueSoft, blue, groupController);

      case 6:
        return buildLaunch(context, blueSoft, blue, groupController);

      default:
        return buildGroupDetails(context, blueSoft, blue);
    }
  }

  Widget buildGroupDetails(BuildContext context, Color blueSoft, Color blue) {
    return CommonCard(
      margin: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_10, right: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "1. Group Details",
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_18, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              "Tell us about your group.",
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            "Group Name*",
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_5),
          SizedBox(
            height: Dimensions.h_33,
            child: TextFormField(
              controller: TextEditingController(),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a group name';
                }
                return null;
              },
              decoration: _inputDecoration(hint: 'Enter your group name'),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              "Choose a clear, descriptive name that people will recognize.",
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: Dimensions.h_15),
          Text(
            "Category*",
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_5),
          SizedBox(
            height: Dimensions.h_33,
            child: TextFormField(
              controller: TextEditingController(),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a group name';
                }
                return null;
              },
              decoration: _inputDecoration(hint: 'Enter your group name'),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              "Choose a clear, descriptive name that people will recognize.",
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: Dimensions.h_15),
          Row(
            children: [
              Text(
                "Related Interests",
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
              ),
              SizedBox(width: Dimensions.w_3),
              Text(
                "(select all that apply)",
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          Wrap(
            spacing: Dimensions.w_6,
            runSpacing: Dimensions.h_6,
            children: interests.map((interest) {
              final selected = selectedInterests.contains(interest);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    if (selected) {
                      selectedInterests.remove(interest);
                    } else {
                      selectedInterests.add(interest);
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_6),
                  decoration: BoxDecoration(
                    color: selected ? blueSoft : Colors.transparent,
                    border: Border.all(color: selected ? blue : Theme.of(context).highlightColor, width: selected ? 0.5 : 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(selected ? Icons.check_box : Icons.check_box_outline_blank, size: Dimensions.h_13, color: selected ? blue : Colors.grey),
                      SizedBox(width: Dimensions.w_3),
                      Text(
                        interest,
                        style: TextStyle(fontSize: FontSize.sp_11, color: selected ? blue : Theme.of(context).highlightColor, fontWeight: selected ? FontWeight.w500 : FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: Dimensions.h_15),
          Text(
            "Group Purpose*",
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_5),
          TextFormField(
            maxLines: 10,
            minLines: 5,
            controller: TextEditingController(),
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a group name';
              }
              return null;
            },
            decoration: _inputDecoration(hint: 'A local mountain biking community for riders of all skill levels. We organize group rides, share trail conditions, discuss gear, help each other improve, and support trail maintenance in the Pine Valley area.'),
          ),
          SizedBox(height: Dimensions.h_5),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              "Explain what your group brings people together to do.",
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: Dimensions.h_15),
          Text(
            "Who is this group for?*",
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_10),
          ...audienceOptions.map((option) {
            final selected = audience == option.title;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => audience = option.title),
              child: Container(
                height: Dimensions.h_50,
                margin: EdgeInsets.only(bottom: Dimensions.h_6),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_4),
                decoration: BoxDecoration(color: selected ? const Color(0xFFEDF4FF) : Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.h_2),
                      child: Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: selected ? blue : Colors.grey, size: Dimensions.h_12),
                    ),
                    SizedBox(width: Dimensions.w_5),
                    Container(
                      width: Dimensions.h_25,
                      height: Dimensions.h_25,
                      decoration: BoxDecoration(color: selected ? Colors.white : Theme.of(context).cardColor, borderRadius: BorderRadius.circular(9)),
                      child: Icon(option.icon, color: blue, size: Dimensions.h_15),
                    ),
                    SizedBox(width: Dimensions.w_10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            option.title,
                            style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            option.description,
                            style: TextStyle(fontSize: FontSize.sp_9_5, height: 1.4, color: Color(0xFF52627A)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildLocationCoverage(BuildContext context, Color blueSoft, Color blue, GroupController controller) {
    const radiusOptions = [3, 5, 10, 15, 25, 50];

    final effectiveRadius = controller.isCustomRadius ? (int.tryParse(controller.customRadiusController.text) ?? 15) : controller.selectedRadius;

    return CommonCard(
      margin: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_10, right: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2. Location & Coverage',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_18, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              'Choose your primary town and the area where people can discover your group.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_10),

          Text(
            'Primary town *',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_5),

          TextFormField(
            controller: controller.primaryTownController,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your primary town';
              }
              return null;
            },
            decoration: _inputDecoration(hint: 'Enter your primary town'),
          ),

          SizedBox(height: Dimensions.h_5),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              'People in your primary town are always included. Nearby towns shown in this preview are sample locations.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
            ),
          ),

          SizedBox(height: Dimensions.h_15),

          Text(
            'Coverage radius *',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_10),

          Wrap(
            spacing: Dimensions.w_6,
            runSpacing: Dimensions.h_6,
            children: [
              ...radiusOptions.map((radius) {
                final selected = !controller.isCustomRadius && controller.selectedRadius == radius;

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    controller.selectedRadius = radius;
                    controller.isCustomRadius = false;
                    controller.update([ControllerBuilders.createGroupController]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_6),
                    decoration: BoxDecoration(
                      color: selected ? blueSoft : Colors.transparent,
                      border: Border.all(color: selected ? blue : Theme.of(context).highlightColor, width: selected ? 0.7 : 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, size: Dimensions.h_13, color: selected ? blue : Colors.grey),
                        SizedBox(width: Dimensions.w_3),
                        Text(
                          '$radius miles',
                          style: TextStyle(fontSize: FontSize.sp_11, color: selected ? blue : Theme.of(context).highlightColor, fontWeight: selected ? FontWeight.w600 : FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  controller.isCustomRadius = true;
                  controller.update([ControllerBuilders.createGroupController]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_6),
                  decoration: BoxDecoration(
                    color: controller.isCustomRadius ? blueSoft : Colors.transparent,
                    border: Border.all(color: controller.isCustomRadius ? blue : Theme.of(context).highlightColor, width: controller.isCustomRadius ? 0.7 : 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(controller.isCustomRadius ? Icons.radio_button_checked : Icons.radio_button_off, size: Dimensions.h_13, color: controller.isCustomRadius ? blue : Colors.grey),
                      SizedBox(width: Dimensions.w_3),
                      Text(
                        'Custom',
                        style: TextStyle(fontSize: FontSize.sp_11, color: controller.isCustomRadius ? blue : Theme.of(context).highlightColor, fontWeight: controller.isCustomRadius ? FontWeight.w600 : FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (controller.isCustomRadius) ...[
            SizedBox(height: Dimensions.h_12),
            Text(
              'Custom radius, in miles',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: Dimensions.h_5),
            TextFormField(
              style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
              controller: controller.customRadiusController,
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
              validator: (value) {
                if (!controller.isCustomRadius) return null;

                final radius = int.tryParse(value ?? '');
                if (radius == null || radius < 1 || radius > 100) {
                  return 'Enter a radius from 1 to 100 miles';
                }
                return null;
              },
              decoration: _inputDecoration(hint: 'Enter radius (1–100 miles)'),
            ),
            SizedBox(height: Dimensions.h_5),
            Text(
              'Choose a radius from 1 to 100 miles.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10),
            ),
          ],
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              'Your group can be discovered in nearby towns within $effectiveRadius miles.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.5),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          CoverageMapWidget(radiusMiles: controller.isCustomRadius ? (int.tryParse(controller.customRadiusController.text) ?? 15) : controller.selectedRadius, townName: controller.primaryTownController.text.trim()),
          SizedBox(height: Dimensions.h_15),
          buildTownsIncluded(context, blueSoft, blue),
        ],
      ),
    );
  }

  Widget buildTownsIncluded(BuildContext context, Color blueSoft, Color blue) {
    final List<Map<String, dynamic>> townOptions = [
      {'id': 'pine-valley', 'name': 'Pine Valley', 'distance': 0.0, 'population': 14000},
      {'id': 'ridgewood', 'name': 'Ridgewood', 'distance': 4.2, 'population': 6000},
      {'id': 'mapleton', 'name': 'Mapleton', 'distance': 6.8, 'population': 5000},
      {'id': 'cedar-grove', 'name': 'Cedar Grove', 'distance': 8.1, 'population': 4000},
      {'id': 'highland', 'name': 'Highland', 'distance': 9.3, 'population': 4000},
      {'id': 'oak-creek', 'name': 'Oak Creek', 'distance': 11.6, 'population': 3000},
      {'id': 'timber-ridge', 'name': 'Timber Ridge', 'distance': 12.4, 'population': 3000},
      {'id': 'aspen-springs', 'name': 'Aspen Springs', 'distance': 14.8, 'population': 3000},
      {'id': 'meadowbrook', 'name': 'Meadowbrook', 'distance': 17.2, 'population': 2500},
      {'id': 'willow-bend', 'name': 'Willow Bend', 'distance': 21.6, 'population': 3500},
      {'id': 'summit-crossing', 'name': 'Summit Crossing', 'distance': 28.4, 'population': 1800},
      {'id': 'brookside', 'name': 'Brookside', 'distance': 42.8, 'population': 2200},
    ];

    final int radius = groupController.isCustomRadius ? (int.tryParse(groupController.customRadiusController.text) ?? 15) : groupController.selectedRadius;

    final primaryTown = townOptions.first;

    final visibleTowns = townOptions.where((town) {
      if (town['id'] == primaryTown['id']) return true;

      final withinRadius = (town['distance'] as num) <= radius;

      if (groupController.showAllNearbyTowns) return true;

      return withinRadius;
    }).toList();

    final includedCount = groupController.selectedTownIds.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Towns included ($includedCount)',
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            SizedBox(width: Dimensions.w_8),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                groupController.showAllNearbyTowns = !groupController.showAllNearbyTowns;
                groupController.update([ControllerBuilders.createGroupController]);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.h_3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    groupController.showAllNearbyTowns ? Icon(Icons.check_box, size: Dimensions.h_15, color: blue) : Icon(Icons.check_box_outline_blank, size: Dimensions.h_15, color: Theme.of(context).highlightColor),
                    SizedBox(width: Dimensions.w_4),
                    Text(
                      'Show all (${townOptions.length})',
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.h_5),

        LayoutBuilder(
          builder: (context, constraints) {
            final spacing = Dimensions.w_4;
            final itemWidth = (constraints.maxWidth - spacing) / 2;

            return Wrap(
              spacing: spacing,
              runSpacing: Dimensions.h_8,
              children: visibleTowns.map((town) {
                final id = town['id'] as String;
                final name = town['name'] as String;
                final distance = (town['distance'] as num).toDouble();
                final isPrimary = id == primaryTown['id'];
                final isSelected = groupController.selectedTownIds.contains(id);
                final withinRadius = distance <= radius;
                final isDisabled = isPrimary || !withinRadius;

                final status = isPrimary
                    ? 'Primary town · Always included'
                    : withinRadius
                    ? 'Within coverage radius'
                    : 'Outside the current radius';

                return SizedBox(
                  width: itemWidth,
                  height: Dimensions.h_45,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Dimensions.h_6),
                    onTap: isDisabled
                        ? null
                        : () {
                            if (isSelected) {
                              groupController.selectedTownIds.remove(id);
                            } else {
                              groupController.selectedTownIds.add(id);
                            }

                            groupController.update([ControllerBuilders.createGroupController]);
                          },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: EdgeInsets.all(Dimensions.w_4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.h_6),
                        border: Border.all(color: isSelected ? blue.withValues(alpha: 0.65) : Theme.of(context).dividerColor.withValues(alpha: 0.6), width: isSelected ? 0.9 : 0.5),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: Dimensions.h_2),
                            child: Icon(
                              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                              size: Dimensions.h_13,
                              color: isSelected
                                  ? blue
                                  : withinRadius
                                  ? Theme.of(context).hintColor
                                  : Theme.of(context).highlightColor,
                            ),
                          ),
                          SizedBox(width: Dimensions.w_6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: isDisabled && !isPrimary ? Theme.of(context).highlightColor : Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.w_5),
                                    Text(
                                      distance == 0 ? '0 mi' : '${distance.toStringAsFixed(1)} mi',
                                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.h_2),
                                Text(
                                  status,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isPrimary
                                        ? blue
                                        : isDisabled
                                        ? Theme.of(context).highlightColor
                                        : Theme.of(context).highlightColor,
                                    fontSize: FontSize.sp_8,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isPrimary) ...[SizedBox(width: Dimensions.w_3), Icon(Icons.lock_outline, color: blue, size: Dimensions.h_13)],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        SizedBox(height: Dimensions.h_12),
        Container(
          padding: EdgeInsets.all(Dimensions.w_8),
          decoration: BoxDecoration(color: blue.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(Dimensions.h_5)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: blue, size: Dimensions.h_15),
              SizedBox(width: Dimensions.w_6),
              Expanded(
                child: Text(
                  'People outside your coverage area can still '
                  'request to join, subject to your membership settings.',
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDescription(BuildContext context, Color blueSoft, Color blue, GroupController controller) {
    return CommonCard(
      margin: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_10, right: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3. Description & Media',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_18, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              'Give people a clear picture of your group and what makes it special.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_10),

          Text(
            'Group description',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_5),

          TextFormField(
            minLines: 6,
            maxLines: 10,
            controller: TextEditingController(text: 'A local mountain biking community for riders of all skill levels. We plan group rides, share trail updates, exchange gear advice, and help care for the trails around Pine Valley.'),
            textCapitalization: TextCapitalization.words,
            style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor, height: 1.1),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your primary town';
              }
              return null;
            },
            decoration: _inputDecoration(hint: 'Enter your primary town'),
          ),

          SizedBox(height: Dimensions.h_5),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              'Required. Tell people what you do together, who can join, and what they can expect.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.1),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.h_6), color: Theme.of(context).scaffoldBackgroundColor),
            child: Row(
              children: [
                Icon(CupertinoIcons.sparkles, size: Dimensions.h_22, color: blue),
                SizedBox(width: Dimensions.w_8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find the right words.',
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.1),
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Text(
                        'Create a suggestion locally from the group details you have entered.',
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w400, height: 1.1),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.w_2),
                Text(
                  'Suggest ',
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, height: 1.1),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            'Coverage Photo',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_2),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              'Choose a clear photo that represents your group. A cover is included; you can choose another or upload your own.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.1),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          AppCacheImage(imageUrl: controller.selectedCover, isShadow: false, size: Dimensions.h_200, widthSize: Get.width),
          SizedBox(height: Dimensions.h_10),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.camera, size: Dimensions.h_12, color: Theme.of(context).highlightColor),
                      SizedBox(width: Dimensions.w_5),
                      Text(
                        'Change Cover',
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: Dimensions.w_10),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Remove Cover',
                  style: TextStyle(color: blue, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          SizedBox(
            height: Dimensions.h_120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: controller.coverChoices.length,
              itemBuilder: (c, i) {
                final isSelected = controller.selectedCover == controller.coverChoices[i]['url'];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    controller.selectedCover = controller.coverChoices[i]['url'] ?? '';
                    controller.update([ControllerBuilders.createGroupController]);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: Dimensions.w_8),
                        padding: EdgeInsets.only(bottom: Dimensions.h_5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.h_6),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: isSelected ? Border.all(color: blue, width: 0.8) : null,
                        ),
                        child: Column(
                          children: [
                            AppCacheImage(radius: Dimensions.h_6, imageUrl: controller.coverChoices[i]['url'] ?? '', isShadow: false, size: Dimensions.h_90, widthSize: Dimensions.h_90),
                            SizedBox(height: Dimensions.h_8),
                            Text(
                              controller.coverChoices[i]['name'] ?? '',
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: Dimensions.w_8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_8), topRight: Radius.circular(Dimensions.h_8)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_2),
                            child: Center(
                              child: Text(
                                'Selected',
                                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            'Group logo or avatar',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_8),
          Row(
            children: [
              Container(
                height: Dimensions.h_60,
                width: Dimensions.h_60,
                decoration: BoxDecoration(color: Color(0xFF007790), borderRadius: BorderRadius.circular(Dimensions.h_6)),
                child: Icon(Icons.directions_bike, size: Dimensions.h_28, color: Colors.white),
              ),
              SizedBox(width: Dimensions.w_8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(Dimensions.h_4),
                        border: Border.all(color: Theme.of(context).highlightColor, width: 0.2),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_4),
                      child: Text(
                        'Choose file',
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.h_12),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Use Default Avatar',
                      style: TextStyle(color: blue, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_15),
          Row(
            children: [
              Text(
                'Additional photos ',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
              ),
              Text(
                'Optional',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_10),
          SizedBox(
            height: Dimensions.h_150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: controller.additionalPhotos.length,
              itemBuilder: (c, i) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    controller.selectedCover = controller.additionalPhotos[i]['url'] ?? '';
                    controller.update([ControllerBuilders.createGroupController]);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: Dimensions.w_8),
                        padding: EdgeInsets.only(bottom: Dimensions.h_5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.h_6), color: Theme.of(context).scaffoldBackgroundColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppCacheImage(radius: Dimensions.h_6, imageUrl: controller.additionalPhotos[i]['url'] ?? '', isShadow: false, size: Dimensions.h_120, widthSize: Dimensions.h_140),
                            SizedBox(height: Dimensions.h_8),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.w_10),
                              child: Text(
                                controller.additionalPhotos[i]['name'] ?? '',
                                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: Dimensions.h_4,
                        right: Dimensions.w_12,
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.h_6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(color: Theme.of(context).highlightColor, width: 0.2),
                            borderRadius: BorderRadius.circular(Dimensions.h_5),
                          ),
                          child: Icon(CupertinoIcons.clear, size: Dimensions.h_12, color: Theme.of(context).highlightColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: Dimensions.h_15),
          Text(
            'Add photos to your gallery',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_10),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(Dimensions.h_4),
                border: Border.all(color: Theme.of(context).highlightColor, width: 0.2),
              ),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
              child: Text(
                'Choose file',
                style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              'Choose one or more images from your device. You can remove any photo before saving.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPrivacy(BuildContext context, Color blueSoft, Color blue, GroupController controller) {
    String selectedPrivacy = 'public';

    final List<Map<String, dynamic>> privacyOptions = [
      {'value': 'public', 'title': 'Public', 'description': 'Anyone can find your group and see basic information. You choose how membership is approved.', 'icon': Icons.public},
      {'value': 'public-approval', 'title': 'Public · Approval required', 'description': 'Anyone can find your group and request to join. An admin approves membership.', 'icon': Icons.people_outline},
      {'value': 'private', 'title': 'Private', 'description': 'People can find your group and request to join. Conversations are visible to approved or invited members.', 'icon': Icons.lock_outline},
      {'value': 'hidden', 'title': 'Hidden · Invite only', 'description': 'Only invited people can find and join. Your group is hidden from search.', 'icon': Icons.visibility_off_outlined},
    ];
    final options = [
      {'value': 'open', 'title': 'Anyone can join immediately'},
      {'value': 'approval', 'title': 'Require admin approval for all members'},
      {'value': 'outside', 'title': 'Require approval for people outside the coverage area'},
      {'value': 'invite', 'title': 'Invite only · No public join option'},
    ];

    String selectedMembershipApproval = 'open';
    final Set<String> selectedPermissions = {'posts', 'events', 'photos', 'invites', 'topics', 'comments', 'files', 'messages'};

    final permissions = [
      {'value': 'posts', 'title': 'Allow members to create posts'},
      {'value': 'events', 'title': 'Allow members to create events and activities'},
      {'value': 'photos', 'title': 'Allow members to upload photos'},
      {'value': 'invites', 'title': 'Allow members to invite others'},
      {'value': 'topics', 'title': 'Allow members to add discussion topics'},
      {'value': 'comments', 'title': 'Allow members to comment and reply'},
      {'value': 'files', 'title': 'Allow members to share files and links'},
      {'value': 'messages', 'title': 'Allow members to message other members'},
    ];

    const textColor = Color(0xFF1E293B);
    const secondaryColor = Color(0xFF64748B);
    return CommonCard(
      margin: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_10, right: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '4. Privacy & Membership',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_18, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              'Choose who can discover your group, how people join, and what members can do.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            'Group Privacy*',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_5),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: privacyOptions.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, mainAxisExtent: Dimensions.h_85),
            itemBuilder: (context, index) {
              final option = privacyOptions[index];
              final isSelected = selectedPrivacy == option['value'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPrivacy = option['value'];
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.h_5),
                  decoration: BoxDecoration(
                    color: isSelected ? blueSoft : Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.h_8),
                    border: Border.all(color: isSelected ? blue : Theme.of(context).highlightColor, width: isSelected ? 1 : 0.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Dimensions.h_25,
                            height: Dimensions.h_25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: isSelected ? blue.withValues(alpha: 0.10) : const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
                            child: Icon(option['icon'] as IconData, size: Dimensions.h_16, color: isSelected ? blue : secondaryColor),
                          ),
                          SizedBox(width: Dimensions.w_8),
                          Expanded(
                            child: Text(
                              option['title'] as String,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, color: textColor, height: 1.1),
                            ),
                          ),
                          // Icon(
                          //   isSelected
                          //       ? Icons.radio_button_checked
                          //       : Icons.radio_button_unchecked,
                          //   color: isSelected
                          //       ? blue
                          //       : const Color(0xFF94A3B8),
                          //   size: Dimensions.h_15,
                          // ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Expanded(
                        child: Text(
                          option['description'] as String,
                          style: TextStyle(fontSize: FontSize.sp_9, height: 1.2, color: Theme.of(context).highlightColor),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: Dimensions.h_10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.h_6), color: Theme.of(context).scaffoldBackgroundColor),
            child: Row(
              children: [
                Icon(CupertinoIcons.info, size: Dimensions.h_15, color: blue),
                SizedBox(width: Dimensions.w_8),
                Expanded(
                  child: Text(
                    'Anyone can find your group and see basic information. Invited people only.',
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w400, height: 1.1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.h_15),
          Text(
            'Membership approval',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_5),
            child: Text(
              'Choose how people become members. Available options follow your group privacy and audience.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.1),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          ...options.map((option) {
            final isSelected = selectedMembershipApproval == option['value'];

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedMembershipApproval = option['value']!;
                });
              },
              child: Container(
                margin: EdgeInsets.only(bottom: Dimensions.h_8),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5),
                child: Row(
                  children: [
                    Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked, size: Dimensions.h_16, color: isSelected ? blue : const Color(0xFF94A3B8)),
                    SizedBox(width: Dimensions.w_8),
                    Expanded(
                      child: Text(
                        option['title']!,
                        style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.3),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: Dimensions.h_5),
          Row(
            children: [
              Text(
                'Membership questions',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
              ),
              SizedBox(width: Dimensions.w_2),
              Text(
                '(Optional)',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_2),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: Text(
              'Ask a few questions to understand potential members. Admins can use the answers when reviewing join requests.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.1),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          TextFormField(
            minLines: 6,
            maxLines: 10,
            controller: TextEditingController(),
            textCapitalization: TextCapitalization.words,
            style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor, height: 1.1),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your primary town';
              }
              return null;
            },
            decoration: _inputDecoration(hint: 'Why would you like to join? What kind of ride do you enjoy?'),
          ),
          SizedBox(height: Dimensions.h_15),
          Text(
            'Member permissions',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              'Choose what members can do. Admins keep access to manage the group.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_5),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 8.0;
              final itemWidth = (constraints.maxWidth - spacing) / 2;

              return Wrap(
                spacing: spacing,
                runSpacing: 8,
                children: permissions.map((permission) {
                  final value = permission['value']!;
                  final isSelected = selectedPermissions.contains(value);

                  return SizedBox(
                    width: itemWidth,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedPermissions.remove(value);
                          } else {
                            selectedPermissions.add(value);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank, size: Dimensions.h_16, color: isSelected ? blue : const Color(0xFF94A3B8)),
                            SizedBox(width: Dimensions.w_6),
                            Expanded(
                              child: Text(
                                permission['title']!,
                                style: TextStyle(fontSize: FontSize.sp_9_5, height: 1.3, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDiscussion(BuildContext context, Color blueSoft, Color blue, GroupController controller) {
    final Set<String> selectedTopics = {'rides', 'trails', 'gear', 'skills', 'photos', 'general'};

    final topics = [
      {'value': 'rides', 'title': 'Group Rides'},
      {'value': 'trails', 'title': 'Trail Updates'},
      {'value': 'gear', 'title': 'Gear & Tech'},
      {'value': 'skills', 'title': 'Skills & Advice'},
      {'value': 'photos', 'title': 'Ride Photos'},
      {'value': 'general', 'title': 'General Conversation'},
    ];

    bool photoSharing = true;
    bool allowComments = true;
    return CommonCard(
      margin: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_10, right: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5. Discussion Settings',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_18, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              'Give your community a few useful places to start talking.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            'Discussion Topics',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_5),
          Wrap(
            spacing: Dimensions.w_8,
            runSpacing: Dimensions.h_8,
            children: topics.map((topic) {
              final value = topic['value']!;
              final isSelected = selectedTopics.contains(value);

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedTopics.remove(value);
                    } else {
                      selectedTopics.add(value);
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.w_5),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_7),
                  decoration: BoxDecoration(
                    color: isSelected ? blueSoft : Colors.transparent,
                    borderRadius: BorderRadius.circular(Dimensions.h_4),
                    border: Border.all(color: isSelected ? blue : Theme.of(context).highlightColor, width: isSelected ? 0.5 : 0.2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_box, size: Dimensions.h_12, color: blue),
                      SizedBox(width: Dimensions.w_4),
                      Text(
                        topic['title']!,
                        style: TextStyle(fontSize: FontSize.sp_10, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500, color: isSelected ? blue : Theme.of(context).highlightColor),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: Dimensions.h_15),
          Text(
            'Post Moderation',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_8),
          SizedBox(
            height: Dimensions.h_33,
            child: TextFormField(
              controller: TextEditingController(text: 'Members Can post directly'),
              textCapitalization: TextCapitalization.words,
              style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor, height: 1.1),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your primary town';
                }
                return null;
              },
              decoration: _inputDecoration(hint: 'Why would you like to join? What kind of ride do you enjoy?'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_8),
            child: Text(
              'Choose how much review your group’s conversations need.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.1),
            ),
          ),
          SizedBox(height: Dimensions.h_15),
          Text(
            'Sharing Options',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_10),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.w_5),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
              decoration: BoxDecoration(
                color: photoSharing == true ? blueSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimensions.h_4),
                border: Border.all(color: photoSharing == true ? blue : Theme.of(context).highlightColor, width: photoSharing == true ? 0.5 : 0.2),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_box, size: Dimensions.h_16, color: blue),
                  SizedBox(width: Dimensions.w_8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allow Photo Sharing',
                        style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, color: Theme.of(context).highlightColor),
                      ),
                      Text(
                        'Members can add photos to their group posts.',
                        style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.w_5),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
              decoration: BoxDecoration(
                color: allowComments == true ? blueSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimensions.h_4),
                border: Border.all(color: allowComments == true ? blue : Theme.of(context).highlightColor, width: allowComments == true ? 0.5 : 0.2),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_box, size: Dimensions.h_16, color: blue),
                  SizedBox(width: Dimensions.w_8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allow Comments',
                        style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, color: Theme.of(context).highlightColor),
                      ),
                      Text(
                        'Keep the conversation going beneath each post.',
                        style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRules(BuildContext context, Color blueSoft, Color blue, GroupController controller) {
    bool photoSharing = true;
    bool allowComments = true;
    return CommonCard(
      margin: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_10, right: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '6. Rules & Guidelines',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_18, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              'Set a friendly, clear standard for your riding community.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            'Starter Rules',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_5),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.w_5),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
              decoration: BoxDecoration(
                color: photoSharing == true ? blueSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimensions.h_4),
                border: Border.all(color: photoSharing == true ? blue : Theme.of(context).highlightColor, width: photoSharing == true ? 0.5 : 0.2),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_box, size: Dimensions.h_16, color: blue),
                  SizedBox(width: Dimensions.w_8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allow Photo Sharing',
                        style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, color: Theme.of(context).highlightColor),
                      ),
                      Text(
                        'Members can add photos to their group posts.',
                        style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.w_5),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
              decoration: BoxDecoration(
                color: allowComments == true ? blueSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimensions.h_4),
                border: Border.all(color: allowComments == true ? blue : Theme.of(context).highlightColor, width: allowComments == true ? 0.5 : 0.2),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_box, size: Dimensions.h_16, color: blue),
                  SizedBox(width: Dimensions.w_8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allow Comments',
                        style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, color: Theme.of(context).highlightColor),
                      ),
                      Text(
                        'Keep the conversation going beneath each post.',
                        style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.w_5),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
              decoration: BoxDecoration(
                color: photoSharing == true ? blueSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimensions.h_4),
                border: Border.all(color: photoSharing == true ? blue : Theme.of(context).highlightColor, width: photoSharing == true ? 0.5 : 0.2),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_box, size: Dimensions.h_16, color: blue),
                  SizedBox(width: Dimensions.w_8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allow Photo Sharing',
                        style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, color: Theme.of(context).highlightColor),
                      ),
                      Text(
                        'Members can add photos to their group posts.',
                        style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.w_5),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
              decoration: BoxDecoration(
                color: allowComments == true ? blueSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimensions.h_4),
                border: Border.all(color: allowComments == true ? blue : Theme.of(context).highlightColor, width: allowComments == true ? 0.5 : 0.2),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_box, size: Dimensions.h_16, color: blue),
                  SizedBox(width: Dimensions.w_8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Allow Comments',
                        style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, color: Theme.of(context).highlightColor),
                      ),
                      Text(
                        'Keep the conversation going beneath each post.',
                        style: TextStyle(fontSize: FontSize.sp_9, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_15),
          Row(
            children: [
              Text(
                'Additional Guidelines ',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
              ),
              Text(
                '(Optional)',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: Dimensions.h_8),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5),
            child: TextFormField(
              minLines: 7,
              maxLines: 10,
              controller: TextEditingController(),
              textCapitalization: TextCapitalization.words,
              style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, color: Theme.of(context).highlightColor, height: 1.1),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your primary town';
                }
                return null;
              },
              decoration: _inputDecoration(hint: ''),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_8),
            child: Text(
              'For example, your ride check-in routine or how to organize a group outing.',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLaunch(BuildContext context, Color blueSoft, Color blue, GroupController controller) {
    final textColor = Theme.of(context).highlightColor;
    final secondaryColor = Theme.of(context).textTheme.bodySmall?.color;

    Widget reviewSection({required String title, required int step, required List<Map<String, String>> fields, bool showDiscussionActions = false}) {
      return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.h_18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: textColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                  ),
                ),
                if (showDiscussionActions) ...[
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Edit discussions',
                      style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_8),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Edit rules',
                      style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                    ),
                  ),
                ] else
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Edit',
                      style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                    ),
                  ),
              ],
            ),
            SizedBox(height: Dimensions.h_4),
            ...fields.map(
              (field) => Container(
                margin: EdgeInsets.only(left: Dimensions.w_5),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Theme.of(context).highlightColor, width: 0.15)),
                ),
                padding: EdgeInsets.only(bottom: Dimensions.h_8, top: Dimensions.h_8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Dimensions.w_90,
                      child: Text(
                        field['label']!,
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_20),
                    Expanded(
                      child: Text(
                        field['value']!,
                        style: TextStyle(color: textColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return CommonCard(
      margin: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_10, right: Dimensions.w_10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7. Review & Launch',
            style: TextStyle(color: textColor, fontSize: FontSize.sp_18, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: Dimensions.h_4),
          Padding(
            padding: EdgeInsets.only(left: Dimensions.w_8),
            child: Text(
              'One last look at the community you’re creating.',
              style: TextStyle(color: secondaryColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_15),

          reviewSection(
            title: 'Group Details',
            step: 1,
            fields: [
              {'label': 'Group Name', 'value': 'Pine Valley Mountain Bike Crew'},
              {'label': 'Category', 'value': 'Sports & Recreation — Cycling'},
              {'label': 'Related Interests', 'value': 'Mountain Biking, Trail Riding, Enduro, Cross Country (XC), Downhill, Local Trails, Fitness'},
              {'label': 'Purpose', 'value': 'A local mountain biking community for riders of all skill levels. We organize group rides, share trail conditions, discuss gear, help each other improve, and support trail maintenance in the Pine Valley area.'},
              {'label': 'Who It’s For', 'value': 'Everyone · All skill levels welcome'},
            ],
          ),

          reviewSection(
            title: 'Location & Coverage',
            step: 2,
            fields: [
              {'label': 'Primary Town', 'value': 'Cedar Grove, CO · 1 town'},
              {'label': 'Coverage Radius', 'value': '3 miles'},
            ],
          ),

          reviewSection(
            title: 'Description & Media',
            step: 3,
            fields: [
              {'label': 'Description', 'value': 'A local mountain biking community for riders of all skill levels. We plan group rides, share trail updates, exchange gear advice, and help care for the trails around Pine Valley.'},
              {'label': 'Photos', 'value': 'Cover selected · Bike avatar · 3 gallery photos'},
            ],
          ),

          reviewSection(
            title: 'Privacy & Membership',
            step: 4,
            fields: [
              {'label': 'Group Visibility', 'value': 'Public'},
              {'label': 'Who Can Join', 'value': 'Invited people only'},
              {'label': 'Membership Questions', 'value': 'No questions added'},
              {'label': 'Member Permissions', 'value': 'Create posts, create events and activities, upload photos, invite others, add discussion topics, comment and reply, share files and links, message other members'},
            ],
          ),

          reviewSection(
            title: 'Conversations & Guidelines',
            step: 5,
            showDiscussionActions: true,
            fields: [
              {'label': 'Topics', 'value': 'Group Rides, Trail Updates, Gear & Tech, Skills & Advice, Ride Photos, General Conversation'},
              {'label': 'Moderation', 'value': 'Members can post directly'},
              {'label': 'Discussion Sharing', 'value': 'Photos enabled · Comments enabled'},
              {'label': 'Rules', 'value': '4 starter rules'},
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: FontSize.sp_11, color: Theme.of(context).hintColor),
      contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.h_4),
        borderSide: BorderSide(color: Theme.of(context).highlightColor, width: 0.1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.h_4),
        borderSide: BorderSide(color: Theme.of(context).highlightColor, width: 0.1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.h_4),
        borderSide: BorderSide(color: Theme.of(context).highlightColor, width: 0.1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.h_4),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  Widget buildHeroHeader(bool isLight) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(alignment: Alignment(0.8, 0), size: Dimensions.h_250, widthSize: Get.width, imageUrl: "https://preetis-html.vercel.app/assets/images/groups/create-group/hero.webp"),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_250,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.35), Colors.transparent], stops: const [0.0, 0.40, 0.68, 1.0]),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.h_250,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_80),
                child: Text(
                  'A place for your people, Sean'.toUpperCase(),
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_5),
                child: Text(
                  "Create a Group",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_26,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_4, right: Dimensions.w_60),
                child: Text(
                  'Build a local community around the trails, people, and adventures you love.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_12,
                    fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h_10),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.person_2, size: Dimensions.h_13, fontWeight: FontWeight.bold, color: Colors.white),
                        SizedBox(width: Dimensions.w_8),
                        Text(
                          'Connect local people',
                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, color: AppColor.white, height: 1),
                        ),
                      ],
                    ),
                    SizedBox(width: Dimensions.w_8),
                    Row(
                      children: [
                        Icon(Icons.directions_bike, size: Dimensions.h_13, fontWeight: FontWeight.bold, color: Colors.white),
                        SizedBox(width: Dimensions.w_8),
                        Text(
                          'Organize activities',
                          style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w700, color: AppColor.white, height: 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(height: Dimensions.h_15),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: Dimensions.h_15,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [context.sports.background.withValues(alpha: 0.0), context.sports.background.withValues(alpha: 0.15), context.sports.background.withValues(alpha: 0.35), context.sports.background.withValues(alpha: 0.78), context.sports.background],
                stops: const [0.08, 0.25, 0.45, 0.75, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CoverageMapWidget extends StatefulWidget {
  final int radiusMiles;
  final String townName;

  const CoverageMapWidget({super.key, required this.radiusMiles, required this.townName});

  @override
  State<CoverageMapWidget> createState() => _CoverageMapWidgetState();
}

class _CoverageMapWidgetState extends State<CoverageMapWidget> {
  bool isTerrainView = false;
  double zoom = 1.0;

  static const Color blue = Color(0xFF1674DF);

  void zoomIn() {
    setState(() {
      zoom = (zoom + 0.2).clamp(1.0, 2.0);
    });
  }

  void zoomOut() {
    setState(() {
      zoom = (zoom - 0.2).clamp(1.0, 2.0);
    });
  }

  void resetMap() {
    setState(() {
      zoom = 1.0;
      isTerrainView = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.h_5)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.h_250,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRect(
                    child: AnimatedScale(
                      scale: zoom,
                      duration: const Duration(milliseconds: 250),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppCacheImage(imageUrl: isTerrainView ? 'https://preetis-html.vercel.app/assets/images/groups/create-group/coverage-terrain.svg' : 'https://preetis-html.vercel.app/assets/images/groups/create-group/coverage-map.svg', fit: BoxFit.cover),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final mapSize = Size(constraints.maxWidth, constraints.maxHeight);

                              return Stack(
                                children: [
                                  CustomPaint(
                                    size: mapSize,
                                    painter: CoverageRingPainter(radiusMiles: widget.radiusMiles),
                                  ),
                                  Positioned(
                                    left: mapSize.width / 2 - Dimensions.w_10,
                                    top: mapSize.height / 2 - Dimensions.h_18,
                                    child: Icon(Icons.location_on, color: blue, size: Dimensions.h_20),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: Dimensions.w_3,
                  top: Dimensions.h_6,
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.h_3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.h_6),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8)],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _viewButton(
                          label: 'Map view',
                          selected: !isTerrainView,
                          onTap: () {
                            setState(() => isTerrainView = false);
                          },
                        ),
                        _viewButton(
                          label: 'Terrain view',
                          selected: isTerrainView,
                          onTap: () {
                            setState(() => isTerrainView = true);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Column(
                    children: [
                      _mapControl(icon: Icons.add, tooltip: 'Zoom in', onTap: zoomIn, disabled: zoom >= 2.0),
                      const SizedBox(height: 6),
                      _mapControl(icon: Icons.remove, tooltip: 'Zoom out', onTap: zoomOut, disabled: zoom <= 1.0),
                      const SizedBox(height: 6),
                      _mapControl(icon: Icons.refresh, tooltip: 'Reset map', onTap: resetMap),
                    ],
                  ),
                ),
                Positioned(
                  left: Dimensions.w_4,
                  bottom: Dimensions.h_8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.h_6),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8)],
                    ),
                    child: Text(
                      '${widget.radiusMiles} mile radius',
                      style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, color: blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewButton({required String label, required bool selected, required VoidCallback onTap}) {
    return Material(
      color: selected ? blue : Colors.transparent,
      borderRadius: BorderRadius.circular(Dimensions.h_4),
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimensions.h_4),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            label,
            style: TextStyle(color: selected ? Colors.white : Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _mapControl({required IconData icon, required String tooltip, required VoidCallback onTap, bool disabled = false}) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: disabled ? null : onTap,
        child: Tooltip(
          message: tooltip,
          child: SizedBox(width: 38, height: 38, child: Icon(icon, size: 20, color: disabled ? Theme.of(context).disabledColor : Theme.of(context).iconTheme.color)),
        ),
      ),
    );
  }
}

class CoverageRingPainter extends CustomPainter {
  final int radiusMiles;

  const CoverageRingPainter({required this.radiusMiles});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    const double pixelsPerMile = 3.0;

    final radius = (radiusMiles * pixelsPerMile).clamp(12.0, size.shortestSide / 2 - 8).toDouble();

    final fillPaint = Paint()
      ..color = const Color(0xFF1674DF).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFF1674DF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, fillPaint);

    const dashLength = 7.0;
    const gapLength = 4.0;
    final circumference = 2 * 3.141592653589793 * radius;
    final segmentCount = (circumference / (dashLength + gapLength)).floor();

    for (var i = 0; i < segmentCount; i++) {
      final startAngle = i * (dashLength + gapLength) / radius;

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, dashLength / radius, false, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CoverageRingPainter oldDelegate) {
    return oldDelegate.radiusMiles != radiusMiles;
  }
}

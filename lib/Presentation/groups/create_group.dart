import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:latlong2/latlong.dart';
import 'package:wikixm/Presentation/groups/create_group_controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/extensions.dart';
import '../../constants/fontsize.dart';
import '../../data/datasource/remote/models/response/create_group.dart';
import '../widgets/cache_image.dart';
import '../widgets/common_sliver_scaffold.dart';
import '../widgets/common_dropdown.dart';
import '../widgets/common_shimmer.dart';
import '../widgets/common_text_field.dart';

IconData groupOptionIcon(String? name) => switch (name) {
  'users' => CupertinoIcons.person_2,
  'user' => CupertinoIcons.person,
  'chart-bars' => Icons.bar_chart,
  'lock' => CupertinoIcons.lock,
  'globe' => Icons.public,
  'eye-off' => Icons.visibility_off_outlined,
  'calendar' => Icons.calendar_today_outlined,
  'chat' => CupertinoIcons.chat_bubble_2,
  'camera' => CupertinoIcons.camera,
  _ => Icons.circle_outlined,
};

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  static const steps = ['Group Details', 'Location & Coverage', 'Description & Media', 'Privacy & Membership', 'Discussion Settings', 'Rules & Guidelines', 'Review & Launch'];

  @override
  Widget build(BuildContext context) {
    final createGroupController = Get.isRegistered<CreateGroupController>() ? Get.find<CreateGroupController>() : Get.put(CreateGroupController());
    bool isLight = Theme.of(context).brightness == Brightness.light;
    final blue = AppColor.blue(context);
    final blueSoft = AppColor.createGroupBlueSoft(context);
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: Dimensions.w_15, right: Dimensions.w_15, bottom: Dimensions.h_20, top: Dimensions.h_5),
        child: GetBuilder<CreateGroupController>(
          id: ControllerBuilders.createGroupController,
          builder: (controller) {
            final isLastStep = controller.currentStep == CreateGroupController.totalSteps - 1;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: controller.previousStep,
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
                ),
                // always laid out so the bar does not shift when options arrive; inactive until then
                GestureDetector(
                  onTap: controller.isSubmitting || controller.options == null ? null : controller.nextStep,
                  child: Container(
                    decoration: BoxDecoration(color: controller.options == null ? blue.withValues(alpha: 0.4) : blue, borderRadius: BorderRadius.circular(Dimensions.h_4)),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
                    child: Row(
                      children: [
                        Text(
                          isLastStep ? 'Create Group' : 'Next Step',
                          style: TextStyle(color: AppColor.white, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: Dimensions.w_5),
                        controller.isSubmitting
                            ? SizedBox(
                                width: Dimensions.h_12,
                                height: Dimensions.h_12,
                                child: CircularProgressIndicator(strokeWidth: 1.5, color: AppColor.white),
                              )
                            : Icon(isLastStep ? CupertinoIcons.check_mark : CupertinoIcons.arrow_right, size: Dimensions.h_12, color: AppColor.white),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: CommonScrollBlurScaffold(
        controller: createGroupController.scrollController,
        showBack: true,
        expandedHeight: Dimensions.h_170,
        expandedColor: AppColor.white,
        collapsedColor: Theme.of(context).highlightColor,
        hero: buildHeroHeader(context, isLight, createGroupController.firstName),
        slivers: [
          SliverToBoxAdapter(
            child: GetBuilder<CreateGroupController>(
              id: ControllerBuilders.createGroupProgress,
              builder: (controller) {
                final step = controller.currentStep;
                final completedStep = step + 1;
                final stepProgress = controller.stepProgress;

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
                              '${completedStep.toString().padLeft(2, '0')} / ${steps.length.toString().padLeft(2, '0')}',
                              style: TextStyle(color: blue, fontSize: FontSize.sp_12, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.h_10),
                      Row(
                        children: List.generate(steps.length, (index) {
                          // each segment fills with how much of that page is filled in
                          return Expanded(
                            child: Container(
                              height: Dimensions.h_5,
                              margin: EdgeInsets.only(right: index == steps.length - 1 ? 0 : Dimensions.w_5),
                              clipBehavior: Clip.antiAlias,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(color: AppColor.border(context), borderRadius: BorderRadius.circular(20)),
                              child: AnimatedFractionallySizedBox(
                                duration: const Duration(milliseconds: 250),
                                widthFactor: stepProgress[index],
                                heightFactor: 1,
                                child: Container(color: blue),
                              ),
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
                            '${controller.progressPercent}% Complete',
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
            child: GetBuilder<CreateGroupController>(id: ControllerBuilders.createGroupController, builder: (controller) => buildSteps(context, blueSoft, blue, controller)),
          ),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.h_20)),
        ],
      ),
    );
  }

  Widget buildSteps(BuildContext context, Color blueSoft, Color blue, CreateGroupController controller) {
    if (controller.isLoading) return buildDetailsShimmer(context);
    if (controller.options == null) {
      return _card(
        children: [
          _hint(context, controller.loadError ?? 'Could not load group options.'),
          SizedBox(height: Dimensions.h_10),
          _textButton('Try again', blue, controller.loadOptions),
        ],
      );
    }
    return switch (controller.currentStep) {
      1 => buildLocationCoverage(context, blueSoft, blue, controller),
      2 => buildDescription(context, blueSoft, blue, controller),
      3 => buildPrivacy(context, blueSoft, blue, controller),
      4 => buildDiscussion(context, blueSoft, blue, controller),
      5 => buildRules(context, blueSoft, blue, controller),
      6 => buildLaunch(context, blueSoft, blue, controller),
      _ => buildGroupDetails(context, blueSoft, blue, controller),
    };
  }

  /// Same shape as step 1 (title, name, category, purpose, audience) so content swaps in without a jump.
  Widget buildDetailsShimmer(BuildContext context) {
    Widget field(double labelWidth, double height) => Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h_15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(labelWidth, Dimensions.h_12),
          SizedBox(height: Dimensions.h_6),
          ShimmerBox(double.infinity, height, radius: Dimensions.h_4),
        ],
      ),
    );
    return _card(
      children: [
        ShimmerBox(Dimensions.w_150, Dimensions.h_18),
        SizedBox(height: Dimensions.h_6),
        ShimmerBox(Dimensions.w_120, Dimensions.h_10),
        SizedBox(height: Dimensions.h_15),
        field(Dimensions.w_90, Dimensions.h_35),
        field(Dimensions.w_60, Dimensions.h_35),
        field(Dimensions.w_90, Dimensions.h_90),
        ShimmerBox(Dimensions.w_120, Dimensions.h_12),
        SizedBox(height: Dimensions.h_8),
        for (var i = 0; i < 4; i++)
          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.h_6),
            child: ShimmerBox(double.infinity, Dimensions.h_45, radius: 10),
          ),
      ],
    );
  }

  Widget buildGroupDetails(BuildContext context, Color blueSoft, Color blue, CreateGroupController controller) {
    final form = controller.form!;
    return _card(
      children: [
        _stepTitle(context, '1. Group Details', 'Tell us about your group.'),
        _label(context, 'Group Name*'),
        CommonTextField(
          controller: controller.nameController,
          hint: 'Enter your group name',
          errorText: controller.errorOf('name'),
          onChanged: (_) => controller.clearError('name'),
          maxLength: CreateGroupController.maxNameLength,
          fontSize: FontSize.sp_12,
          textCapitalization: TextCapitalization.words,
        ),
        _hint(context, 'Choose a clear, descriptive name that people will recognize.'),
        SizedBox(height: Dimensions.h_15),
        Row(
          children: [
            Expanded(child: _label(context, 'Category*')),
            _aiButton(context, blue, controller, 'suggest_group_details', 'Suggest', controller.suggestCategory),
          ],
        ),
        CommonDropdown<GroupCategory>(
          items: controller.categories,
          value: controller.categories.firstWhereOrNull((c) => c.id == controller.categoryId),
          itemLabel: (c) => c.name ?? '',
          hint: 'Select a category',
          height: kMinInteractiveDimension, // CommonTextField's single-line height
          radius: Dimensions.h_4,
          textFieldStyle: true,
          onChanged: (c) => controller.selectCategory(c.id),
        ),
        if (controller.subcategories.isNotEmpty) ...[
          SizedBox(height: Dimensions.h_12),
          _label(context, 'Subcategory*'),
          CommonDropdown<GroupCategory>(
            items: controller.subcategories,
            value: controller.subcategories.firstWhereOrNull((c) => c.id == controller.subcategoryId),
            itemLabel: (c) => c.name ?? '',
            hint: 'Select a subcategory',
            height: kMinInteractiveDimension,
            radius: Dimensions.h_4,
            textFieldStyle: true,
            onChanged: (c) => controller.selectSubcategory(c.id),
          ),
        ],
        if (controller.subcategoryInterests.isNotEmpty) ...[
          SizedBox(height: Dimensions.h_12),
          Row(
            children: [
              _label(context, 'Related Interests*'),
              SizedBox(width: Dimensions.w_3),
              Text(
                '(select all that apply)',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          _wrap([
            for (final i in controller.subcategoryInterests)
              _checkChip(context, blueSoft, blue, label: i.name ?? '', selected: controller.interestIds.contains(i.id), onTap: () => controller.toggleInterest(i.id!)),
          ]),
        ],
        _error(context, controller.errorOf('interests')),
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Group Purpose*'),
        CommonTextField(
          controller: controller.purposeController,
          hint: 'What does your group bring people together to do?',
          errorText: controller.errorOf('purpose'),
          onChanged: (_) => controller.clearError('purpose'),
          minLines: 5,
          maxLines: 10,
        ),
        _hint(context, 'Explain what your group brings people together to do.'),
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Who is this group for?*'),
        SizedBox(height: Dimensions.h_5),
        ...form.audience.map((option) {
          final selected = controller.audience == option.value;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => controller.selectAudience(option.value),
            child: Container(
              margin: EdgeInsets.only(bottom: Dimensions.h_6),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8, vertical: Dimensions.h_6),
              decoration: BoxDecoration(color: selected ? blueSoft : Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: selected ? blue : AppColor.muted(context), size: Dimensions.h_12),
                  SizedBox(width: Dimensions.w_5),
                  Container(
                    width: Dimensions.h_25,
                    height: Dimensions.h_25,
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(9)),
                    child: Icon(groupOptionIcon(option.icon), color: blue, size: Dimensions.h_15),
                  ),
                  SizedBox(width: Dimensions.w_10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.label,
                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                        ),
                        if (option.description != null)
                          Text(
                            option.description!,
                            style: TextStyle(fontSize: FontSize.sp_9_5, height: 1.4, color: AppColor.muted(context)),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        if (controller.audience == 'skill' || controller.audience == 'type') ...[
          SizedBox(height: Dimensions.h_5),
          _wrap([
            for (final o in controller.audience == 'skill' ? form.audienceSkill : form.audienceType)
              _choiceChip(context, blueSoft, blue, label: o.label, selected: controller.audienceDetail == o.value, onTap: () => controller.selectAudienceDetail(o.value)),
          ]),
        ],
        if (controller.audience == 'invite') ...[
          SizedBox(height: Dimensions.h_5),
          CommonTextField(
            controller: controller.audienceInviteController,
            hint: 'Describe who you would like to invite',
            errorText: controller.errorOf('audience_detail'),
            onChanged: (_) => controller.clearError('audience_detail'),
            minLines: 5,
            maxLines: 10,
          ),
        ],
      ],
    );
  }

  Widget buildLocationCoverage(BuildContext context, Color blueSoft, Color blue, CreateGroupController controller) {
    final towns = controller.options!.towns;
    return _card(
      children: [
        _stepTitle(context, '2. Location & Coverage', 'Choose your primary town and the area where people can discover your group.'),
        _label(context, 'Primary town *'),
        _wrap([
          for (final t in towns)
            _choiceChip(context, blueSoft, blue, label: t.isPrimary == true ? '${t.name} (primary)' : t.name ?? '', selected: controller.cityId == t.id, onTap: () => controller.selectTown(t.id)),
        ]),
        _error(context, controller.errorOf('city')),
        _hint(context, 'You can create a group in your primary town or an active secondary town. It is always included.'),
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Coverage radius *'),
        _wrap([
          for (final r in controller.options!.radiusOptions)
            _choiceChip(context, blueSoft, blue, label: r == 0 ? 'Town only' : '$r miles', selected: controller.radius == r, onTap: () => controller.selectRadius(r)),
        ]),
        _hint(context, controller.radius == 0 ? 'Your group can be discovered in your primary town only.' : 'Your group can be discovered in nearby towns within ${controller.radius} miles.'),
        SizedBox(height: Dimensions.h_5),
        CoverageMapWidget(origin: controller.originTown, radiusMiles: controller.radius, towns: controller.coverageTowns, includedTownIds: controller.includedTownIds),
        SizedBox(height: Dimensions.h_15),
        buildTownsIncluded(context, blueSoft, blue, controller),
      ],
    );
  }

  Widget buildTownsIncluded(BuildContext context, Color blueSoft, Color blue, CreateGroupController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Towns included (${controller.includedTownIds.length})',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13, fontWeight: FontWeight.w700),
            ),
            if (controller.coverageLoading) ...[
              SizedBox(width: Dimensions.w_8),
              SizedBox(
                width: Dimensions.h_12,
                height: Dimensions.h_12,
                child: CircularProgressIndicator(strokeWidth: 1.5, color: blue),
              ),
            ],
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
              children: controller.coverageTowns.map((town) {
                final isPrimary = town.id == controller.cityId;
                final isSelected = controller.includedTownIds.contains(town.id);
                final distance = town.distanceMiles ?? 0;
                return SizedBox(
                  width: itemWidth,
                  height: Dimensions.h_45,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Dimensions.h_6),
                    onTap: isPrimary ? null : () => controller.toggleTown(town.id!),
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
                            child: Icon(isSelected ? Icons.check_circle : Icons.radio_button_unchecked, size: Dimensions.h_13, color: isSelected ? blue : Theme.of(context).hintColor),
                          ),
                          SizedBox(width: Dimensions.w_6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        town.name ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
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
                                  isPrimary ? 'Primary town · Always included' : 'Within coverage radius',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: isPrimary ? blue : Theme.of(context).highlightColor, fontSize: FontSize.sp_8, height: 1.3),
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
                  'People outside your coverage area can still request to join, subject to your membership settings.',
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDescription(BuildContext context, Color blueSoft, Color blue, CreateGroupController controller) {
    final aiBusy = controller.aiAction == 'generate_description' || controller.aiAction == 'improve_description';
    return _card(
      children: [
        _stepTitle(context, '3. Description & Media', 'Give people a clear picture of your group and what makes it special.'),
        _label(context, 'Group description*'),
        CommonTextField(
          controller: controller.descriptionController,
          hint: 'Tell people what you do together, who can join, and what they can expect.',
          errorText: controller.errorOf('description'),
          onChanged: (_) => controller.clearError('description'),
          maxLength: CreateGroupController.maxDescriptionLength,
          minLines: 6,
          maxLines: 10,
        ),
        SizedBox(height: Dimensions.h_5),
        GestureDetector(
          onTap: aiBusy ? null : controller.suggestDescription,
          child: Container(
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
                        controller.descriptionController.text.trim().isEmpty ? 'Generate a description from your group details.' : 'Improve the description you have written.',
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9_5, height: 1.1),
                      ),
                    ],
                  ),
                ),
                aiBusy
                    ? SizedBox(
                        width: Dimensions.h_12,
                        height: Dimensions.h_12,
                        child: CircularProgressIndicator(strokeWidth: 1.5, color: blue),
                      )
                    : Text(
                        'Suggest',
                        style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Cover photo*'),
        _hint(context, 'Choose a clear photo that represents your group. JPG, PNG or WebP, up to 5 MB.'),
        SizedBox(height: Dimensions.h_5),
        if (controller.coverPath != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.h_6),
            child: Image.file(File(controller.coverPath!), height: Dimensions.h_200, width: double.infinity, fit: BoxFit.cover, cacheWidth: 1080),
          ),
        SizedBox(height: Dimensions.h_8),
        Row(
          children: [
            _outlinedButton(context, controller.coverPath == null ? 'Choose cover' : 'Change cover', controller.pickCover, icon: CupertinoIcons.camera),
            if (controller.coverPath != null) ...[SizedBox(width: Dimensions.w_10), _textButton('Remove cover', blue, controller.removeCover)],
          ],
        ),
        _error(context, controller.errorOf('cover')),
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Group photo'),
        SizedBox(height: Dimensions.h_5),
        Row(
          children: [
            Container(
              height: Dimensions.h_60,
              width: Dimensions.h_60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: blueSoft, borderRadius: BorderRadius.circular(Dimensions.h_6)),
              child: controller.avatarPath != null ? Image.file(File(controller.avatarPath!), fit: BoxFit.cover, cacheWidth: 240) : Icon(CupertinoIcons.person_2, size: Dimensions.h_28, color: blue),
            ),
            SizedBox(width: Dimensions.w_8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _outlinedButton(context, 'Choose file', controller.pickAvatar),
                if (controller.avatarPath != null) ...[SizedBox(height: Dimensions.h_12), _textButton('Remove photo', blue, controller.removeAvatar)],
              ],
            ),
          ],
        ),
        _error(context, controller.errorOf('avatar')),
        SizedBox(height: Dimensions.h_15),
        Row(
          children: [
            _label(context, 'Gallery photos '),
            Text(
              '${controller.galleryPaths.length}/${CreateGroupController.maxGalleryImages}',
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_9),
            ),
          ],
        ),
        if (controller.galleryPaths.isNotEmpty) ...[
          SizedBox(height: Dimensions.h_8),
          SizedBox(
            height: Dimensions.h_120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: controller.galleryPaths.length,
              itemBuilder: (c, i) => Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: Dimensions.w_8),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.h_6)),
                    child: Image.file(File(controller.galleryPaths[i]), height: Dimensions.h_120, width: Dimensions.h_140, fit: BoxFit.cover, cacheWidth: 480),
                  ),
                  Positioned(
                    top: Dimensions.h_4,
                    right: Dimensions.w_12,
                    child: GestureDetector(
                      onTap: () => controller.removeGalleryImage(i),
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.h_6),
                        decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_5)),
                        child: Icon(CupertinoIcons.clear, size: Dimensions.h_12, color: Theme.of(context).highlightColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        if (controller.galleryPaths.length < CreateGroupController.maxGalleryImages) ...[SizedBox(height: Dimensions.h_8), _outlinedButton(context, 'Choose files', controller.pickGallery)],
        _error(context, controller.errorOf('gallery')),
      ],
    );
  }

  Widget buildPrivacy(BuildContext context, Color blueSoft, Color blue, CreateGroupController controller) {
    final form = controller.form!;
    final maxQuestions = form.joiningQuestions.max;
    return _card(
      children: [
        _stepTitle(context, '4. Privacy & Membership', 'Choose who can discover your group, how people join, and what members can do.'),
        _label(context, 'Group Privacy*'),
        SizedBox(height: Dimensions.h_5),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: form.groupPrivacy.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, mainAxisExtent: Dimensions.h_90),
          itemBuilder: (context, index) {
            final option = form.groupPrivacy[index];
            final isSelected = controller.visibility == option.value;
            return GestureDetector(
              onTap: () => controller.selectVisibility(option.value),
              child: Container(
                padding: EdgeInsets.all(Dimensions.h_5),
                decoration: BoxDecoration(
                  color: isSelected ? blueSoft : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.h_8),
                  border: Border.all(color: isSelected ? blue : Theme.of(context).highlightColor, width: isSelected ? 1 : 0.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(groupOptionIcon(option.icon), size: Dimensions.h_16, color: isSelected ? blue : AppColor.muted(context)),
                        SizedBox(width: Dimensions.w_8),
                        Expanded(
                          child: Text(
                            option.label,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, color: Theme.of(context).highlightColor, height: 1.1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.h_5),
                    Expanded(
                      child: Text(
                        option.description ?? '',
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: FontSize.sp_9, height: 1.2, color: Theme.of(context).highlightColor),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Membership approval'),
        _hint(context, 'How people become members is determined by your group privacy.'),
        SizedBox(height: Dimensions.h_5),
        // read-only: follows the privacy choice above
        ...form.membershipApproval.map(
          (o) => Opacity(
            opacity: controller.membership == o.value ? 1 : 0.45,
            child: _radioRow(context, blue, label: o.label, selected: controller.membership == o.value, onTap: () {}),
          ),
        ),
        if (controller.asksQuestions) ...[
          SizedBox(height: Dimensions.h_15),
          Row(
            children: [
              Expanded(child: _label(context, 'Membership questions (Optional)')),
              _aiButton(context, blue, controller, 'generate_joining_questions', 'Suggest', controller.suggestQuestions),
            ],
          ),
          _hint(context, 'Ask up to $maxQuestions questions. Admins can use the answers when reviewing join requests.'),
          for (var i = 0; i < controller.questionControllers.length; i++) ...[
            SizedBox(height: Dimensions.h_8),
            CommonTextField(
              controller: controller.questionControllers[i],
              hint: i < form.joiningQuestions.placeholders.length ? form.joiningQuestions.placeholders[i] : 'Your question',
              errorText: controller.errorOf('question_$i'),
              onChanged: (_) => controller.clearError('question_$i'),
              maxLength: CreateGroupController.maxQuestionLength,
            ),
            Row(
              children: [
                _checkRow(context, blue, label: 'Required', selected: controller.questionRequired[i], onTap: () => controller.toggleQuestionRequired(i)),
                const Spacer(),
                _textButton('Remove', blue, () => controller.removeQuestion(i)),
              ],
            ),
          ],
          if (controller.questionControllers.length < maxQuestions) ...[SizedBox(height: Dimensions.h_8), _outlinedButton(context, 'Add question', controller.addQuestion, icon: CupertinoIcons.add)],
        ],
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Member permissions'),
        _hint(context, 'Choose what members can do. Admins keep access to manage the group.'),
        SizedBox(height: Dimensions.h_5),
        ...form.memberPermissions.map(
          (p) => _checkRow(context, blue, label: p.label, selected: controller.permissions.contains(p.value), onTap: () => controller.toggleIn(controller.permissions, p.value)),
        ),
      ],
    );
  }

  Widget buildDiscussion(BuildContext context, Color blueSoft, Color blue, CreateGroupController controller) {
    final form = controller.form!;
    return _card(
      children: [
        _stepTitle(context, '5. Discussion Settings', 'Give your community a few useful places to start talking.'),
        _label(context, 'Discussion Topics'),
        _wrap([
          for (final t in form.topics)
            _checkChip(
              context,
              blueSoft,
              blue,
              label: t.label,
              icon: groupOptionIcon(t.icon),
              selected: controller.topics.contains(t.value),
              onTap: () => controller.toggleIn(controller.topics, t.value),
            ),
        ]),
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Post Moderation'),
        _hint(context, 'Choose how much review your group’s conversations need.'),
        SizedBox(height: Dimensions.h_5),
        ...form.moderation.map((m) => _radioRow(context, blue, label: m.label, selected: controller.moderation == m.value, onTap: () => controller.selectModeration(m.value))),
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Sharing Options'),
        SizedBox(height: Dimensions.h_5),
        ...form.sharingOptions.map(
          (o) => _optionCard(
            context,
            blueSoft,
            blue,
            option: o,
            selected: controller.permissions.contains(o.permission),
            onTap: () => controller.toggleIn(controller.permissions, o.permission ?? o.value),
          ),
        ),
      ],
    );
  }

  Widget buildRules(BuildContext context, Color blueSoft, Color blue, CreateGroupController controller) {
    final form = controller.form!;
    final limits = form.additionalGuidelines;
    return _card(
      children: [
        _stepTitle(context, '6. Rules & Guidelines', 'Set a friendly, clear standard for your community.'),
        _label(context, 'Starter Rules'),
        SizedBox(height: Dimensions.h_5),
        ...form.rules.map((r) => _optionCard(context, blueSoft, blue, option: r, selected: controller.rules.contains(r.value), onTap: () => controller.toggleIn(controller.rules, r.value))),
        SizedBox(height: Dimensions.h_15),
        _label(context, 'Additional Guidelines (Optional)'),
        _hint(context, 'Add up to ${limits.max} guidelines of your own.'),
        for (var i = 0; i < controller.guidelineControllers.length; i++) ...[
          SizedBox(height: Dimensions.h_8),
          CommonTextField(controller: controller.guidelineControllers[i], hint: i < limits.placeholders.length ? limits.placeholders[i] : '', maxLength: limits.maxLength, minLines: 2, maxLines: 5),
          Align(alignment: Alignment.centerRight, child: _textButton('Remove', blue, () => controller.removeGuideline(i))),
        ],
        if (controller.guidelineControllers.length < limits.max) ...[SizedBox(height: Dimensions.h_8), _outlinedButton(context, 'Add guideline', controller.addGuideline, icon: CupertinoIcons.add)],
      ],
    );
  }

  Widget buildLaunch(BuildContext context, Color blueSoft, Color blue, CreateGroupController controller) {
    final form = controller.form!;
    final textColor = Theme.of(context).highlightColor;
    final questions = controller.asksQuestions ? controller.questionControllers.length : 0;
    final guidelines = controller.guidelineControllers.where((c) => c.text.trim().isNotEmpty).length;

    Widget reviewSection({required String title, required int step, required List<(String, String)> fields}) {
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
                _textButton('Edit', blue, () => controller.goToStep(step)),
              ],
            ),
            SizedBox(height: Dimensions.h_4),
            ...fields.map(
              (field) => Container(
                margin: EdgeInsets.only(left: Dimensions.w_5),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: textColor, width: 0.15)),
                ),
                padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Dimensions.w_90,
                      child: Text(
                        field.$1,
                        style: TextStyle(color: textColor, fontSize: FontSize.sp_11),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_20),
                    Expanded(
                      child: Text(
                        field.$2.isEmpty ? '—' : field.$2,
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

    return _card(
      children: [
        _stepTitle(context, '7. Review & Launch', 'One last look at the community you’re creating.'),
        SizedBox(height: Dimensions.h_5),
        reviewSection(
          title: 'Group Details',
          step: 0,
          fields: [
            ('Group Name', controller.nameController.text.trim()),
            ('Category', controller.categorySummary),
            ('Interests', controller.interestSummary),
            ('Purpose', controller.purposeController.text.trim()),
            ('Who It’s For', controller.audienceSummary),
          ],
        ),
        reviewSection(
          title: 'Location & Coverage',
          step: 1,
          fields: [
            ('Primary Town', '${controller.originTown?.name ?? ''} · ${controller.includedTownIds.length} town${controller.includedTownIds.length == 1 ? '' : 's'}'),
            ('Coverage Radius', controller.radius == 0 ? 'Town only' : '${controller.radius} miles'),
          ],
        ),
        reviewSection(
          title: 'Description & Media',
          step: 2,
          fields: [
            ('Description', controller.descriptionController.text.trim()),
            (
              'Photos',
              [
                controller.coverPath != null ? 'Cover selected' : 'No cover',
                controller.avatarPath != null ? 'Group photo selected' : 'No group photo',
                '${controller.galleryPaths.length} gallery photos',
              ].join(' · '),
            ),
          ],
        ),
        reviewSection(
          title: 'Privacy & Membership',
          step: 3,
          fields: [
            ('Group Visibility', controller.visibilityLabel),
            ('Who Can Join', controller.membershipLabel),
            ('Membership Questions', questions == 0 ? 'No questions added' : '$questions question${questions == 1 ? '' : 's'}'),
            ('Member Permissions', controller.labelsOf(form.memberPermissions, controller.permissions)),
          ],
        ),
        reviewSection(
          title: 'Conversations',
          step: 4,
          fields: [
            ('Topics', controller.labelsOf(form.topics, controller.topics)),
            ('Moderation', controller.moderationLabel),
            ('Sharing', '${controller.allowPhotos ? 'Photos enabled' : 'Photos disabled'} · ${controller.allowComments ? 'Comments enabled' : 'Comments disabled'}'),
          ],
        ),
        reviewSection(
          title: 'Rules & Guidelines',
          step: 5,
          fields: [('Rules', controller.labelsOf(form.rules, controller.rules)), ('Guidelines', guidelines == 0 ? 'None added' : '$guidelines additional')],
        ),
      ],
    );
  }

  Widget _card({required List<Widget> children}) => CommonCard(
    margin: EdgeInsets.only(top: Dimensions.h_10, left: Dimensions.w_10, right: Dimensions.w_10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );

  Widget _stepTitle(BuildContext context, String title, String subtitle) => Padding(
    padding: EdgeInsets.only(bottom: Dimensions.h_10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_18, fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.w_8),
          child: Text(
            subtitle,
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );

  Widget _label(BuildContext context, String text) => Padding(
    padding: EdgeInsets.only(bottom: Dimensions.h_5),
    child: Text(
      text,
      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
    ),
  );

  Widget _hint(BuildContext context, String text) => Padding(
    padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_5),
    child: Text(
      text,
      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, height: 1.3),
    ),
  );

  Widget _wrap(List<Widget> children) => Wrap(spacing: Dimensions.w_6, runSpacing: Dimensions.h_6, children: children);

  Widget _choiceChip(BuildContext context, Color blueSoft, Color blue, {required String label, required bool selected, required VoidCallback onTap}) =>
      _chip(context, blueSoft, blue, label: label, selected: selected, onTap: onTap, icon: selected ? Icons.radio_button_checked : Icons.radio_button_off);

  Widget _checkChip(BuildContext context, Color blueSoft, Color blue, {required String label, required bool selected, required VoidCallback onTap, IconData? icon}) =>
      _chip(context, blueSoft, blue, label: label, selected: selected, onTap: onTap, icon: icon ?? (selected ? Icons.check_box : Icons.check_box_outline_blank));

  Widget _chip(BuildContext context, Color blueSoft, Color blue, {required String label, required bool selected, required VoidCallback onTap, required IconData icon}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
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
            Icon(icon, size: Dimensions.h_13, color: selected ? blue : AppColor.muted(context)),
            SizedBox(width: Dimensions.w_3),
            Text(
              label,
              style: TextStyle(fontSize: FontSize.sp_11, color: selected ? blue : Theme.of(context).highlightColor, fontWeight: selected ? FontWeight.w600 : FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkRow(BuildContext context, Color blue, {required String label, required bool selected, required VoidCallback onTap}) =>
      _row(context, blue, label: label, onTap: onTap, icon: selected ? Icons.check_box : Icons.check_box_outline_blank, selected: selected);

  Widget _radioRow(BuildContext context, Color blue, {required String label, required bool selected, required VoidCallback onTap}) =>
      _row(context, blue, label: label, onTap: onTap, icon: selected ? Icons.radio_button_checked : Icons.radio_button_unchecked, selected: selected);

  Widget _row(BuildContext context, Color blue, {required String label, required VoidCallback onTap, required IconData icon, required bool selected}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_4, vertical: Dimensions.h_6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: Dimensions.h_16, color: selected ? blue : AppColor.muted(context)),
            SizedBox(width: Dimensions.w_6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(fontSize: FontSize.sp_11, height: 1.3, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionCard(BuildContext context, Color blueSoft, Color blue, {required GroupFormOption option, required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: Dimensions.w_5, bottom: Dimensions.h_8),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_5),
        decoration: BoxDecoration(
          color: selected ? blueSoft : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.h_4),
          border: Border.all(color: selected ? blue : Theme.of(context).highlightColor, width: selected ? 0.5 : 0.2),
        ),
        child: Row(
          children: [
            Icon(selected ? Icons.check_box : Icons.check_box_outline_blank, size: Dimensions.h_16, color: selected ? blue : AppColor.muted(context)),
            SizedBox(width: Dimensions.w_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.label,
                    style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, color: Theme.of(context).highlightColor),
                  ),
                  if (option.description != null)
                    Text(
                      option.description!,
                      style: TextStyle(fontSize: FontSize.sp_9, color: Theme.of(context).highlightColor),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _aiButton(BuildContext context, Color blue, CreateGroupController controller, String action, String label, VoidCallback onTap) {
    final busy = controller.aiAction == action;
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(CupertinoIcons.sparkles, size: Dimensions.h_13, color: blue),
        SizedBox(width: Dimensions.w_4),
        Text(
          busy ? 'Suggesting…' : label,
          style: TextStyle(color: blue, fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
        ),
      ],
    );
    return GestureDetector(
      onTap: controller.aiAction == null ? onTap : null,
      // a light sweep across the label reads as "AI is writing"
      child: busy ? Shimmer.fromColors(baseColor: blue, highlightColor: AppColor.blueSoft(context), period: const Duration(milliseconds: 1100), child: content) : content,
    );
  }

  Widget _outlinedButton(BuildContext context, String label, VoidCallback onTap, {IconData? icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.h_4),
          border: Border.all(color: Theme.of(context).highlightColor, width: 0.2),
        ),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: Dimensions.h_12, color: Theme.of(context).highlightColor), SizedBox(width: Dimensions.w_5)],
            Text(
              label,
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textButton(String label, Color blue, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Text(
      label,
      style: TextStyle(color: blue, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
    ),
  );

  /// Red message under a chip group, matching CommonTextField's error text.
  Widget _error(BuildContext context, String? message) => message == null
      ? const SizedBox.shrink()
      : Padding(
          padding: EdgeInsets.only(left: Dimensions.w_5, top: Dimensions.h_5),
          child: Text(
            message,
            style: TextStyle(fontSize: FontSize.sp_10, color: AppColor.red(context), fontWeight: FontWeight.w500),
          ),
        );

  Widget buildHeroHeader(BuildContext context, bool isLight, String firstName) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(alignment: Alignment(0.8, 0), size: Dimensions.h_250, widthSize: Get.width, imageUrl: "https://preetis-html.vercel.app/assets/images/groups/create-group/hero.webp"),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.35), Colors.transparent],
                stops: const [0.0, 0.40, 0.68, 1.0],
              ),
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
                  (firstName.isEmpty ? 'A place for your people' : 'A place for your people, $firstName').toUpperCase(),
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
                colors: [
                  context.sports.background.withValues(alpha: 0.0),
                  context.sports.background.withValues(alpha: 0.15),
                  context.sports.background.withValues(alpha: 0.35),
                  context.sports.background.withValues(alpha: 0.78),
                  context.sports.background,
                ],
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
  final GroupTown? origin;
  final int radiusMiles;
  final List<GroupTown> towns;
  final Set<int> includedTownIds;

  const CoverageMapWidget({super.key, required this.origin, required this.radiusMiles, required this.towns, required this.includedTownIds});

  @override
  State<CoverageMapWidget> createState() => _CoverageMapWidgetState();
}

class _CoverageMapWidgetState extends State<CoverageMapWidget> {
  static const _metersPerMile = 1609.34;
  static const _minZoom = 3.0;
  static const _maxZoom = 18.0;

  final mapController = MapController();
  bool isTerrainView = false;
  bool _mapReady = false;

  LatLng? get center => widget.origin?.latitude == null || widget.origin?.longitude == null ? null : LatLng(widget.origin!.latitude!, widget.origin!.longitude!);

  /// Camera that frames the whole coverage circle (or the town alone at radius 0).
  CameraFit _fit(LatLng c) {
    final miles = max(widget.radiusMiles, 1);
    final dLat = miles / 69.0;
    final dLng = miles / (69.0 * cos(c.latitude * pi / 180));
    return CameraFit.bounds(bounds: LatLngBounds(LatLng(c.latitude - dLat, c.longitude - dLng), LatLng(c.latitude + dLat, c.longitude + dLng)), padding: EdgeInsets.all(Dimensions.w_20), maxZoom: 14);
  }

  @override
  void didUpdateWidget(covariant CoverageMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final c = center;
    if (_mapReady && c != null && (oldWidget.radiusMiles != widget.radiusMiles || oldWidget.origin?.id != widget.origin?.id)) {
      mapController.fitCamera(_fit(c));
    }
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void zoomBy(double delta) {
    final camera = mapController.camera;
    mapController.move(camera.center, (camera.zoom + delta).clamp(_minZoom, _maxZoom));
  }

  void resetMap() {
    final c = center;
    if (c != null) mapController.fitCamera(_fit(c));
    setState(() => isTerrainView = false);
  }

  @override
  Widget build(BuildContext context) {
    final blue = AppColor.blue(context);
    final c = center;
    return Container(
      height: Dimensions.h_250,
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.h_5)),
      clipBehavior: Clip.antiAlias,
      child: c == null
          ? Center(
              child: Text(
                'Choose a town to preview coverage',
                style: TextStyle(fontSize: FontSize.sp_10, color: Theme.of(context).hintColor),
              ),
            )
          : Stack(
              children: [
                // must fill the stack: a plain Stack child gets loose constraints and the map lays out at zero size
                Positioned.fill(
                  child: FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCameraFit: _fit(c),
                      minZoom: _minZoom,
                      backgroundColor: AppColor.mapBlueSoft(context),
                      maxZoom: _maxZoom,
                      onMapReady: () => _mapReady = true,
                      // no one-finger drag: it would fight the page scroll
                      interactionOptions: const InteractionOptions(flags: InteractiveFlag.pinchZoom | InteractiveFlag.pinchMove | InteractiveFlag.doubleTapZoom),
                    ),
                    children: [
                      isTerrainView
                          ? TileLayer(urlTemplate: 'https://tile.opentopomap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.wikixm.app', maxNativeZoom: 17)
                          : TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.wikixm.app'),
                      if (widget.radiusMiles > 0)
                        CircleLayer(
                          circles: [
                            CircleMarker(point: c, radius: widget.radiusMiles * _metersPerMile, useRadiusInMeter: true, color: blue.withValues(alpha: 0.12), borderColor: blue, borderStrokeWidth: 2),
                          ],
                        ),
                      MarkerLayer(
                        markers: [
                          for (final t in widget.towns)
                            if (t.latitude != null && t.longitude != null && t.id != widget.origin?.id)
                              Marker(
                                point: LatLng(t.latitude!, t.longitude!),
                                width: Dimensions.h_10,
                                height: Dimensions.h_10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.includedTownIds.contains(t.id) ? blue : AppColor.muted(context),
                                    border: Border.all(color: AppColor.white, width: 1.5),
                                  ),
                                ),
                              ),
                          Marker(
                            point: c,
                            width: Dimensions.h_25,
                            height: Dimensions.h_25,
                            alignment: Alignment.topCenter,
                            child: Icon(Icons.location_on, color: blue, size: Dimensions.h_25),
                          ),
                        ],
                      ),
                    ],
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
                        _viewButton(label: 'Map view', selected: !isTerrainView, onTap: () => setState(() => isTerrainView = false)),
                        _viewButton(label: 'Terrain view', selected: isTerrainView, onTap: () => setState(() => isTerrainView = true)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Column(
                    children: [
                      _mapControl(icon: Icons.add, tooltip: 'Zoom in', onTap: () => zoomBy(1)),
                      const SizedBox(height: 6),
                      _mapControl(icon: Icons.remove, tooltip: 'Zoom out', onTap: () => zoomBy(-1)),
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
                      widget.radiusMiles == 0 ? 'Town only' : '${widget.radiusMiles} mile radius',
                      style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w600, color: blue),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _viewButton({required String label, required bool selected, required VoidCallback onTap}) {
    final blue = AppColor.blue(context);
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
            style: TextStyle(color: selected ? AppColor.white : Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _mapControl({required IconData icon, required String tooltip, required VoidCallback onTap}) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Tooltip(
          message: tooltip,
          child: SizedBox(width: 38, height: 38, child: Icon(icon, size: 20, color: Theme.of(context).iconTheme.color)),
        ),
      ),
    );
  }
}

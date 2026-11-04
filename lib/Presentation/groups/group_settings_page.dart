import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/groups/group_settings.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_button.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/entrance_animation.dart';

class GroupSettingsPage extends StatelessWidget with SettingsWidgets {
  const GroupSettingsPage({super.key});

  GroupController get controller => Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    final String page = Get.arguments ?? 'notifications';
    return GetBuilder<GroupController>(
      init: controller,
      id: ControllerBuilders.groupSettings,
      builder: (c) => CommonBlurScaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        collapsedColor: AppColor.ink(context),
        showBack: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: staggered([
              SizedBox(height: MediaQuery.of(context).padding.top + Dimensions.h_30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      c.settingsPages[page]!['title'],
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_26, fontWeight: FontWeight.w800, letterSpacing: -1),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_6),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_5),
                    decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_20)),
                    child: Text(
                      'For all groups',
                      style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_10, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_6),
              Text(
                c.settingsPages[page]!['subtitle'],
                style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_12, height: 1.4),
              ),
              SizedBox(height: Dimensions.h_15),
              ...switch (page) {
                'interests' => buildInterests(context, c),
                'content' => buildContent(context, c),
                'privacy' => buildPrivacy(context, c),
                'blocked' => buildBlocked(context, c),
                'recommendations' => buildRecommendations(context, c),
                _ => buildNotifications(context, c),
              },
              // Block/unblock apply immediately, so this page has nothing to save or restore.
              if (page != 'blocked') ...[
                SizedBox(height: Dimensions.h_25),
                CommonButton(title: 'Save', onTap: c.saveSettingsPage, width: double.infinity, height: Dimensions.h_35, radius: Dimensions.h_20),
                SizedBox(height: Dimensions.h_6),
                restoreButton(context, () => c.restoreSettingsPage(page)),
              ],
              SizedBox(height: MediaQuery.of(context).padding.bottom + Dimensions.h_10),
            ]),
          ),
        ),
      ),
    );
  }

  Widget heading(BuildContext context, String title, String subtitle) => Padding(
    padding: EdgeInsets.only(bottom: Dimensions.h_10),
    child: titleBlock(context, title, subtitle),
  );

  Widget segmented(BuildContext context, List<String> options, String value, ValueChanged<String> onChanged) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl<String>(
        groupValue: value,
        backgroundColor: AppColor.blueSoft(context),
        thumbColor: AppColor.surface(context),
        padding: EdgeInsets.all(Dimensions.h_4),
        onValueChanged: (v) => v == null ? null : onChanged(v),
        children: {
          for (final o in options)
            o: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
              child: Text(
                o,
                style: TextStyle(color: o == value ? Theme.of(context).highlightColor : AppColor.muted(context), fontSize: FontSize.sp_11, fontWeight: o == value ? FontWeight.w700 : FontWeight.w500),
              ),
            ),
        },
      ),
    );
  }

  List<Widget> buildInterests(BuildContext context, GroupController c) {
    final chosen = c.settingsList('interests');
    final skill = c.settingsPrefs['skill'] as int;
    return [
      Row(
        children: [
          Expanded(child: sectionTitle(context, 'What you want to hear about')),
          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.h_10),
            child: Text(
              '${chosen.length} chosen',
              style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_11),
            ),
          ),
        ],
      ),
      Wrap(
        spacing: Dimensions.w_6,
        runSpacing: Dimensions.h_6,
        children: [
          for (final interest in c.interestOptions)
            GestureDetector(
              onTap: () => c.toggleSettingsItem('interests', interest),
              child: Container(
                padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_8, Dimensions.w_12, Dimensions.h_8),
                decoration: BoxDecoration(
                  color: chosen.contains(interest) ? AppColor.blue(context) : AppColor.surface(context),
                  borderRadius: BorderRadius.circular(Dimensions.h_25),
                  border: Border.all(color: chosen.contains(interest) ? AppColor.blue(context) : AppColor.border(context)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: Dimensions.h_8,
                      backgroundColor: chosen.contains(interest) ? AppColor.warningAmber : AppColor.blueSoft(context),
                      child: chosen.contains(interest) ? Icon(Icons.check_rounded, color: AppColor.primaryNavy, size: Dimensions.h_10) : null,
                    ),
                    SizedBox(width: Dimensions.w_6),
                    Text(
                      interest,
                      style: TextStyle(color: chosen.contains(interest) ? AppColor.white : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      SizedBox(height: Dimensions.h_25),
      heading(context, 'Your skill level', 'We use it to match you with the right outings.'),
      for (final (i, level) in c.skillLevels.indexed) ...[
        if (i > 0) SizedBox(height: Dimensions.h_8),
        GestureDetector(
          onTap: () => c.setSettingsPref('skill', i),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_12),
            decoration: BoxDecoration(
              color: i == skill ? AppColor.blueSoft(context) : AppColor.surface(context),
              borderRadius: BorderRadius.circular(Dimensions.h_15),
              border: Border.all(color: i == skill ? AppColor.blue(context) : AppColor.border(context), width: i == skill ? 1.5 : 1),
            ),
            child: Row(
              children: [
                // Signal bars: one bar per real level; 'All levels' (index 0) fills every bar.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var b = 0; b < c.skillLevels.length - 1; b++) ...[
                      if (b > 0) SizedBox(width: Dimensions.w_2),
                      Container(
                        width: Dimensions.w_3,
                        height: Dimensions.h_6 + b * Dimensions.h_4,
                        decoration: BoxDecoration(color: i == 0 || b < i ? AppColor.blue(context) : AppColor.blue(context).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(Dimensions.h_1)),
                      ),
                    ],
                  ],
                ),
                SizedBox(width: Dimensions.w_12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        level,
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: Dimensions.h_2),
                      Text(
                        c.skillDescriptions[i],
                        style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_11, height: 1.35),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.w_10),
                Container(
                  width: Dimensions.h_15,
                  height: Dimensions.h_15,
                  padding: EdgeInsets.all(Dimensions.h_2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: i == skill ? AppColor.blue(context) : AppColor.border(context), width: 1.5),
                  ),
                  child: i == skill
                      ? DecoratedBox(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.blue(context)),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ],
    ];
  }

  List<Widget> buildContent(BuildContext context, GroupController c) {
    final feed = c.settingsList('feed');
    return [
      sectionTitle(context, 'Show in my feed'),
      card(context, [
        for (final option in c.feedOptions)
          InkWell(
            onTap: () => c.toggleSettingsItem('feed', option),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h_1),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Checkbox(
                    value: feed.contains(option),
                    activeColor: AppColor.blue(context),
                    side: BorderSide(color: AppColor.border(context), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.h_5)),
                    onChanged: (_) => c.toggleSettingsItem('feed', option),
                  ),
                ],
              ),
            ),
          ),
      ]),
      SizedBox(height: Dimensions.h_20),
      sectionTitle(context, 'Order new posts by'),
      segmented(context, c.orderOptions, c.settingsPrefs['order'], (v) => c.setSettingsPref('order', v)),
      SizedBox(height: Dimensions.h_15),
      card(context, [switchRow(context, 'Hide sensitive content', 'Blur posts members flag as mature', c.settingsPrefs['hideSensitive'], (v) => c.setSettingsPref('hideSensitive', v))]),
    ];
  }

  List<Widget> buildNotifications(BuildContext context, GroupController c) {
    final on = c.settingsList('notify');
    return [
      for (final MapEntry(key: section, value: items) in c.notifySections.entries) ...[
        SizedBox(height: Dimensions.h_10),
        sectionTitle(context, section),
        card(context, [for (final item in items) switchRow(context, item['title']!, item['subtitle']!, on.contains(item['title']), (_) => c.toggleSettingsItem('notify', item['title']!))]),
      ],
      SizedBox(height: Dimensions.h_12),
      Text(
        'Each group can have its own mix. Open a group from Group settings to change it.',
        style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_11, height: 1.4),
      ),
    ];
  }

  List<Widget> buildPrivacy(BuildContext context, GroupController c) {
    return [
      for (final q in c.privacyQuestions) ...[
        heading(context, q['title']!, q['subtitle']!),
        segmented(context, c.privacyOptions, c.settingsPrefs[q['key']], (v) => c.setSettingsPref(q['key']!, v)),
        SizedBox(height: Dimensions.h_20),
      ],
      card(context, [switchRow(context, 'Show me in member lists', 'Appear in each group\'s directory', c.settingsPrefs['memberLists'], (v) => c.setSettingsPref('memberLists', v))]),
      SizedBox(height: Dimensions.h_12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(CupertinoIcons.lock, color: AppColor.muted(context), size: Dimensions.h_13),
          SizedBox(width: Dimensions.w_8),
          Expanded(
            child: Text(
              'Private groups keep their own rules. Nothing here makes private group content public.',
              style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_11, height: 1.4),
            ),
          ),
        ],
      ),
    ];
  }

  List<Widget> buildBlocked(BuildContext context, GroupController c) {
    final blocked = c.settingsList('blocked');
    return [
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: c.blockNameController,
              onSubmitted: (_) => c.blockMember(),
              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13),
              decoration: InputDecoration(
                hintText: "Member's display name",
                hintStyle: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_13),
                filled: true,
                fillColor: AppColor.surface(context),
                contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.h_15),
                  borderSide: BorderSide(color: AppColor.border(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.h_15),
                  borderSide: BorderSide(color: AppColor.blue(context)),
                ),
              ),
            ),
          ),
          SizedBox(width: Dimensions.w_8),
          CommonButton(
            title: 'Search',
            onTap: c.blockMember,
            color: AppColor.primaryNavy,
            radius: Dimensions.h_10,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_20, vertical: Dimensions.h_10),
          ),
        ],
      ),
      SizedBox(height: Dimensions.h_20),
      sectionTitle(context, '${blocked.length} ${blocked.length == 1 ? 'person' : 'people'} blocked'),
      if (blocked.isNotEmpty)
        card(context, [
          for (final name in blocked)
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h_10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: Dimensions.h_18,
                    backgroundColor: AppColor.blueSoft(context),
                    child: Text(
                      name.split(' ').where((w) => w.isNotEmpty).take(2).map((w) => w[0].toUpperCase()).join(),
                      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(width: Dimensions.w_10),
                  Expanded(child: titleBlock(context, name, 'Blocked ${c.blockedDates[name] ?? ''}')),
                  CommonButton(
                    title: 'Unblock',
                    onTap: () => c.unblockMember(name),
                    color: Colors.transparent,
                    textColor: Theme.of(context).highlightColor,
                    borderColor: AppColor.border(context),
                    radius: Dimensions.h_12,
                    fontSize: FontSize.sp_11,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_6),
                  ),
                ],
              ),
            ),
        ]),
    ];
  }

  List<Widget> buildRecommendations(BuildContext context, GroupController c) {
    final on = c.settingsList('suggest');
    return [
      sectionTitle(context, 'Suggest to me'),
      card(context, [for (final item in c.suggestOptions) switchRow(context, item['title']!, item['subtitle']!, on.contains(item['title']), (_) => c.toggleSettingsItem('suggest', item['title']!))]),
      SizedBox(height: Dimensions.h_20),
      sectionTitle(context, 'What we learn from'),
      card(context, [
        switchRow(context, 'Use my activity history', 'Outings you joined and groups you visit', c.settingsPrefs['learnHistory'], (v) => c.setSettingsPref('learnHistory', v)),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h_12),
          child: Text(
            'Suggestions use your interests plus what you actually do. Messages are never used.',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, height: 1.4),
          ),
        ),
      ]),
      SizedBox(height: Dimensions.h_12),
      Text(
        'Your groups work the same with every suggestion turned off.',
        style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_11, height: 1.4),
      ),
    ];
  }
}

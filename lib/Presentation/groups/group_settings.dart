import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../widgets/entrance_animation.dart';

class GroupSettings extends StatelessWidget with SettingsWidgets {
  const GroupSettings({super.key});

  GroupController get controller => Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Group settings',
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_26, fontWeight: FontWeight.w800, letterSpacing: -1),
              ),
              SizedBox(height: Dimensions.h_6),
              Text(
                'Set defaults for every group, or tune one group on its own.',
                style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_12, height: 1.4),
              ),
              // SizedBox(height: Dimensions.h_15),
              // buildGroupPicker(context, c),
              // SizedBox(height: Dimensions.h_15),
              // buildBanner(context, c),
              SizedBox(height: Dimensions.h_20),
              sectionTitle(context, 'What reaches you'),
              buildReach(context, c),
              SizedBox(height: Dimensions.h_15),
              sectionTitle(context, 'All settings'),
              buildAllSettings(context, c),
              SizedBox(height: Dimensions.h_5),
              restoreButton(context, c.restoreDefaultSettings),
              SizedBox(height: MediaQuery.of(context).padding.bottom + Dimensions.h_10),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildGroupPicker(BuildContext context, GroupController c) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (i, g) in c.settingsGroups.indexed)
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => c.selectSettingsGroup(i),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: Dimensions.h_45,
                        height: Dimensions.h_45,
                        padding: EdgeInsets.all(Dimensions.h_2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: i == c.settingsGroupIndex ? AppColor.blue(context) : AppColor.transparent, width: 2),
                        ),
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: i == c.settingsGroupIndex && i == 0 ? AppColor.blue(context) : Color(g['color']).withValues(alpha: 0.12)),
                          child: Icon(g['icon'], color: i == c.settingsGroupIndex && i == 0 ? AppColor.white : Color(g['color']), size: Dimensions.h_18),
                        ),
                      ),
                      if (g['admin'] == true)
                        Positioned(
                          bottom: -Dimensions.h_4,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_5, vertical: Dimensions.h_1),
                            decoration: BoxDecoration(color: AppColor.ink(context), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                            child: Text(
                              'Admin',
                              style: TextStyle(color: AppColor.surface(context), fontSize: FontSize.sp_8, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_6),
                  Text(
                    g['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: i == c.settingsGroupIndex ? FontWeight.w700 : FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget buildBanner(BuildContext context, GroupController c) {
    final all = c.settingsGroupIndex == 0;
    return Container(
      padding: EdgeInsets.all(Dimensions.h_12),
      decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Dimensions.h_25,
            height: Dimensions.h_25,
            decoration: BoxDecoration(color: AppColor.surface(context), shape: BoxShape.circle),
            child: Icon(CupertinoIcons.checkmark_shield, color: AppColor.blue(context), size: Dimensions.h_13),
          ),
          SizedBox(width: Dimensions.w_10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  all ? 'These are your defaults' : 'Settings for ${c.settingsGroups[c.settingsGroupIndex]['name']}',
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: Dimensions.h_2),
                Text(
                  all ? 'New groups start with these. Any group can have its own settings instead.' : 'Changes here apply to this group only.',
                  style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_10, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReach(BuildContext context, GroupController c) {
    return card(context, [
      for (final item in c.settingsReach) switchRow(context, item['title']!, item['subtitle']!, c.currentReach[item['title']] ?? false, (_) => c.toggleSettingsReach(item['title']!)),
    ]);
  }

  Widget buildAllSettings(BuildContext context, GroupController c) {
    return card(context, [
      for (final row in c.settingsRows)
        InkWell(
          onTap: row['page'] == null ? null : () => c.openSettingsPage(row['page']),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
            child: Row(
              children: [
                Container(
                  width: Dimensions.h_25,
                  height: Dimensions.h_25,
                  decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                  child: Icon(row['icon'], color: AppColor.ink(context), size: Dimensions.h_13),
                ),
                SizedBox(width: Dimensions.w_10),
                Expanded(
                  child: Text(
                    row['title'],
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  c.settingsRowValue(row),
                  style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_10),
                ),
                SizedBox(width: Dimensions.w_5),
                Icon(CupertinoIcons.chevron_right, color: AppColor.muted(context), size: Dimensions.h_11),
              ],
            ),
          ),
        ),
    ]);
  }
}

mixin SettingsWidgets {
  Widget sectionTitle(BuildContext context, String title) => Padding(
    padding: EdgeInsets.only(bottom: Dimensions.h_10),
    child: Text(
      title,
      style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800, letterSpacing: -0.5),
    ),
  );

  Widget card(BuildContext context, List<Widget> rows) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10),
      decoration: BoxDecoration(color: AppColor.surface(context), borderRadius: BorderRadius.circular(Dimensions.h_15)),
      child: Column(
        children: [
          for (final (i, row) in rows.indexed) ...[if (i > 0) Divider(height: 1, color: AppColor.border(context)), row],
        ],
      ),
    );
  }

  Widget switchRow(BuildContext context, String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h_7),
      child: Row(
        children: [
          Expanded(child: titleBlock(context, title, subtitle)),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(value: value, activeTrackColor: AppColor.blue(context), onChanged: onChanged),
          ),
        ],
      ),
    );
  }

  Widget titleBlock(BuildContext context, String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
        ),
        Text(
          subtitle,
          style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_10),
        ),
      ],
    );
  }

  Widget restoreButton(BuildContext context, VoidCallback onPressed) {
    return Center(
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.restart_alt_rounded, color: AppColor.blue(context), size: Dimensions.h_15),
        label: Text(
          'Restore default preferences',
          style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

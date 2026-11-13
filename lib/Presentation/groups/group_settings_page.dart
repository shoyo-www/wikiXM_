import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/groups/group_settings.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_button.dart';
import 'package:wikixm/Presentation/widgets/common_dropdown.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_settings_response.dart' show SectionField;
import '../../constants/fontsize.dart';
import '../widgets/entrance_animation.dart';

class GroupSettingsPage extends StatelessWidget with SettingsWidgets {
  const GroupSettingsPage({super.key});

  GroupController get controller => Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    final String? page = Get.arguments;
    return GetBuilder<GroupController>(
      init: controller,
      id: ControllerBuilders.groupSettings,
      builder: (c) {
        final section = c.settingsSection(page);
        final footnote = section?.footnote;
        return CommonBlurScaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          collapsedColor: AppColor.ink(context),
          showBack: true,
          bottomNavigationBar: section?.kind != 'preferences'
              ? null
              : SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(Dimensions.w_12, Dimensions.h_8, Dimensions.w_12, Dimensions.h_5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonButton(title: c.savingSettingsPage ? 'Saving...' : 'Save', onTap: () => c.saveSettingsPage(page), width: double.infinity, height: Dimensions.h_35, radius: Dimensions.h_20),
                        SizedBox(height: Dimensions.h_6),
                        restoreButton(context, () => c.restoreSettingsPage(page)),
                      ],
                    ),
                  ),
                ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: staggered([
                SizedBox(height: MediaQuery.of(context).padding.top + Dimensions.h_30),
                Text(
                  section?.title ?? section?.label ?? '',
                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_26, fontWeight: FontWeight.w800, letterSpacing: -1),
                ),
                SizedBox(height: Dimensions.h_6),
                Text(
                  section?.help ?? section?.description ?? '',
                  style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_12, height: 1.4),
                ),
                SizedBox(height: Dimensions.h_15),
                ...buildFields(context, c, section?.fields ?? [], section?.layout),
                if (section?.summary?.format == 'text') note(context, Icons.block_rounded, section!.summary!.text ?? ''),
                if (footnote?.text != null) note(context, c.settingsIcon(footnote!.icon), footnote.text!),
                SizedBox(height: Dimensions.h_10),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget heading(BuildContext context, String title, String subtitle) => Padding(
    padding: EdgeInsets.only(bottom: Dimensions.h_10),
    child: titleBlock(context, title, subtitle),
  );

  Widget note(BuildContext context, IconData icon, String text) => Padding(
    padding: EdgeInsets.only(bottom: Dimensions.h_12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColor.muted(context), size: Dimensions.h_13),
        SizedBox(width: Dimensions.w_8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_11, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // switches share one card; selects in a 'columns' layout are dropdown rows, elsewhere option cards
  List<Widget> buildFields(BuildContext context, GroupController c, List<SectionField> fields, String? layout) {
    final switches = fields.where((f) => f.type == 'switch');
    return [
      if (switches.isNotEmpty) ...[
        card(context, [for (final f in switches) switchRow(context, f.label ?? '', f.help ?? '', c.settingsValue(f) == true, (v) => c.setSettingsValue(f.name, v))]),
        SizedBox(height: Dimensions.h_20),
      ],
      for (final f in fields)
        ...switch (f.type) {
          'choices' => buildChoices(context, c, f),
          'select' => layout == 'columns' ? buildDropdown(context, c, f) : buildLevelCards(context, c, f),
          'group' => buildFields(context, c, c.groupFields(f), f.layout),
          _ => const <Widget>[],
        },
    ];
  }

  List<Widget> buildChoices(BuildContext context, GroupController c, SectionField f) {
    final chosen = List<String>.from(c.settingsValue(f) ?? const []);
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: heading(context, f.label ?? '', f.help ?? '')),
          Text(
            '${chosen.length} chosen',
            style: TextStyle(color: AppColor.muted(context), fontSize: FontSize.sp_11),
          ),
        ],
      ),
      Wrap(
        spacing: Dimensions.w_6,
        runSpacing: Dimensions.h_6,
        children: [
          for (final option in c.visibleChoices(f))
            GestureDetector(
              onTap: () => c.toggleSettingsChoice(f, option.value),
              child: Container(
                padding: EdgeInsets.fromLTRB(Dimensions.w_8, Dimensions.h_8, Dimensions.w_12, Dimensions.h_8),
                decoration: BoxDecoration(
                  color: chosen.contains(option.value) ? AppColor.blue(context) : AppColor.surface(context),
                  borderRadius: BorderRadius.circular(Dimensions.h_25),
                  border: Border.all(color: chosen.contains(option.value) ? AppColor.blue(context) : AppColor.border(context)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: Dimensions.h_8,
                      backgroundColor: chosen.contains(option.value) ? AppColor.warningAmber : AppColor.blueSoft(context),
                      child: chosen.contains(option.value) ? Icon(Icons.check_rounded, color: AppColor.primaryNavy, size: Dimensions.h_10) : null,
                    ),
                    SizedBox(width: Dimensions.w_6),
                    Text(
                      option.label ?? '',
                      style: TextStyle(color: chosen.contains(option.value) ? AppColor.white : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      if ((f.options?.length ?? 0) > GroupController.choicesPreview)
        Center(
          child: TextButton(
            onPressed: () => c.toggleChoicesExpanded(f.name),
            child: Text(
              c.expandedChoices.contains(f.name) ? 'Show less' : 'Show all (${f.options!.length})',
              style: TextStyle(color: AppColor.blue(context), fontSize: FontSize.sp_12, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      SizedBox(height: Dimensions.h_25),
    ];
  }

  List<Widget> buildDropdown(BuildContext context, GroupController c, SectionField f) {
    return [
      titleBlock(context, f.label ?? '', f.help ?? ''),
      SizedBox(height: Dimensions.h_8),
      Padding(
        padding: EdgeInsets.only(left: Dimensions.w_5, right: Dimensions.w_10),
        child: CommonDropdown<String>(
          items: [for (final o in f.options ?? []) ?o.value],
          value: c.settingsValue(f),
          itemLabel: (v) => c.optionLabel(f, v),
          onChanged: (v) => c.setSettingsValue(f.name, v),
        ),
      ),
      SizedBox(height: Dimensions.h_20),
    ];
  }

  // single-choice options as one row of cards (skill level); bars rise with each option, the first one fills them all
  List<Widget> buildLevelCards(BuildContext context, GroupController c, SectionField f) {
    final value = c.settingsValue(f);
    final options = f.options ?? [];
    return [
      heading(context, f.label ?? '', f.help ?? ''),
      Row(
        children: [
          for (final (i, option) in options.indexed) ...[
            if (i > 0) SizedBox(width: Dimensions.w_4),
            Expanded(
              child: GestureDetector(
                onTap: () => c.setSettingsValue(f.name, option.value),
                child: Container(
                  padding: EdgeInsets.fromLTRB(Dimensions.w_2, Dimensions.h_8, Dimensions.w_2, Dimensions.h_8),
                  decoration: BoxDecoration(
                    color: option.value == value ? AppColor.blueSoft(context) : AppColor.surface(context),
                    borderRadius: BorderRadius.circular(Dimensions.h_6),
                    border: Border.all(color: option.value == value ? AppColor.blue(context) : AppColor.border(context), width: option.value == value ? 1.5 : 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (var b = 0; b < options.length - 1; b++) ...[
                            if (b > 0) SizedBox(width: Dimensions.w_2),
                            Container(
                              width: Dimensions.w_3,
                              height: Dimensions.h_6 + b * Dimensions.h_4,
                              decoration: BoxDecoration(
                                color: i != 0 && b >= i ? AppColor.border(context) : (option.value == value ? AppColor.blue(context) : AppColor.muted(context)),
                                borderRadius: BorderRadius.circular(Dimensions.h_1),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: Dimensions.h_8),
                      Text(
                        option.label ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: option.value == value ? FontWeight.w700 : FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      SizedBox(height: Dimensions.h_20),
    ];
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/alerts/alerts_controller.dart';
import 'package:wikixm/Presentation/alerts/alerts_home.dart';
import 'package:wikixm/Presentation/widgets/common_blur_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_text_field.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';

class ReportIssue extends StatelessWidget with AlertsUi {
  const ReportIssue({super.key});

  AlertsController get controller => Get.find<AlertsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlertsController>(
      init: controller,
      id: ControllerBuilders.reportIssue,
      builder: (c) => CommonBlurScaffold(
        showBack: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: bottomBar(context, c),
        child: Padding(
          padding: EdgeInsets.fromLTRB(Dimensions.w_15, 0, Dimensions.w_15, Dimensions.h_30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.h_80),
              Text('Report an issue', style: titleStyle(context, FontSize.sp_26, weight: FontWeight.w800)),
              SizedBox(height: Dimensions.h_6),
              Text('Tell neighbors what’s happening. It takes about a minute.', style: mutedStyle(context, size: FontSize.sp_13)),
              SizedBox(height: Dimensions.h_15),
              modeToggle(context, c),
              // emergencyBanner(context),
              if (c.reportMode == 1) ...updateSections(context, c) else ...newIssueSections(context, c),
              SizedBox(height: Dimensions.h_20),
              photos(context, c),
            ],
          ),
        ),
      ),
    );
  }

  Widget modeToggle(BuildContext context, AlertsController c) {
    Widget option(String title, int i) => Expanded(
      child: GestureDetector(
        onTap: () => c.setReportMode(i),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
          decoration: BoxDecoration(color: c.reportMode == i ? AppColor.surface(context) : AppColor.transparent, borderRadius: BorderRadius.circular(Dimensions.h_8)),
          child: Text(title, style: c.reportMode == i ? titleStyle(context, FontSize.sp_12) : linkStyle(context).copyWith(color: AppColor.muted(context), fontSize: FontSize.sp_12)),
        ),
      ),
    );
    return Container(
      padding: EdgeInsets.all(Dimensions.h_4),
      decoration: BoxDecoration(color: AppColor.border(context).withValues(alpha: 0.5), borderRadius: BorderRadius.circular(Dimensions.h_10)),
      child: Row(children: [option('New issue', 0), option('Update an incident', 1)]),
    );
  }

  Widget emergencyBanner(BuildContext context) {
    final red = AppColor.red(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_10),
      decoration: BoxDecoration(color: AppColor.redSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_10)),
      child: Row(
        children: [
          Icon(CupertinoIcons.phone, size: Dimensions.h_15, color: red),
          SizedBox(width: Dimensions.w_10),
          Text('In an emergency, call 911 first.', style: TextStyle(color: red, fontSize: FontSize.sp_12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget label(BuildContext context, String title) => Padding(
    padding: EdgeInsets.only(top: Dimensions.h_20, bottom: Dimensions.h_10),
    child: Text(title, style: titleStyle(context, FontSize.sp_15)),
  );

  List<Widget> newIssueSections(BuildContext context, AlertsController c) => [
    label(context, 'What\'s it about?'),
    GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: Dimensions.h_8,
      crossAxisSpacing: Dimensions.w_8,
      childAspectRatio: 0.9,
      children: [for (var i = 0; i < AlertsController.reportCategories.length; i++) categoryTile(context, c, i)],
    ),
    ...describeSection(context, c, 'What did you see?', AlertsController.reportSuggestions, 'For example: a large tree is down across SE 45th St and both lanes are blocked.', 'Say what you saw yourself, and what you heard from others.'),
    label(context, 'Where and when?'),
    Container(
      decoration: cardDecoration(context),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(Dimensions.w_12, Dimensions.h_8, Dimensions.w_8, Dimensions.h_8),
            child: Row(
              children: [
                Icon(CupertinoIcons.location, size: Dimensions.h_16, color: AppColor.blue(context)),
                Expanded(
                  child: TextField(
                    controller: c.reportPlace,
                    style: titleStyle(context, FontSize.sp_12, weight: FontWeight.w500),
                    decoration: InputDecoration(border: InputBorder.none, isDense: true, hintText: 'Street or landmark', hintStyle: mutedStyle(context, size: FontSize.sp_12), contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.w_10)),
                  ),
                ),
                GestureDetector(
                  onTap: c.useMyLocation,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_10, vertical: Dimensions.h_8),
                    decoration: BoxDecoration(color: AppColor.blueSoft(context), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                    child: Text('Use my location', style: linkStyle(context)),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 0.5, thickness: 0.5, color: AppColor.border(context)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_10),
            child: Row(
              children: [
                Icon(CupertinoIcons.clock, size: Dimensions.h_16, color: AppColor.blue(context)),
                SizedBox(width: Dimensions.w_8),
                Expanded(child: whenChips(context, c, AlertsController.reportWhens, c.reportWhen)),
              ],
            ),
          ),
        ],
      ),
    ),
  ];

  Widget categoryTile(BuildContext context, AlertsController c, int i) {
    final cat = AlertsController.reportCategories[i];
    final isSelected = c.reportCategory == i;
    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: () => c.selectReportCategory(i),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.surface(context),
            borderRadius: BorderRadius.circular(Dimensions.h_12),
            border: Border.all(color: isSelected ? AppColor.blue(context) : AppColor.border(context), width: isSelected ? 1.5 : 0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Dimensions.h_32,
                height: Dimensions.h_32,
                decoration: BoxDecoration(color: toneSoft(context, cat.tone), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                child: Icon(cat.icon, size: Dimensions.h_16, color: tone(context, cat.tone)),
              ),
              SizedBox(height: Dimensions.h_6),
              Text(cat.title, style: titleStyle(context, FontSize.sp_10)),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> describeSection(BuildContext context, AlertsController c, String title, List<String> suggestions, String hint, String note) => [
    label(context, title),
    SizedBox(
      height: Dimensions.h_32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        separatorBuilder: (_, _) => SizedBox(width: Dimensions.w_8),
        itemBuilder: (context, i) => GestureDetector(
          onTap: () => c.addReportSuggestion(suggestions[i]),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12),
            decoration: BoxDecoration(color: AppColor.surface(context), borderRadius: BorderRadius.circular(Dimensions.h_20), border: Border.all(color: AppColor.border(context), width: 0.5)),
            child: Text('+ ${suggestions[i]}', style: titleStyle(context, FontSize.sp_11, weight: FontWeight.w600)),
          ),
        ),
      ),
    ),
    SizedBox(height: Dimensions.h_10),
    CommonTextField(controller: c.issueText, hint: hint, minLines: 5, maxLines: 8, maxLength: AlertsController.maxReportLength, fontSize: FontSize.sp_12, onChanged: (_) => c.update([ControllerBuilders.reportIssue])),
    Text(note, style: mutedStyle(context, size: FontSize.sp_10)),
  ];

  Widget whenChips(BuildContext context, AlertsController c, List<String> options, int selected) {
    return Wrap(
      spacing: Dimensions.w_6,
      runSpacing: Dimensions.h_6,
      children: [
        for (var i = 0; i < options.length; i++)
          Semantics(
            button: true,
            selected: i == selected,
            child: GestureDetector(
              onTap: () => c.selectReportWhen(i),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_8),
                decoration: BoxDecoration(
                  color: i == selected ? Theme.of(context).highlightColor : AppColor.surface(context),
                  borderRadius: BorderRadius.circular(Dimensions.h_20),
                  border: Border.all(color: i == selected ? Theme.of(context).highlightColor : AppColor.border(context), width: 0.5),
                ),
                child: Text(options[i], style: TextStyle(color: i == selected ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> updateSections(BuildContext context, AlertsController c) {
    final incidents = c.visibleIncidents;
    return [
      label(context, 'Which incident?'),
      CommonTextField(controller: c.incidentSearch, hint: 'Search by name or place', prefixIcon: CupertinoIcons.search, fontSize: FontSize.sp_12, onChanged: (_) => c.update([ControllerBuilders.reportIssue])),
      SizedBox(height: Dimensions.h_10),
      Container(
        decoration: cardDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(Dimensions.w_12, Dimensions.h_10, Dimensions.w_12, Dimensions.h_8),
              child: Text('Active near you', style: mutedStyle(context, size: FontSize.sp_11).copyWith(fontWeight: FontWeight.w600)),
            ),
            if (incidents.isEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(Dimensions.w_12, 0, Dimensions.w_12, Dimensions.h_12),
                child: Text('No incidents match your search.', style: mutedStyle(context)),
              ),
            for (final i in incidents) incidentRow(context, c, i),
          ],
        ),
      ),
      label(context, 'How is it where you are?'),
      Row(
        children: [
          for (var i = 0; i < AlertsController.updateStatuses.length; i++) ...[
            if (i > 0) SizedBox(width: Dimensions.w_8),
            Expanded(child: statusTile(context, c, i)),
          ],
        ],
      ),
      ...describeSection(context, c, 'What\'s changed?', AlertsController.updateSuggestions, 'For example: power came back on 334th Ave at 9:15. Crews still working near the school.', 'Say how you know: did you see it, or hear it from someone?'),
      label(context, 'When did you notice?'),
      whenChips(context, c, AlertsController.updateWhens, c.updateWhen),
    ];
  }

  Widget incidentRow(BuildContext context, AlertsController c, int i) {
    final incident = AlertsController.activeIncidents[i];
    final isSelected = c.updateIncident == i;
    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => c.selectUpdateIncident(i),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_12, vertical: Dimensions.h_10),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.blueSoft(context) : AppColor.transparent,
            border: Border(top: BorderSide(color: AppColor.border(context), width: 0.5)),
          ),
          child: Row(
            children: [
              Container(
                width: Dimensions.h_32,
                height: Dimensions.h_32,
                decoration: BoxDecoration(color: toneSoft(context, incident.tone), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                child: Icon(incident.icon, size: Dimensions.h_15, color: tone(context, incident.tone)),
              ),
              SizedBox(width: Dimensions.w_12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(incident.title, style: titleStyle(context, FontSize.sp_12)),
                    SizedBox(height: Dimensions.h_2),
                    Text(incident.status, style: mutedStyle(context, size: FontSize.sp_10)),
                  ],
                ),
              ),
              Icon(isSelected ? CupertinoIcons.checkmark_alt : CupertinoIcons.chevron_right, size: Dimensions.h_13, color: isSelected ? AppColor.blue(context) : AppColor.muted(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget statusTile(BuildContext context, AlertsController c, int i) {
    final status = AlertsController.updateStatuses[i];
    final isSelected = c.updateStatus == i;
    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: () => c.selectUpdateStatus(i),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h_12),
          decoration: BoxDecoration(
            color: AppColor.surface(context),
            borderRadius: BorderRadius.circular(Dimensions.h_12),
            border: Border.all(color: isSelected ? AppColor.blue(context) : AppColor.border(context), width: isSelected ? 1.5 : 0.5),
          ),
          child: Column(
            children: [
              Icon(status.icon, size: Dimensions.h_18, color: Theme.of(context).highlightColor),
              SizedBox(height: Dimensions.h_6),
              Text(status.title, style: titleStyle(context, FontSize.sp_11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget photos(BuildContext context, AlertsController c) {
    final blue = AppColor.blue(context);
    final tileSize = Dimensions.h_80;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(text: 'Photos ', children: [TextSpan(text: '(optional)', style: mutedStyle(context, size: FontSize.sp_15))]),
                style: titleStyle(context, FontSize.sp_15),
              ),
            ),
            Text('${c.reportPhotos.length} of ${AlertsController.maxReportPhotos}', style: mutedStyle(context, size: FontSize.sp_11).copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
        SizedBox(height: Dimensions.h_10),
        Wrap(
          spacing: Dimensions.w_8,
          runSpacing: Dimensions.h_8,
          children: [
            for (var i = 0; i < c.reportPhotos.length; i++)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.h_10),
                    child: Image.file(File(c.reportPhotos[i]), width: tileSize, height: tileSize, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: Dimensions.h_4,
                    right: Dimensions.h_4,
                    child: Semantics(
                      button: true,
                      label: 'Remove photo',
                      child: GestureDetector(
                        onTap: () => c.removeReportPhoto(i),
                        child: CircleAvatar(radius: Dimensions.h_10, backgroundColor: AppColor.black.withValues(alpha: 0.6), child: Icon(CupertinoIcons.xmark, size: Dimensions.h_10, color: AppColor.white)),
                      ),
                    ),
                  ),
                ],
              ),
            if (c.reportPhotos.length < AlertsController.maxReportPhotos)
              GestureDetector(
                onTap: c.pickReportPhotos,
                child: Container(
                  width: tileSize,
                  height: tileSize,
                  decoration: BoxDecoration(color: AppColor.surface(context), borderRadius: BorderRadius.circular(Dimensions.h_10), border: Border.all(color: blue.withValues(alpha: 0.4))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.camera, size: Dimensions.h_18, color: blue),
                      SizedBox(height: Dimensions.h_4),
                      Text('Add', style: linkStyle(context)),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: Dimensions.h_8),
        Text('Up to 10 photos. Leave out faces and house numbers.', style: mutedStyle(context, size: FontSize.sp_10)),
      ],
    );
  }

  Widget bottomBar(BuildContext context, AlertsController c) {
    final hint = c.reportHint;
    final enabled = hint == null;
    final foreground = enabled ? AppColor.white : AppColor.muted(context);
    return Container(
      padding: EdgeInsets.fromLTRB(Dimensions.w_15, Dimensions.h_10, Dimensions.w_15, MediaQuery.paddingOf(context).bottom + Dimensions.h_10),
      decoration: BoxDecoration(color: AppColor.surface(context), border: Border(top: BorderSide(color: AppColor.border(context), width: 0.5))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hint != null) ...[
            Text('!  $hint', style: mutedStyle(context, size: FontSize.sp_11).copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: Dimensions.h_8),
          ],
          Semantics(
            button: true,
            enabled: enabled,
            child: GestureDetector(
              onTap: c.sendIssue,
              child: Container(
                height: Dimensions.h_45,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: enabled ? AppColor.blue(context) : AppColor.border(context), borderRadius: BorderRadius.circular(Dimensions.h_12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.paperplane, size: Dimensions.h_16, color: foreground),
                    SizedBox(width: Dimensions.w_8),
                    Text(c.reportMode == 1 ? 'Send update' : 'Send report', style: TextStyle(color: foreground, fontSize: FontSize.sp_14, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

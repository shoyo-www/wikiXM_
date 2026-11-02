import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/Presentation/groups/controller.dart';
import 'package:wikixm/Presentation/widgets/common_card.dart';
import 'package:wikixm/Presentation/widgets/common_scaffold.dart';
import 'package:wikixm/Presentation/widgets/common_shimmer.dart';
import 'package:wikixm/Presentation/widgets/common_sliver_scaffold.dart';
import 'package:wikixm/constants/appcolor.dart';
import 'package:wikixm/constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../data/datasource/remote/models/response/activiyt_detail.dart' as model;
import '../widgets/cache_image.dart';
import '../widgets/entrance_animation.dart';
import '../widgets/map.dart';
import '../../data/datasource/remote/models/response/group_sections.dart' as sections;

class ActivityDetail extends StatefulWidget {
  const ActivityDetail({super.key});

  @override
  State<ActivityDetail> createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  final GroupController groupController = Get.find<GroupController>();

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return AppScaffold(
      top: false,
      bottom: false,
      bodyPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: GetBuilder<GroupController>(
        id: ControllerBuilders.activityDetailTabs,
        builder: (c) {
          if (c.selectedActivityTab != 'discussion') return const SizedBox.shrink();
          return Padding(
            padding: EdgeInsets.only(left: Dimensions.w_15, bottom: Dimensions.h_20, right: Dimensions.w_15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppCacheImage(imageUrl: 'https://preetis-html.vercel.app/assets/images/home/user-home1/profile-sean.jpg', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
                SizedBox(width: Dimensions.w_8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_10),
                    height: Dimensions.h_33,
                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(99)),
                    child: Text(
                      "Whats's on your mind, Sean ?",
                      style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w500, color: Theme.of(context).hintColor, height: 1.1),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.w_5),
                Container(
                  height: Dimensions.h_30,
                  width: Dimensions.h_30,
                  decoration: BoxDecoration(color: AppColor.blue(context), shape: BoxShape.circle),
                  child: Icon(CupertinoIcons.location_fill, size: Dimensions.h_13, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
      body: GetBuilder<GroupController>(
        init: groupController,
        id: ControllerBuilders.activityDetailPage,
        builder: (controller) {
          if (controller.activityDetailLoading) return pageShimmer();
          return CommonScrollBlurScaffold(
            showBack: true,
            expandedHeight: Dimensions.h_240,
            expandedColor: Colors.white,
            collapsedColor: Theme.of(context).highlightColor,
            hero: buildHeroHeader(isLight, controller.activityDetailData),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.h_5),
                      EntranceAnimation(child: GetBuilder<GroupController>(id: ControllerBuilders.activityDetailTabs, builder: buildTabs)),
                      SizedBox(height: Dimensions.h_10),
                      GetBuilder<GroupController>(
                        id: ControllerBuilders.activityDetailContent,
                        builder: (c) {
                          final data = c.activityDetailData;
                          final tab = c.selectedActivityTab;
                          // keyed by tab so switching tabs replays the entrance animation instead of reusing the old one
                          return KeyedSubtree(
                            key: ValueKey(tab),
                            child: tab == 'overview'
                                ? buildOverview(data)
                                : tab == 'discussion'
                                ? buildDiscussion(data)
                                : tab == 'participants'
                                ? buildParticipants(data)
                                : tab == 'route'
                                ? buildRoute(data)
                                : const SizedBox.shrink(),
                          );
                        },
                      ),
                      SizedBox(height: Dimensions.h_30),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String activityLabel(model.ActivityDetailData? data) => data?.label ?? 'activity';

  IconData detailIcon(String? icon) {
    switch (icon) {
      case 'clock':
        return CupertinoIcons.clock;
      case 'calendar':
        return CupertinoIcons.calendar;
      case 'pin':
        return CupertinoIcons.location;
      case 'mountains':
        return Icons.landscape_outlined;
      case 'users':
        return CupertinoIcons.person_2;
      case 'check':
        return CupertinoIcons.check_mark_circled;
      default:
        return CupertinoIcons.info_circle;
    }
  }

  String participantName(dynamic participant) {
    if (participant is! Map) return '';
    return (participant['name'] ?? '${participant['first_name'] ?? ''} ${participant['last_name'] ?? ''}').toString().trim();
  }

  String participantImage(dynamic participant) {
    if (participant is! Map) return '';
    final image = participant['image'] ?? participant['avatar'];
    return (image is Map ? image['url'] : image)?.toString() ?? '';
  }

  Widget emptyCard(String message) {
    return CommonCard(
      width: Get.width,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h_30),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: FontSize.sp_13_5, color: Theme.of(context).highlightColor),
        ),
      ),
    );
  }

  Widget buildTabs(GroupController controller) {
    final tabs = controller.activityTabs;
    final selectedTab = controller.selectedActivityTab;
    return Container(
      height: Dimensions.h_25,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.micrositeGrey(context), width: 0.6)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (c, index) {
          final tab = tabs[index];
          final isSelected = selectedTab == tab.id;
          return GestureDetector(
            onTap: () => controller.changeActivityTab(tab.id),
            child: Container(
              margin: EdgeInsets.only(right: Dimensions.w_8),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: isSelected ? AppColor.blue(context) : Colors.transparent, width: 3)),
              ),
              child: Text(
                tab.label?.toUpperCase() ?? '',
                style: TextStyle(color: isSelected ? AppColor.blue(context) : Theme.of(context).highlightColor, fontSize: FontSize.sp_12, fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700, height: 1),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildOverview(model.ActivityDetailData? data) {
    final activity = data?.activity;
    final label = activityLabel(data);
    final metrics = [
      (title: 'YOUR CREW', icon: CupertinoIcons.person_2, value: '${activity?.goingCount ?? 0} going', subtitle: '${activity?.spotsAvailable ?? 0} places left'),
      for (final detail in activity?.details ?? <model.Field>[]) (title: detail.id?.toUpperCase() ?? '', icon: detailIcon(detail.icon), value: detail.text ?? '', subtitle: ''),
    ];
    final rideDetails = [
      (title: 'When', icon: CupertinoIcons.calendar, value: data?.startsAtLabel ?? '', subtitle: data?.timezone ?? ''),
      for (final field in data?.fields ?? <model.Field>[]) (title: field.label ?? '', icon: detailIcon(field.icon), value: field.text ?? '', subtitle: ''),
      if (data?.capacity != null) (title: 'Group size', icon: CupertinoIcons.person_2, value: 'Up to ${data!.capacity}', subtitle: '${activity?.spotsAvailable ?? 0} places left'),
    ];
    final quickActions = [
      if (activity?.isOrganizer == true) (title: 'You’re the organizer', icon: CupertinoIcons.check_mark_circled, color: 'primary'),
      if (activity?.canJoin == true) (title: 'Join $label', icon: CupertinoIcons.add, color: 'primary'),
      if (activity?.canInterest == true) (title: 'I’m interested', icon: CupertinoIcons.star, color: 'soft'),
      (title: 'Invite a friend', icon: CupertinoIcons.person_2, color: 'outline'),
      if (activity?.isOrganizer != true) (title: 'Message organizer', icon: CupertinoIcons.mail, color: 'outline'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: staggered([
        Text(
          '${label.capitalizeFirst} overview',
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.w_4, top: Dimensions.h_2),
          child: Text(
            activity?.description ?? '',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: metrics.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_8, mainAxisSpacing: Dimensions.h_8, mainAxisExtent: Dimensions.h_80),
          itemBuilder: (context, index) {
            final metric = metrics[index];
            return CommonCard(
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(metric.icon, size: Dimensions.h_13, color: AppColor.blue(context)),
                      SizedBox(width: Dimensions.w_3),
                      Expanded(
                        child: Text(
                          metric.title,
                          style: TextStyle(fontSize: FontSize.sp_9_5, color: Theme.of(context).highlightColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_10),
                  Text(
                    metric.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: FontSize.sp_13, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                  ),
                  if (metric.subtitle.isNotEmpty)
                    Text(
                      metric.subtitle,
                      style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                    ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: Dimensions.h_20),
        Text(
          '${label.capitalizeFirst} details',
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_5),
            itemCount: rideDetails.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_8, mainAxisSpacing: Dimensions.h_8, mainAxisExtent: Dimensions.h_65),
            itemBuilder: (context, index) {
              final detail = rideDetails[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(detail.icon, size: Dimensions.h_13, color: AppColor.blue(context)),
                      SizedBox(width: Dimensions.w_6),
                      Expanded(
                        child: Text(
                          detail.title,
                          style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.h_4),
                  Text(
                    detail.value,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                  ),
                  SizedBox(height: Dimensions.h_3),
                  Text(
                    detail.subtitle,
                    style: TextStyle(fontSize: FontSize.sp_10, fontWeight: FontWeight.w400, color: Theme.of(context).hintColor),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: Dimensions.h_20),
        Text(
          'Make it your next $label.',
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: Dimensions.h_10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: Dimensions.w_8, right: Dimensions.w_8),
          itemCount: quickActions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: Dimensions.w_6, mainAxisSpacing: Dimensions.h_6, mainAxisExtent: Dimensions.h_35),
          itemBuilder: (context, index) {
            final action = quickActions[index];
            final foreground = action.color == 'primary'
                ? Colors.white
                : action.color == 'soft'
                ? AppColor.blue(context)
                : Theme.of(context).highlightColor;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.h_8),
                color: action.color == 'primary'
                    ? AppColor.blue(context)
                    : action.color == 'soft'
                    ? AppColor.blueSoft(context)
                    : Colors.transparent,
                border: Border.all(
                  color: action.color == 'primary'
                      ? Colors.transparent
                      : action.color == 'soft'
                      ? AppColor.blue(context)
                      : Theme.of(context).highlightColor,
                  width: 0.2,
                ),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(action.icon, size: Dimensions.h_15, color: foreground),
                    SizedBox(width: Dimensions.w_8),
                    Text(
                      action.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, color: foreground),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: Dimensions.h_20),
        CommonCard(
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Your crew',
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => groupController.changeActivityTab('participants'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800),
                        ),
                        Icon(CupertinoIcons.arrow_right, color: Theme.of(context).primaryColorDark, size: Dimensions.h_12),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.h_5),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_6),
                child: Text(
                  '${activity?.goingCount ?? 0} going. ${(activity?.spotsAvailable ?? 0) > 0 ? 'There’s room for you.' : 'No places left.'}',
                  style: TextStyle(fontSize: FontSize.sp_11, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor),
                ),
              ),
              if (data?.participants?.isNotEmpty ?? false) ...[
                SizedBox(height: Dimensions.h_15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: Dimensions.w_15),
                    for (final (i, participant) in data!.participants!.take(6).indexed) ...[
                      if (i > 0) SizedBox(width: Dimensions.w_8),
                      AppCacheImage(imageUrl: participantImage(participant), size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true),
                    ],
                  ],
                ),
              ],
              if (data?.organizer != null) ...[
                Container(
                  margin: EdgeInsets.only(bottom: Dimensions.h_10, top: Dimensions.h_10),
                  height: 0.2,
                  width: Get.width,
                  color: Theme.of(context).highlightColor,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: Dimensions.w_15),
                    AppCacheImage(imageUrl: data!.organizer!.image?.url ?? '', size: Dimensions.h_30, widthSize: Dimensions.h_30, isCircle: true, color: Theme.of(context).highlightColor),
                    SizedBox(width: Dimensions.w_8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.organizer!.name ?? '',
                            style: TextStyle(fontSize: FontSize.sp_12, fontWeight: FontWeight.w700, color: Theme.of(context).highlightColor),
                          ),
                          SizedBox(height: Dimensions.h_3),
                          Text(
                            [if (activity?.isOrganizer == true) 'You' else 'Your organizer', data.group?.name].whereType<String>().join(' · '),
                            style: TextStyle(fontSize: FontSize.sp_9_5, fontWeight: FontWeight.w500, color: Theme.of(context).highlightColor, height: 1.1),
                          ),
                        ],
                      ),
                    ),
                    Icon(CupertinoIcons.chat_bubble_text, size: Dimensions.h_16, color: AppColor.blue(context)),
                    SizedBox(width: Dimensions.w_8),
                  ],
                ),
              ],
            ],
          ),
        ),
      ]),
    );
  }

  Widget buildDiscussion(model.ActivityDetailData? data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: staggered([
        Text(
          'The ${activityLabel(data)} conversation',
          style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.w_6, top: Dimensions.h_2),
          child: Text(
            'Ask a question, share a tip, or say hello to your crew, Sean.',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.1),
          ),
        ),
        SizedBox(height: Dimensions.h_20),
        CommonCard(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Dimensions.h_10),
              Container(
                height: Dimensions.h_45,
                width: Dimensions.h_45,
                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_8)),
                child: Icon(CupertinoIcons.chat_bubble_2, size: Dimensions.h_20, color: AppColor.blue(context)),
              ),
              SizedBox(height: Dimensions.h_10),
              Text(
                "No comments yet",
                style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: Dimensions.h_10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
                child: Text(
                  textAlign: TextAlign.center,
                  'Start the conversation. Ask a question or say hello to your crew.',
                  style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: Dimensions.h_20),
            ],
          ),
        ),
      ]),
    );
  }

  Widget participantsEmpty(model.ActivityDetailData? data) {
    return CommonCard(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Dimensions.h_10),
          Container(
            height: Dimensions.h_45,
            width: Dimensions.h_45,
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_8)),
            child: Icon(CupertinoIcons.person_2, size: Dimensions.h_20, color: AppColor.blue(context)),
          ),
          SizedBox(height: Dimensions.h_10),
          Text(
            "No one has joined yet",
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_13_5, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: Dimensions.h_10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15),
            child: Text(
              textAlign: TextAlign.center,
              'Be the first to bring your crew. Invite people to join this ${activityLabel(data)}.',
              style: TextStyle(color: Theme.of(context).hintColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: Dimensions.h_20),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
              decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(99)),
              child: Text(
                'Invite People',
                style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
              ),
            ),
          ),
          SizedBox(height: Dimensions.h_15),
        ],
      ),
    );
  }

  Widget buildParticipants(model.ActivityDetailData? data) {
    final participants = data?.participants ?? [];
    if (participants.isEmpty) return EntranceAnimation(child: participantsEmpty(data));
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: participants.length,
      itemBuilder: (c, i) {
        final participant = participants[i];
        return EntranceAnimation(
          key: ValueKey('participant$i'),
          index: i,
          child: CommonCard(
          margin: EdgeInsets.only(bottom: Dimensions.h_10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCacheImage(imageUrl: participantImage(participant), size: Dimensions.h_90, widthSize: Dimensions.h_80, isShadow: false, radius: Dimensions.h_6),
                  SizedBox(width: Dimensions.w_8),
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            participantName(participant),
                            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_14, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Icon(Icons.verified_sharp, color: AppColor.blue(context), size: Dimensions.h_12),
                      ],
                    ),
                  ),
                  Icon(Icons.favorite_border, color: AppColor.blue(context), size: Dimensions.h_18),
                ],
              ),
              SizedBox(height: Dimensions.h_10),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
                          decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.circular(Dimensions.h_8)),
                          child: Center(
                            child: Text(
                              "View Profile",
                              style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400, height: 1.2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.w_10),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.h_8),
                          decoration: BoxDecoration(color: Color(0xff1d5fef), borderRadius: BorderRadius.circular(Dimensions.h_8)),
                          child: Center(
                            child: Text(
                              "Connect",
                              style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ),
        );
      },
    );
  }

  Widget buildRoute(model.ActivityDetailData? data) {
    final activity = data?.activity;
    final details = activity?.details ?? <model.Field>[];
    final place = details.firstWhereOrNull((d) => d.id == 'place')?.text ?? data?.venueAddress?.toString() ?? '';
    final route = data?.fields?.firstWhereOrNull((f) => f.id == 'route')?.text ?? details.firstWhereOrNull((d) => d.id == 'route')?.text ?? '';
    final hasLocation = activity?.latitude != null && activity?.longitude != null;
    final marker = sections.InitialPreview(
      id: '${activity?.activityId}',
      activityId: activity?.activityId,
      name: activity?.title,
      date: data?.startsAtLabel,
      place: place,
      color: activity?.badge?.color,
      latitude: activity?.latitude,
      longitude: activity?.longitude,
      image: sections.Image(url: activity?.image?.url),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: staggered([
        if (hasLocation)
          NearbyMap(
            nearby: sections.Nearby(
              title: 'Route',
              map: sections.MapClass(
                caption: place,
                center: sections.CenterData(latitude: activity!.latitude, longitude: activity.longitude),
                zoom: sections.Zoom(min: 2, max: 19, initial: 13, step: 1),
                initialPreview: marker,
                markers: [marker],
              ),
            ),
          )
        else ...[
          Text(
            'Route',
            style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_15, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: Dimensions.h_10),
          emptyCard('No location shared yet.'),
        ],
        SizedBox(height: Dimensions.h_10),
        CommonCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.w_8, right: Dimensions.w_6),
                    height: Dimensions.h_2,
                    width: Dimensions.w_20,
                    color: AppColor.blue(context),
                  ),
                  Text(
                    route,
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: Dimensions.w_15),
                  Icon(Icons.location_on_sharp, size: Dimensions.h_12, color: AppColor.green(context)),
                  SizedBox(width: Dimensions.w_5),
                  Text(
                    'Start & finish',
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              if (place.isNotEmpty) ...[
                SizedBox(height: Dimensions.h_8),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_8),
                  child: Text(
                    'Meet at $place.',
                    style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_10, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ],
          ),
        ),
      ]),
    );
  }

  Widget pageShimmer() {
    Widget metaRow() => Row(
      children: [
        for (var i = 0; i < 2; i++) ...[
          ShimmerBox(Dimensions.h_12, Dimensions.h_12, isCircle: true),
          SizedBox(width: Dimensions.w_5),
          ShimmerBox(Dimensions.w_80, Dimensions.h_10),
          SizedBox(width: Dimensions.w_20),
        ],
      ],
    );
    Widget gridRow(double height, {bool card = true}) => Padding(
      padding: EdgeInsets.only(bottom: Dimensions.h_8),
      child: Row(
        children: [
          for (var c = 0; c < 2; c++) ...[
            if (c > 0) SizedBox(width: Dimensions.w_8),
            Expanded(
              child: card
                  ? ShimmerCard(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [ShimmerBox(Dimensions.h_13, Dimensions.h_13, isCircle: true), SizedBox(width: Dimensions.w_5), ShimmerBox(Dimensions.w_60, Dimensions.h_8)]),
                          SizedBox(height: Dimensions.h_10),
                          ShimmerBox(Dimensions.w_90, Dimensions.h_12),
                          SizedBox(height: Dimensions.h_5),
                          ShimmerBox(Dimensions.w_70, Dimensions.h_10),
                        ],
                      ),
                      height: height,
                    )
                  : ShimmerBox(double.infinity, height, radius: Dimensions.h_8),
            ),
          ],
        ],
      ),
    );
    return CommonShimmer(
      heroHeight: Dimensions.h_240,
      hero: [
        ShimmerBox(Dimensions.w_35, Dimensions.h_33, radius: Dimensions.h_10),
        const Spacer(),
        ShimmerBox(Dimensions.w_90, Dimensions.h_11),
        SizedBox(height: Dimensions.h_6),
        ShimmerBox(Dimensions.w_220, Dimensions.h_23, radius: Dimensions.h_8),
        SizedBox(height: Dimensions.h_10),
        ShimmerBox(Dimensions.w_175, Dimensions.h_11),
        SizedBox(height: Dimensions.h_10),
        metaRow(),
        SizedBox(height: Dimensions.h_8),
        metaRow(),
        SizedBox(height: Dimensions.h_15),
        ShimmerBox(Dimensions.w_150, Dimensions.h_22, radius: 99),
        SizedBox(height: Dimensions.h_15),
        Row(
          children: [
            Expanded(child: ShimmerBox(double.infinity, Dimensions.h_30, radius: Dimensions.h_8)),
            SizedBox(width: Dimensions.w_10),
            Expanded(child: ShimmerBox(double.infinity, Dimensions.h_30, radius: Dimensions.h_8)),
          ],
        ),
      ],
      body: [
        SizedBox(height: Dimensions.h_10),
        Row(
          children: [
            for (var i = 0; i < 4; i++) ...[ShimmerBox(Dimensions.w_65, Dimensions.h_12), SizedBox(width: Dimensions.w_15)],
          ],
        ),
        SizedBox(height: Dimensions.h_15),
        ShimmerBox(Dimensions.w_120, Dimensions.h_15),
        SizedBox(height: Dimensions.h_8),
        ShimmerBox(double.infinity, Dimensions.h_10),
        SizedBox(height: Dimensions.h_15),
        for (var r = 0; r < 3; r++) gridRow(Dimensions.h_80),
        SizedBox(height: Dimensions.h_15),
        ShimmerBox(Dimensions.w_110, Dimensions.h_15),
        SizedBox(height: Dimensions.h_10),
        ShimmerCard(
          Column(
            children: [
              for (var r = 0; r < 2; r++)
                Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.h_15),
                  child: Row(
                    children: [
                      for (var c = 0; c < 2; c++)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [ShimmerBox(Dimensions.h_13, Dimensions.h_13, isCircle: true), SizedBox(width: Dimensions.w_6), ShimmerBox(Dimensions.w_70, Dimensions.h_10)]),
                              SizedBox(height: Dimensions.h_6),
                              ShimmerBox(Dimensions.w_110, Dimensions.h_12),
                              SizedBox(height: Dimensions.h_5),
                              ShimmerBox(Dimensions.w_60, Dimensions.h_8),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_15),
        ShimmerBox(Dimensions.w_175, Dimensions.h_15),
        SizedBox(height: Dimensions.h_10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_8),
          child: Column(children: [gridRow(Dimensions.h_35, card: false), gridRow(Dimensions.h_35, card: false)]),
        ),
        SizedBox(height: Dimensions.h_15),
        ShimmerCard(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [ShimmerBox(Dimensions.w_90, Dimensions.h_15), const Spacer(), ShimmerBox(Dimensions.w_50, Dimensions.h_10)]),
              SizedBox(height: Dimensions.h_8),
              ShimmerBox(Dimensions.w_150, Dimensions.h_10),
              SizedBox(height: Dimensions.h_15),
              Row(
                children: [
                  SizedBox(width: Dimensions.w_15),
                  ShimmerBox(Dimensions.h_30, Dimensions.h_30, isCircle: true),
                  SizedBox(width: Dimensions.w_8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ShimmerBox(Dimensions.w_90, Dimensions.h_12), SizedBox(height: Dimensions.h_5), ShimmerBox(Dimensions.w_140, Dimensions.h_8)],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.h_30),
      ],
    );
  }

  Widget heroMeta(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: Dimensions.h_12, color: Colors.white),
        SizedBox(width: Dimensions.w_5),
        Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_10, fontWeight: FontWeight.w800, height: 1.2),
        ),
      ],
    );
  }

  Widget buildHeroHeader(bool isLight, model.ActivityDetailData? data) {
    final activity = data?.activity;
    final details = activity?.details ?? <model.Field>[];
    final label = activityLabel(data);
    final isOrganizer = activity?.isOrganizer ?? false;
    final canLeave = !isOrganizer && activity?.isJoined == true && (activity?.canLeave ?? false);
    final showInterest = activity?.canInterest == true || activity?.isInterested == true;
    final joinBg =  canLeave ? const Color(0xFFFDE2E2) : const Color(0xff1d5fef);
    final joinFg =  canLeave ? const Color(0xFFB91C1C) : Colors.white;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCacheImage(alignment: Alignment(0.5, 0), size: Dimensions.h_330, widthSize: Get.width, imageUrl: activity?.image?.url ?? ''),
        Positioned.fill(
          child: Container(
            height: Dimensions.h_330,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [const Color(0xFF020B15).withValues(alpha: 0.85), const Color(0xFF020B15).withValues(alpha: 0.65), const Color(0xFF020B15).withValues(alpha: 0.35), Colors.transparent], stops: const [0.10, 0.50, 0.68, 1.0]),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.h_330,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_70),
                child: Text(
                  activity?.badge?.label?.toUpperCase() ?? '',
                  style: TextStyle(color: const Color(0xFFFFE47A), fontSize: FontSize.sp_11, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_4),
                child: Text(
                  activity?.title ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_22,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_10, top: Dimensions.h_10),
                child: Text(
                  [data?.group?.name, data?.interest?.name].whereType<String>().join(' · '),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.sp_11,
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: Colors.black.withValues(alpha: 0.9), blurRadius: 30, offset: const Offset(0, 2))],
                  ),
                ),
              ),
              for (var row = 0; row * 2 < details.length && row < 2; row++)
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.w_10, top: row == 0 ? Dimensions.h_10 : Dimensions.h_8, right: Dimensions.w_20),
                  child: Row(
                    children: [
                      for (final (i, detail) in details.skip(row * 2).take(2).indexed) ...[
                        if (i > 0) SizedBox(width: Dimensions.w_20),
                        heroMeta(detailIcon(detail.icon), detail.text ?? ''),
                      ],
                    ],
                  ),
                ),
              SizedBox(height: Dimensions.h_15),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w_8),
                child: GestureDetector(
                  onTap: () => groupController.changeActivityTab('participants'),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w_6, vertical: Dimensions.h_4),
                    decoration: BoxDecoration(
                      border: Border.all(color: isLight ? AppColor.sportsLightBorder : Colors.white, width: 0.8),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.person_2, size: Dimensions.h_13, color: Colors.white),
                        SizedBox(width: Dimensions.w_5),
                        Text(
                          "${activity?.goingCount ?? 0} going · ${activity?.spotsAvailable ?? 0} places left",
                          style: TextStyle(color: Colors.white, fontSize: FontSize.sp_11, fontWeight: FontWeight.w800, height: 1.2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Flexible(
                      fit: showInterest ? FlexFit.tight : FlexFit.loose,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.w_15, vertical: Dimensions.h_8),
                          decoration: BoxDecoration(color: joinBg, borderRadius: BorderRadius.circular(Dimensions.h_8)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(isOrganizer ? CupertinoIcons.check_mark_circled : canLeave ? CupertinoIcons.minus_circle_fill : CupertinoIcons.plus_circle_fill, size: Dimensions.h_15, color: joinFg),
                              SizedBox(width: Dimensions.w_8),
                              Text(
                                isOrganizer ? "You're the organizer" : canLeave ? "Leave ${label.capitalizeFirst}" : "Join ${label.capitalizeFirst}",
                                style: TextStyle(color: joinFg, fontSize: FontSize.sp_11, fontWeight: FontWeight.w700, height: 1.2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (showInterest) ...[
                      SizedBox(width: Dimensions.w_5),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: Dimensions.w_8, top: Dimensions.h_5, bottom: Dimensions.h_8),
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.w_1, vertical: Dimensions.h_8),
                            decoration: BoxDecoration(
                              color: AppColor.groupDetailWhite(context),
                              border: Border.all(color: isLight ? AppColor.sportsLightBorder : Colors.white, width: 0.5),
                              borderRadius: BorderRadius.circular(Dimensions.h_8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(activity?.isInterested == true ? CupertinoIcons.star_fill : CupertinoIcons.star, size: Dimensions.h_13, color: Theme.of(context).highlightColor),
                                SizedBox(width: Dimensions.w_5),
                                Text(
                                  activity?.isInterested == true ? "Interested" : "I'm Interested",
                                  style: TextStyle(color: Theme.of(context).highlightColor, fontSize: FontSize.sp_11, fontWeight: FontWeight.w600, height: 1.2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(width: Dimensions.w_10),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.h_5),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -2,
          child: IgnorePointer(
            child: Container(
              height: Dimensions.h_15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.0),
                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.15),
                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.35),
                    (isLight ? AppColor.softBackground : AppColor.backgroundDark).withValues(alpha: 0.78),
                    isLight ? AppColor.softBackground : AppColor.backgroundDark,
                  ],
                  stops: const [0.08, 0.25, 0.45, 0.75, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

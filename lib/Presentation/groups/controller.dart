import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wikixm/data/datasource/Repository_impl/group_repository_impl.dart';
import 'package:wikixm/data/datasource/remote/models/request/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_home.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_sections.dart';
import '../../constants/constants.dart';
import '../../data/datasource/remote/models/response/group_detail.dart';
import '../../data/datasource/remote/models/response/activiyt_detail.dart' as activity_model;
import '../../data/datasource/remote/models/response/group_join.dart';
import '../../data/datasource/remote/models/response/interest_detail.dart';
import '../../data/datasource/remote/models/response/my_group_attention.dart';
import '../../data/datasource/remote/models/response/my_group_invitations.dart';
import '../../data/datasource/remote/models/response/my_group_activities.dart';
import '../../data/datasource/remote/models/response/my_group_list.dart';
import '../../data/datasource/remote/models/response/my_group_summary.dart';
import '../../data/datasource/remote/models/response/activity_profile.dart';
import '../../data/datasource/remote/models/response/public_profile.dart' as pp;
import '../../data/datasource/remote/models/response/public_profile_feed.dart';
import '../../data/datasource/remote/models/response/search_group.dart' as discover;
import '../../data/datasource/remote/models/response/search_group_overview.dart' as discover_overview;
import '../../data/datasource/remote/services/apis.dart';
import '../../approutes.dart';

class GroupController extends GetxController {
  bool isLoading = false;
  final GroupRepositoryImpl groupRepositoryImpl = GroupRepositoryImpl();
  GroupData? groupData;
  GroupSectionData? groupSectionData;
  JoinLeaveData? joinLeaveData;
  final Set<int> processingGroupIds = {};
  int currentStep = 0;
  InterestData? interestData;
  GroupDetailData? groupDetailData;
  GroupDetailData? groupTabData;
  bool groupTabLoading = false;
  String groupDetailId = '';
  Map<String, dynamic> groupDetailParams = {};
  activity_model.ActivityDetailData? activityDetailData;
  bool activityDetailLoading = false;
  int activityDetailId = 0;
  String? activityDetailTab;
  bool interestLoading = false;
  bool groupDetailLoading = false;
  String? groupDetailTab;
  String interestSlug = '';
  String? interestTab;
  final TextEditingController interestSearchController = TextEditingController();
  String interestCategory = 'all';
  String? interestSort;
  Map<String, Set<String>> interestFilters = {};
  String selectedCover = 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-crew.webp';

  final List<Map<String, dynamic>> quickActions = [
    {'title': 'Plan', 'icon': Icons.calendar_today_outlined, 'type': 'join', 'color': 'outline'},
    {'title': 'Invite a friend', 'icon': CupertinoIcons.person_2, 'type': 'interest', 'color': 'outline'},
    {'title': 'Share your group', 'icon': CupertinoIcons.share, 'type': 'invite', 'color': 'outline'},
    {'title': 'Your preference', 'icon': CupertinoIcons.settings, 'type': 'organizer', 'color': 'outline'},
  ];

  final List<Map<String, String>> coverChoices = [
    {'file': 'cover-crew.webp', 'name': 'Biking crew', 'url': 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-crew.webp'},
    {'file': 'cover-town-ridgewood.webp', 'name': 'Ridgewood', 'url': 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-ridgewood.webp'},
    {'file': 'cover-town-mapleton.webp', 'name': 'Mapleton', 'url': 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-mapleton.webp'},
    {'file': 'cover-town-cedar-grove.webp', 'name': 'Cedar Grove', 'url': 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-cedar-grove.webp'},
    {'file': 'cover-town-highland.webp', 'name': 'Highland', 'url': 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-highland.webp'},
    {'file': 'cover-town-oak-creek.webp', 'name': 'Oak Creek', 'url': 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-oak-creek.webp'},
  ];

  final List<Map<String, String>> additionalPhotos = [
    {'file': 'cover-town-ridgewood.webp', 'name': 'Ridgewood', 'url': 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-ridgewood.webp'},
    {'file': 'cover-town-mapleton.webp', 'name': 'Mapleton', 'url': 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-mapleton.webp'},
    {'file': 'cover-town-cedar-grove.webp', 'name': 'Cedar Grove', 'url': 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-cedar-grove.webp'},
  ];
  bool showAllNearbyTowns = false;

  Set<String> selectedTownIds = {'pine-valley', 'ridgewood', 'mapleton', 'cedar-grove', 'highland', 'oak-creek', 'timber-ridge', 'aspen-springs'};

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void nextStep() {
    if (currentStep < 6) {
      currentStep++;
      update([ControllerBuilders.createGroupController]);
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      update([ControllerBuilders.createGroupController]);
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 6) {
      currentStep = step;
      update([ControllerBuilders.createGroupController]);
    }
  }

  final TextEditingController primaryTownController = TextEditingController(text: 'Issaquah');

  final TextEditingController customRadiusController = TextEditingController(text: '15');

  int selectedRadius = 15;
  bool isCustomRadius = false;

  int groupIdOf(dynamic item) {
    final fromId = int.tryParse(item?.id?.toString() ?? '');
    if (fromId != null && fromId != 0) return fromId;
    return int.tryParse(item?.groupId?.toString() ?? '') ?? 0;
  }

  void getData() async {
    isLoading = true;
    update([ControllerBuilders.groupController]);
    await Future.wait([getGroupHome(), getGroupSections()]);
    isLoading = false;
    update([ControllerBuilders.groupController]);
  }

  Future<void> getGroupHome() async {
    final data = await groupRepositoryImpl.getGroupHome();
    data.fold((l) => debugPrint('getGroupHome failed: $l'), (r) {
      if (r.success == true) groupData = r.data;
    });
  }

  void resetInterestFilters() {
    interestSearchController.clear();
    interestCategory = 'all';
    interestSort = null;
    interestFilters = {};
  }

  void changeInterestTab(String? tab) {
    if (tab == null || tab == interestTab) return;
    interestTab = tab;
    resetInterestFilters();
    update([ControllerBuilders.interestTabs, ControllerBuilders.interestFilters]);
    getInterestDetail(interestSlug);
  }

  void changeInterestCategory(String? category) {
    if (category == null || category == interestCategory) return;
    interestCategory = category;
    update([ControllerBuilders.interestHeader]);
    getInterestDetail(interestSlug);
  }

  void changeInterestSort(String? sort) {
    interestSort = sort;
    update([ControllerBuilders.interestFilters]);
  }

  void toggleInterestFilter(Filter filter, String value) {
    final name = filter.name ?? '';
    final selected = interestFilters[name] ?? {};
    if (filter.multiple == true) {
      if (!selected.remove(value)) selected.add(value);
      interestFilters[name] = selected;
    } else {
      interestFilters[name] = {value};
    }
    update([ControllerBuilders.interestFilters]);
  }

  final Map<int, bool> interestJoined = {};

  Future<void> toggleInterestGroup(int groupId, bool isLeave) async {
    if (groupId == 0 || processingGroupIds.contains(groupId)) return;
    processingGroupIds.add(groupId);
    update([ControllerBuilders.interestItems]);
    final result = await groupRepositoryImpl.joinGroup(GroupJoinRequest(cityId: interestData?.cityId ?? groupData?.location?.id ?? 0, groupId: groupId), isLeave);
    result.fold(
      (l) {
        debugPrint('toggleInterestGroup failed: $l');
        Get.snackbar('Error', isLeave ? 'Could not leave group' : 'Could not join group');
      },
      (r) {
        if (r.success == true) interestJoined[groupId] = r.data?.isJoined ?? !isLeave;
      },
    );
    processingGroupIds.remove(groupId);
    update([ControllerBuilders.interestItems]);
  }

  int _interestRequest = 0;

  Future<void> getInterestDetail(String interest, {int page = 1}) async {
    if (interest != interestSlug) {
      interestSlug = interest;
      interestTab = null;
      interestData = null;
      resetInterestFilters();
    }
    final requestId = ++_interestRequest;
    final firstLoad = interestData == null;
    interestLoading = true;
    update([firstLoad ? ControllerBuilders.interestDetailController : ControllerBuilders.interestItems]);
    final search = interestSearchController.text.trim();
    final request = <String, dynamic>{
      'city_id': groupData?.location?.id,
      if (interestTab != null) 'tab': interestTab,
      if (search.isNotEmpty) 'search': search.length > 150 ? search.substring(0, 150) : search,
      'category': interestCategory,
      if (interestSort != null) 'sort': interestSort,
      for (final f in interestFilters.entries)
        if (f.value.isNotEmpty) '${f.key}[]': f.value.toList(),
      'page': page,
    };
    final data = await groupRepositoryImpl.interestDetail(interest, request);
    if (requestId != _interestRequest) return;
    final old = interestData?.discovery;
    data.fold((l) => debugPrint('getInterestDetail failed: $l'), (r) {
      if (r.success == true) {
        interestData = r.data;
        interestJoined.clear();
        interestTab = r.data?.discovery?.activeTab ?? interestTab;
      }
    });
    interestLoading = false;
    if (firstLoad) {
      update([ControllerBuilders.interestDetailController]);
      return;
    }
    final now = interestData?.discovery;
    final heroChanged = old?.interestName != now?.interestName || old?.heading != now?.heading || old?.intro != now?.intro || old?.image?.url != now?.image?.url;
    update([
      if (heroChanged) ControllerBuilders.interestHero,
      ControllerBuilders.interestTabs,
      ControllerBuilders.interestHeader,
      ControllerBuilders.interestItems,
      ControllerBuilders.interestFilters,
    ]);
  }

  bool hasGroupDetailTab(String id) => (groupDetailData?.profile?.tabs ?? []).any((t) => t.id == id);

  String? get selectedGroupDetailTab {
    final tabs = groupDetailData?.profile?.tabs ?? [];
    if (tabs.any((t) => t.id == groupDetailTab)) return groupDetailTab;
    return tabs.isEmpty ? null : tabs.first.id;
  }

  void changeGroupDetailTab(String? tab) {
    if (tab == null || tab == groupDetailTab) return;
    groupDetailTab = tab;
    groupTabData = null;
    groupTabLoading = false;
    if (tab != 'overview') getGroupDetailTab(tab);
    update([ControllerBuilders.groupDetailTabs, ControllerBuilders.groupDetailContent]);
  }

  Future<void> getGroupDetailTab(String tab) async {
    groupTabLoading = true;
    final data = await groupRepositoryImpl.groupDetail(groupDetailId, {"tab": tab, ...groupDetailParams});
    if (groupDetailTab != tab) return;
    data.fold((l) => debugPrint('getGroupDetailTab failed: $l'), (r) {
      if (r.success == true) groupTabData = r.data;
    });
    groupTabLoading = false;
    update([ControllerBuilders.groupDetailContent]);
  }

  Future<void> getGroupDetail(String id, String tab, {int? cityId}) async {
    groupDetailId = id;
    groupDetailParams = {if (cityId != null) 'city_id': cityId};
    groupDetailTab = tab;
    groupTabData = null;
    groupTabLoading = false;
    groupDetailLoading = true;
    update([ControllerBuilders.groupDetailPage]);
    final data = await groupRepositoryImpl.groupDetail(id, {"tab": tab, ...groupDetailParams});
    data.fold(
      (l) {
        groupDetailLoading = false;
        update([ControllerBuilders.groupDetailPage]);
      },
      (r) {
        if (r.success == true) {
          groupDetailData = r.data;
          groupDetailLoading = false;
          final selected = selectedGroupDetailTab;
          if (selected != null && selected != tab) {
            groupDetailTab = selected;
            if (selected != 'overview') getGroupDetailTab(selected);
          }
          update([ControllerBuilders.groupDetailPage]);
        } else {
          groupDetailLoading = false;
          update([ControllerBuilders.groupDetailPage]);
        }
      },
    );
  }

  List<activity_model.Tab> get activityTabs => (activityDetailData?.tabs ?? []).where((t) => t.kind != 'dialog').toList();

  String? get selectedActivityTab {
    final tabs = activityTabs;
    if (tabs.any((t) => t.id == activityDetailTab)) return activityDetailTab;
    return tabs.isEmpty ? null : tabs.first.id;
  }

  void changeActivityTab(String? tab) {
    if (tab == null || tab == selectedActivityTab) return;
    activityDetailTab = tab;
    update([ControllerBuilders.activityDetailTabs, ControllerBuilders.activityDetailContent]);
  }

  Future<void> getActivityDetail(int id, {int? cityId}) async {
    activityDetailId = id;
    activityDetailData = null;
    activityDetailTab = null;
    activityDetailLoading = true;
    update([ControllerBuilders.activityDetailPage]);
    final data = await groupRepositoryImpl.activityDetail('$id', {if (cityId != null) 'city_id': cityId});
    if (activityDetailId != id) return;
    data.fold((l) => debugPrint('getActivityDetail failed: $l'), (r) {
      if (r.success == true) activityDetailData = r.data;
    });
    activityDetailLoading = false;
    update([ControllerBuilders.activityDetailPage]);
  }

  Future<void> getGroupSections() async {
    final data = await groupRepositoryImpl.getGroupSections();
    data.fold((l) => debugPrint('getGroupSections failed: $l'), (r) {
      if (r.success == true) groupSectionData = r.data;
    });
  }

  Future<void> joinGroup(bool isLeave, int groupId) async {
    if (groupId == 0) {
      debugPrint('joinGroup: invalid groupId');
      return;
    }
    if (processingGroupIds.contains(groupId)) return;

    final featured = _findFeatured(groupId);
    if (featured == null) {
      debugPrint('joinGroup: group $groupId not found in featured items');
      return;
    }
    final prevIsJoined = featured.isJoined;
    final prevCount = featured.membersCount;
    final prevLabel = featured.membersLabel;
    final prevCanJoin = featured.canJoin;
    final newCount = prevCount == null ? null : (prevCount + (isLeave ? -1 : 1)).clamp(0, 1 << 31);
    processingGroupIds.add(groupId);
    _updateFeaturedGroup(groupId, isJoined: !isLeave, membersCount: newCount, membersLabel: newCount == null ? prevLabel : _membersLabel(newCount));
    update([ControllerBuilders.groupFeatured]);

    void rollback() => _updateFeaturedGroup(groupId, isJoined: prevIsJoined, membersCount: prevCount, membersLabel: prevLabel, canJoin: prevCanJoin);

    try {
      final req = GroupJoinRequest(cityId: groupData?.location?.id ?? 0, groupId: groupId);

      final result = await groupRepositoryImpl.joinGroup(req, isLeave);

      result.fold(
        (failure) {
          debugPrint('joinGroup failed: $failure');
          rollback();
          Get.snackbar('Error', isLeave ? 'Could not leave group' : 'Could not join group');
        },
        (response) {
          if (response.success == true) {
            joinLeaveData = response.data;
            _updateFeaturedGroup(
              groupId,
              isJoined: response.data?.isJoined ?? !isLeave,
              membersCount: response.data?.membersCount,
              membersLabel: response.data?.membersLabel,
              canJoin: response.data?.canJoin,
            );
          } else {
            rollback();
          }
        },
      );
    } catch (e) {
      debugPrint('joinGroup exception: $e');
      rollback();
    } finally {
      processingGroupIds.remove(groupId);
      update([ControllerBuilders.groupFeatured]);
    }
  }

  dynamic _findFeatured(int groupId) {
    final items = groupSectionData?.featuredGroups?.items ?? [];
    return items.firstWhereOrNull((item) => groupIdOf(item) == groupId);
  }

  void _updateFeaturedGroup(int groupId, {bool? isJoined, int? membersCount, String? membersLabel, bool? canJoin}) {
    final item = _findFeatured(groupId);
    if (item == null) return;
    item.isJoined = isJoined ?? item.isJoined;
    item.membersCount = membersCount ?? item.membersCount;
    item.membersLabel = membersLabel ?? item.membersLabel;
    item.canJoin = canJoin ?? item.canJoin;
  }

  String _membersLabel(int count) => '$count ${count == 1 ? 'member' : 'members'}';

  MyGroupSummaryData? mySummary;
  MyGroupAttentionData? myAttention;
  List<MyActivityItem>? myActivities;
  bool? groupRecommendations;
  int myGroupTab = 0;
  int myGroupsTab = 0;
  // sections the user tapped: request cards start closed, their inner sections start open
  final Set<String> toggledSections = {};
  bool myGroupsLoading = false;
  bool myAttentionLoading = false;
  bool myActivitiesLoading = false;
  bool savingSettings = false;
  bool _settingsDirty = false;
  int _settingsSaves = 0;

  // cached per segment (managed, joined); null means never fetched. Invitations (tab 2) have their own shape.
  final List<List<MyGroupItem>?> _myGroupLists = [null, null];
  final List<int> _myGroupPages = [1, 1];
  final List<int> _myGroupLastPages = [1, 1];
  final List<int> _myGroupRequests = [0, 0];
  final List<bool> myGroupLoadingMore = [false, false];
  List<InvitationItem>? myInvitations;
  bool _invitationsLoading = false;
  final Set<int> respondingInvitations = {};

  static const _myGroupUrls = [Apis.myManagedGroups, Apis.myMemberships];

  List<MyGroupItem>? get myGroupItems => myGroupTab < 2 ? _myGroupLists[myGroupTab] : null;

  // only group join requests have UI yet, shown per group on the managed group cards
  // shortcut: only the first attention page is fetched, page through getMyAttention if a manager can have more pending items than one page holds.
  List<AttentionItem> joinRequestsFor(int? groupId) => (myAttention?.items ?? []).where((i) => i.type == 'membership' && i.groupId == groupId).toList();

  // the loaded list is fresher than the summary, which can lag behind new invites or a just-answered one
  int get myInvitesCount => myInvitations?.length ?? mySummary?.stats?.pendingInvitations ?? 0;

  /// My Groups tab row: tab 2 ("My Profile") opens the profile page instead of switching tabs.
  void openMyGroupsTab(int index) {
    if (index != 2) return selectMyGroupsTab(index);
    if (myActivities?.firstOrNull == null) return;
    openGroupProfile();
  }

  // Navigation: Groups pages open each other through these, never with Get.toNamed in the UI.
  void openInterest(String slug) {
    Get.toNamed(AppRoutes.groupDetail);
    getInterestDetail(slug);
  }

  void openActivity(int? activityId, {int? cityId}) {
    Get.toNamed(AppRoutes.activityDetail);
    getActivityDetail(activityId ?? 0, cityId: cityId);
  }

  void openMyActivity(MyActivityItem activity) => openActivity(activity.activityId, cityId: activity.cityId);

  // Groups home activities belong to the city the page is showing
  void openGroupsHomeActivity(ActivitiesItem? activity) => openActivity(activity?.activityId, cityId: groupData?.location?.id);

  void openGroupActivity(Activity activity) => openActivity(activity.activityId, cityId: activity.cityId ?? groupDetailData?.group?.cityId);

  void openGroup(int groupId) {
    Get.toNamed(AppRoutes.detailPage);
    getGroupDetail('$groupId', 'overview');
  }

  /// Featured groups that don't exist yet open from their template, in the city the page is showing.
  void openFeaturedGroup(FeaturedGroupsItem? featured) {
    Get.toNamed(AppRoutes.detailPage);
    final groupId = featured?.groupId;
    getGroupDetail(groupId != null ? '$groupId' : 'template-${featured?.templateId}', 'overview', cityId: groupId == null ? groupData?.location?.id : null);
  }

  /// Discover cards: like featured groups, a template-only item opens from its template in its city.
  void openDiscoverGroup(discover.Item g) {
    Get.toNamed(AppRoutes.detailPage);
    final groupId = g.groupId;
    getGroupDetail(groupId != null ? '$groupId' : 'template-${g.templateId}', 'overview', cityId: groupId == null ? (g.cityId ?? discoverTownId) : null);
  }

  void openCreateGroup() => Get.toNamed(AppRoutes.createGroup);

  void openMyGroups() => Get.toNamed(AppRoutes.myGroup);

  void openGroupProfile() => Get.toNamed(AppRoutes.groupUserProfile);

  /// Groups drawer navigation from the page at [from]. Returns false when [route] is that same page
  /// (only the My Groups tab changes), so the drawer knows to close right away.
  bool openGroupsPage(String route, {String? from, int? myGroupsTab}) {
    if (route == from) {
      if (myGroupsTab != null) selectMyGroupsTab(myGroupsTab);
      return false;
    }
    if (route == AppRoutes.createGroup) {
      // a form you come back from, so it opens on top of the current page
      Get.toNamed(route);
      return true;
    }
    // back to Groups first, then open the target: the stack never grows, and Groups (which owns this controller) stays alive
    Get.until((r) => r.settings.name == AppRoutes.groups || r.isFirst);
    if (Get.currentRoute != route) Get.toNamed(route);
    return true;
  }

  // My Groups header carousel; the background follows the centered image
  static const myGroupsHeroImages = [
    'https://wikixm-staging.s3.us-west-2.amazonaws.com/images/groups/hero-community-garden.webp',
    'https://wikixm-staging.s3.us-west-2.amazonaws.com/images/groups/cover-chess.webp',
    'https://wikixm-staging.s3.us-west-2.amazonaws.com/images/groups/hero-trail-ride.webp',
  ];
  int myGroupsHeroIndex = 0;

  void changeMyGroupsHero(int index) {
    myGroupsHeroIndex = index;
    update([ControllerBuilders.myGroupsHero]);
  }

  // Activity profile (GroupUserProfile)
  ActivityProfileData? activityProfile;
  bool activityProfileLoading = false;
  int selectedProfileInterest = 0;
  String? selectedProfilePrivacy;

  // Redraws are split so a tap only rebuilds what it changes:
  // groupProfilePage = shimmer <-> page (load only), groupProfileSections = header + cards (interest), groupProfilePrivacy = privacy card.
  Future<void> getActivityProfile() async {
    if (activityProfileLoading) return;
    activityProfileLoading = true;
    // a revisit keeps showing the cached profile while it refreshes, so only the first load needs the shimmer
    if (activityProfile == null) update([ControllerBuilders.groupProfilePage]);
    final data = await groupRepositoryImpl.activityProfile();
    data.fold((l) => debugPrint('getActivityProfile failed: $l'), (r) {
      if (r.success == true) {
        activityProfile = r.data;
        // keep the user's chip on a refresh unless that interest is gone
        if (selectedProfileInterest >= profileActivities.length) selectedProfileInterest = 0;
        selectedProfilePrivacy = r.data?.privacy?.visibility;
      }
    });
    activityProfileLoading = false;
    update([ControllerBuilders.groupProfilePage]);
  }

  List<ProfileActivity> get profileActivities => activityProfile?.activities ?? [];

  ProfileActivity? get selectedProfileActivity => profileActivities.elementAtOrNull(selectedProfileInterest);

  List<ProfileSummary> get profileSkillSummaries => selectedProfileActivity?.sections?.skills?.summaries ?? [];

  // meters and badges show as labelled rows; numbers (years, distance, pace...) as tiles
  bool _isSkillRow(ProfileSummary s) => s.kind == 'meter' || s.kind == 'badge';

  List<ProfileSummary> get profileSkillRows => profileSkillSummaries.where(_isSkillRow).toList();

  List<ProfileSummary> get profileSkillTiles => profileSkillSummaries.where((s) => !_isSkillRow(s)).toList();

  List<ProfileSummary> get profilePreferenceSummaries => selectedProfileActivity?.sections?.preferences?.summaries ?? [];

  /// The edit form behind a section; its intro and details heading are shown on the cards.
  SectionSchema? profileSchema(ProfileSection? section) => activityProfile?.sectionSchemas?[section?.schemaId];

  /// Section titles come from the API's tabs, so they match the website.
  String profileTabLabel(String id, String fallback) => activityProfile?.tabs?.firstWhereOrNull((t) => t.id == id)?.label ?? fallback;

  /// An interest's overall skill, e.g. "Beginner", for the Activity Interests grid.
  String profileSkillText(ProfileActivity activity) => activity.sections?.skills?.summaries?.firstWhereOrNull((s) => s.name == 'skill_level')?.text ?? 'Not specified';

  /// 0–1 fill for "meter" summaries; empty when the user hasn't rated it.
  double summaryProgress(ProfileSummary summary) {
    final value = summary.value, max = summary.max;
    if (value == null || max == null || max <= 0) return 0;
    return (value / max).clamp(0, 1).toDouble();
  }

  /// "list" summaries carry the picked options in [ProfileSummary.items]; everything else is ready in text.
  String summaryText(ProfileSummary summary) => (summary.items ?? []).isNotEmpty ? summary.items!.join(', ') : summary.text ?? 'Not specified';

  // Header: "YOUR ACTIVITY STORY, ALWIN" over the selected interest's image
  String get profileFirstName => (activityProfile?.user?.name ?? '').trim().split(' ').first;

  String? get profileHeroImage => selectedProfileActivity?.image?.url;

  /// (count, label) for the header stats: groups, activities organized, activity interests.
  List<(String, String)> get profileHeroStats {
    final groups = activityProfile?.community?.total ?? activityProfile?.community?.items?.length ?? 0;
    final organized = activityProfile?.stats?.organizedActivities ?? 0;
    final interests = profileActivities.length;
    return [
      ('$groups', groups == 1 ? 'group' : 'groups'),
      ('$organized', organized == 1 ? 'activity organized' : 'activities organized'),
      ('$interests', interests == 1 ? 'activity interest' : 'activity interests'),
    ];
  }

  bool get canEditProfile => activityProfile?.canEdit == true;

  // the API only sends labels, so the one-line explanations live here
  String profilePrivacyHint(String? value) => switch (value) {
    'everyone' => 'Visible to all users on WikiXM.',
    'members' => 'Visible only to signed-in members.',
    'onlyme' => 'Only you can see your activity profile.',
    _ => '',
  };

  String get profilePrivacyLabel => activityProfile?.privacy?.options?.firstWhereOrNull((o) => o.value == selectedProfilePrivacy)?.label ?? '';

  void selectProfileInterest(int index) {
    if (index == selectedProfileInterest) return;
    selectedProfileInterest = index;
    update([ControllerBuilders.groupProfileSections]);
  }

  // shortcut: only changes the selection on screen; send it to the API once there's a save-privacy endpoint.
  void selectProfilePrivacy(String? value) {
    if (value == selectedProfilePrivacy) return;
    selectedProfilePrivacy = value;
    update([ControllerBuilders.groupProfilePrivacy]);
  }

  Future<void> getMyGroups() async {
    myGroupsLoading = true;
    myGroupTab = 0;
    myGroupsTab = 0;
    update([ControllerBuilders.myGroups]);
    // everything starts together; the page waits only for what's above the fold
    getMyGroupList(1);
    getMyInvitations();
    getMyAttention();
    getMyActivities();
    getMySettings();
    await Future.wait([getMySummary(), getMyGroupList(0)]);
    myGroupsLoading = false;
    update([ControllerBuilders.myGroups]);
  }

  Future<void> getMySummary() async {
    final data = await groupRepositoryImpl.myGroupSummary();
    data.fold((l) => debugPrint('getMySummary failed: $l'), (r) {
      if (r.success == true) mySummary = r.data;
    });
  }

  void selectMyGroupsTab(int tab) {
    if (tab == myGroupsTab) return;
    myGroupsTab = tab;
    update([ControllerBuilders.myGroupsTabs]);
    switch (tab) {
      case 0:
        refreshMyGroupList(myGroupTab);
        getMyAttention();
      case 1:
        getMyActivities();
      case 3:
        getMySettings();
    }
  }

  void toggleSection(String key) {
    if (!toggledSections.remove(key)) toggledSections.add(key);
    update([ControllerBuilders.myGroupsRequests]);
  }

  void changeMyGroupTab(int tab) {
    if (tab == myGroupTab) return;
    myGroupTab = tab;
    update([ControllerBuilders.myGroupsList]);
    refreshMyGroupList(tab);
  }

  void refreshMyGroupList(int tab) {
    if (tab == 2) {
      getMyInvitations();
      return;
    }
    // a page-1 refresh would drop the extra pages the user scrolled into
    if (_myGroupPages[tab] > 1 || myGroupLoadingMore[tab]) return;
    getMyGroupList(tab);
  }

  Future<void> getMyGroupList(int tab, {int page = 1}) async {
    final requestId = ++_myGroupRequests[tab];
    if (page > 1) {
      myGroupLoadingMore[tab] = true;
      update([ControllerBuilders.myGroupsList]);
    }
    final data = await groupRepositoryImpl.myGroupList(_myGroupUrls[tab], {'page': page, 'per_page': 12});
    // cleared before the stale check, or a dropped page-2 response leaves load-more blocked
    if (page > 1) myGroupLoadingMore[tab] = false;
    if (requestId != _myGroupRequests[tab]) return;
    data.fold((l) => debugPrint('getMyGroupList failed: $l'), (r) {
      if (r.success == true) {
        final items = r.data?.items ?? [];
        _myGroupLists[tab] = page == 1 ? items : [...?_myGroupLists[tab], ...items];
        _myGroupPages[tab] = r.data?.pagination?.currentPage ?? page;
        _myGroupLastPages[tab] = r.data?.pagination?.lastPage ?? page;
      }
    });
    // a failed first fetch still counts as fetched, so the tab shows its empty state instead of a shimmer forever
    _myGroupLists[tab] ??= [];
    update([ControllerBuilders.myGroupsList]);
  }

  void loadMoreMyGroups() {
    final tab = myGroupTab;
    if (tab == 2) return;
    if (myGroupLoadingMore[tab] || _myGroupLists[tab] == null || _myGroupPages[tab] >= _myGroupLastPages[tab]) return;
    getMyGroupList(tab, page: _myGroupPages[tab] + 1);
  }

  Future<void> getMyAttention() async {
    if (myAttentionLoading) return;
    myAttentionLoading = true;
    final data = await groupRepositoryImpl.myGroupAttention(1);
    data.fold((l) => debugPrint('getMyAttention failed: $l'), (r) {
      if (r.success == true) myAttention = r.data;
    });
    myAttentionLoading = false;
    update([ControllerBuilders.myGroupsRequests, ControllerBuilders.myGroupsList]);
  }

  // shortcut: first page only, add load-more like getMyGroupList if people have more than 12 upcoming activities.
  Future<void> getMyActivities() async {
    if (myActivitiesLoading) return;
    myActivitiesLoading = true;
    final data = await groupRepositoryImpl.myGroupActivities(1);
    data.fold((l) => debugPrint('getMyActivities failed: $l'), (r) {
      if (r.success == true) myActivities = r.items;
    });
    myActivitiesLoading = false;
    update([ControllerBuilders.myGroupsActivities]);
  }

  Future<void> getMySettings() async {
    final savesBefore = _settingsSaves;
    final data = await groupRepositoryImpl.getMyGroupSettings();
    data.fold((l) => debugPrint('getMySettings failed: $l'), (r) {
      // don't overwrite an unsaved choice, or a save that finished while this was in flight
      if (r.success == true && !_settingsDirty && savesBefore == _settingsSaves) groupRecommendations = r.recommendations;
    });
    update([ControllerBuilders.myGroupsSettings]);
  }

  void toggleRecommendations() {
    groupRecommendations = !(groupRecommendations ?? false);
    _settingsDirty = true;
    update([ControllerBuilders.myGroupsSettings]);
  }

  Future<void> saveMySettings() async {
    if (savingSettings || groupRecommendations == null) return;
    savingSettings = true;
    update([ControllerBuilders.myGroupsSettings]);
    final data = await groupRepositoryImpl.saveMyGroupSettings(groupRecommendations!);
    data.fold((l) => debugPrint('saveMySettings failed: $l'), (r) {
      if (r.success == true) {
        _settingsSaves++;
        _settingsDirty = false;
        groupRecommendations = r.recommendations ?? groupRecommendations;
      }
    });
    savingSettings = false;
    update([ControllerBuilders.myGroupsSettings]);
  }

  Future<void> getMyInvitations() async {
    if (_invitationsLoading) return;
    _invitationsLoading = true;
    final data = await groupRepositoryImpl.myGroupInvitations();
    data.fold((l) => debugPrint('getMyInvitations failed: $l'), (r) {
      if (r.success == true) myInvitations = r.items;
    });
    myInvitations ??= [];
    _invitationsLoading = false;
    update([ControllerBuilders.myGroupsList]);
  }

  Future<void> respondInvitation(InvitationItem item, bool accepted) async {
    final id = item.invitationId;
    if (id == null || !respondingInvitations.add(id)) return;
    update([ControllerBuilders.myGroupsList]);
    final data = await groupRepositoryImpl.respondInvitation(id, accepted);
    final ok = data.fold((l) {
      debugPrint('respondInvitation failed: $l');
      return false;
    }, (r) => r);
    respondingInvitations.remove(id);
    if (ok) {
      myInvitations = myInvitations?.where((i) => i.invitationId != id).toList();
      getMySummary().then((_) => update([ControllerBuilders.myGroupsList]));
      if (accepted) getMyGroupList(1);
    }
    update([ControllerBuilders.myGroupsList]);
  }

  final TextEditingController discoverSearchController = TextEditingController();
  String discoverCategory = 'all';
  final Set<String> savedDiscoverGroups = {};
  discover_overview.SearchGroupOverviewData? discoverOverview;
  bool discoverOverviewLoading = false;
  // filter drawer; null distance / {'all'} sets mean "not filtered", until the overview's default_filters arrive
  String? discoverDistance;
  Set<String> discoverTypes = {'all'};
  Set<String> discoverLevels = {'all'};
  // null until the first page arrives, so the grid shows a shimmer instead of "no groups"
  List<discover.Item>? discoverItems;
  bool discoverLoadingMore = false;
  int _discoverPage = 1;
  int _discoverLastPage = 1;
  int _discoverRequest = 0;
  Timer? _discoverDebounce;
  // filters the shown list was fetched with; a debounced fetch for the same filters is skipped
  String? _discoverLoadedKey;
  // join/request results by group id, layered over the list item's own flags
  final Map<int, discover.Item> _discoverJoinState = {};

  @override
  void onClose() {
    _discoverDebounce?.cancel();
    blockNameController.dispose();
    super.onClose();
  }

  int get discoverTownId => groupData?.location?.id ?? 46820;

  void loadDiscover() {
    if (discoverOverview == null) getDiscoverOverview();
    getDiscoverGroups();
  }

  Future<void> getDiscoverOverview() async {
    discoverOverviewLoading = true;
    final data = await groupRepositoryImpl.discoverOverview(discoverTownId);
    data.fold((l) => debugPrint('getDiscoverOverview failed: $l'), (r) {
      if (r.success == true) {
        discoverOverview = r.data;
        _resetDiscoverFilterDefaults();
      }
    });
    discoverOverviewLoading = false;
    update([ControllerBuilders.discoverGroups, ControllerBuilders.discoverGroupsList, ControllerBuilders.discoverFilters]);
  }

  Future<void> getDiscoverGroups({int page = 1}) async {
    final requestId = ++_discoverRequest;
    if (page > 1) {
      discoverLoadingMore = true;
      update([ControllerBuilders.discoverGroupsList]);
    }
    final q = discoverSearchController.text.trim();
    final key = _discoverKey;
    final data = await groupRepositoryImpl.discoverGroups({
      'city_id': discoverTownId,
      'discovery': 1,
      'page': page,
      'per_page': 12,
      if (q.isNotEmpty) 'search': q,
      if (discoverCategory != 'all') 'category': discoverCategory,
      'distance': ?discoverDistance,
      if (!discoverTypes.contains('all')) 'type[]': discoverTypes.toList(),
      if (!discoverLevels.contains('all')) 'level[]': discoverLevels.toList(),
    });
    if (page > 1) discoverLoadingMore = false;
    if (requestId != _discoverRequest) return;
    data.fold((l) => debugPrint('getDiscoverGroups failed: $l'), (r) {
      if (r.success == true) {
        final items = r.data?.items ?? [];
        discoverItems = page == 1 ? items : [...?discoverItems, ...items];
        _discoverLoadedKey = key;
        _discoverPage = r.data?.pagination?.currentPage ?? page;
        _discoverLastPage = r.data?.pagination?.lastPage ?? page;
      }
    });
    discoverItems ??= [];
    update([ControllerBuilders.discoverGroupsList]);
  }

  void loadMoreDiscoverGroups() {
    if (discoverLoadingMore || discoverItems == null || _discoverPage >= _discoverLastPage) return;
    getDiscoverGroups(page: _discoverPage + 1);
  }

  String get _discoverKey => '$discoverCategory|$discoverDistance|${discoverTypes.toList()..sort()}|${discoverLevels.toList()..sort()}|${discoverSearchController.text.trim().toLowerCase()}';

  // every filter change goes through here: rapid chip taps or typing cancel the pending call, so only the last one hits the API.
  // When it fires, filters back where the shown list already is (All -> Tech -> All, "ab" -> "a") make no call at all.
  void _scheduleDiscoverFetch([Duration delay = const Duration(milliseconds: 300)]) {
    _discoverDebounce?.cancel();
    _discoverDebounce = Timer(delay, () {
      if (_discoverKey == _discoverLoadedKey && discoverItems != null) return;
      // shimmer so old results don't sit under a new category or search
      discoverItems = null;
      update([ControllerBuilders.discoverGroupsList]);
      getDiscoverGroups();
    });
  }

  void selectDiscoverCategory(String key) {
    if (key == discoverCategory) return;
    discoverCategory = key;
    update([ControllerBuilders.discoverGroupsList]);
    _scheduleDiscoverFetch();
  }

  // longer wait than chips: one request once typing pauses, not one per keystroke
  void searchDiscoverGroups(String _) {
    update([ControllerBuilders.discoverGroupsList]);
    _scheduleDiscoverFetch(const Duration(milliseconds: 500));
  }

  void clearDiscoverSearch() {
    discoverSearchController.clear();
    update([ControllerBuilders.discoverGroupsList]);
    _scheduleDiscoverFetch();
  }

  void clearDiscoverFilters() {
    discoverSearchController.clear();
    _resetDiscoverFilterDefaults();
    update([ControllerBuilders.discoverGroupsList, ControllerBuilders.discoverFilters]);
    _scheduleDiscoverFetch();
  }

  void _resetDiscoverFilterDefaults() {
    final defaults = discoverOverview?.defaultFilters;
    discoverCategory = defaults?.category ?? 'all';
    discoverDistance = defaults?.distance;
    discoverTypes = {...?defaults?.type};
    discoverLevels = {...?defaults?.level};
    if (discoverTypes.isEmpty) discoverTypes = {'all'};
    if (discoverLevels.isEmpty) discoverLevels = {'all'};
  }

  // shows a dot on the filter button when the drawer narrows the list beyond its defaults
  bool get discoverFiltersActive {
    final defaults = discoverOverview?.defaultFilters;
    return discoverDistance != defaults?.distance || !discoverTypes.contains('all') || !discoverLevels.contains('all') || discoverCategory != (defaults?.category ?? 'all');
  }

  // drawer edits only change the selection; the list refetches on Apply
  void setDiscoverDistance(String value) {
    discoverDistance = value;
    update([ControllerBuilders.discoverFilters]);
  }

  void setDiscoverFilterCategory(String value) {
    discoverCategory = value;
    update([ControllerBuilders.discoverFilters, ControllerBuilders.discoverGroupsList]);
  }

  void toggleDiscoverType(String value) {
    discoverTypes = _toggleWithAll(discoverTypes, value);
    update([ControllerBuilders.discoverFilters]);
  }

  void toggleDiscoverLevel(String value) {
    discoverLevels = _toggleWithAll(discoverLevels, value);
    update([ControllerBuilders.discoverFilters]);
  }

  // "all" is exclusive: picking it clears the rest, picking anything else drops it, and unticking the last one falls back to it
  Set<String> _toggleWithAll(Set<String> current, String value) {
    if (value == 'all') return {'all'};
    final next = {...current}..remove('all');
    if (!next.remove(value)) next.add(value);
    return next.isEmpty ? {'all'} : next;
  }

  void applyDiscoverFilters() {
    update([ControllerBuilders.discoverGroupsList]);
    _scheduleDiscoverFetch(Duration.zero);
  }

  void toggleSaveDiscoverGroup(String id) {
    savedDiscoverGroups.contains(id) ? savedDiscoverGroups.remove(id) : savedDiscoverGroups.add(id);
    update([ControllerBuilders.discoverGroupsList]);
  }

  bool discoverJoined(discover.Item g) => _discoverJoinState[g.groupId]?.isJoined ?? g.isJoined ?? false;
  bool discoverRequested(discover.Item g) => _discoverJoinState[g.groupId]?.isRequested ?? g.isRequested ?? false;
  String discoverMembers(discover.Item g) => _discoverJoinState[g.groupId]?.membersLabel ?? g.membersLabel ?? '';

  String discoverActionLabel(discover.Item g) {
    if (g.isOwner == true) return 'Group owner';
    if (processingGroupIds.contains(g.groupId)) return 'Please wait…';
    if (discoverJoined(g)) return 'Joined';
    if (discoverRequested(g)) return 'Requested';
    return g.requiresApproval == true ? 'Request to join' : 'Join group';
  }

  Future<void> tapDiscoverAction(discover.Item g) async {
    final groupId = g.groupId ?? 0;
    final isLeave = discoverJoined(g);
    // a pending request has no cancel endpoint, and a group that can't be joined/left has nothing to do
    if (groupId == 0 || g.isOwner == true || processingGroupIds.contains(groupId) || discoverRequested(g) || (isLeave ? g.canLeave == false : g.canJoin == false)) return;
    processingGroupIds.add(groupId);
    update([ControllerBuilders.discoverGroupsList]);
    final result = await groupRepositoryImpl.joinGroup(GroupJoinRequest(cityId: g.cityId ?? discoverTownId, groupId: groupId), isLeave);
    result.fold(
      (l) {
        debugPrint('tapDiscoverAction failed: $l');
        Get.snackbar('Error', isLeave ? 'Could not leave group' : 'Could not join group');
      },
      (r) {
        if (r.success != true) return;
        final joined = r.data?.isJoined ?? !isLeave;
        _discoverJoinState[groupId] = discover.Item(
          isJoined: joined,
          // approval groups don't join straight away: a successful join call on them is a pending request
          isRequested: !isLeave && !joined && g.requiresApproval == true,
          membersLabel: r.data?.membersLabel ?? discoverMembers(g),
        );
      },
    );
    processingGroupIds.remove(groupId);
    update([ControllerBuilders.discoverGroupsList]);
  }

  // Public profile (PublicProfile). shortcut: always member 877, like activityProfile; pass the member's id once the page is opened from a profile link
  static const publicProfileId = 877;
  pp.ProfileData? publicProfile;
  ProfileFeedData? publicProfileFeed;
  bool publicProfileLoading = false;

  Future<void> getPublicProfile([int id = publicProfileId]) async {
    if (publicProfileLoading) return;
    publicProfileLoading = true;
    // a revisit keeps showing the cached profile while it refreshes, so only the first load needs the shimmer
    if (publicProfile == null) update([ControllerBuilders.publicProfile]);
    final profileCall = groupRepositoryImpl.publicProfile(id);
    final feedCall = groupRepositoryImpl.publicProfileFeed(id);
    (await profileCall).fold((l) => debugPrint('getPublicProfile failed: $l'), (r) {
      if (r.success == true) {
        publicProfile = r.data;
        publicProfileTabItems.clear();
        _publicProfileTabPage.clear();
        _publicProfileTabMore.clear();
        final defaultTab = r.data?.ui?.defaultTab;
        publicProfileTab = defaultTab == null || _hiddenProfileTabs.contains(defaultTab) ? 'overview' : defaultTab;
      }
    });
    (await feedCall).fold((l) => debugPrint('getPublicProfileFeed failed: $l'), (r) {
      if (r.success == true) publicProfileFeed = r.data;
    });
    publicProfileLoading = false;
    update([ControllerBuilders.publicProfile]);
  }

  // the API also sends Interests and Community Involvement tabs; the app doesn't show those
  static const _hiddenProfileTabs = {'interests', 'involvement'};
  List<pp.Action> get publicProfileTabs => [
    for (final t in publicProfile?.ui?.tabs ?? <pp.Action>[])
      if (t.hide != true && !_hiddenProfileTabs.contains(t.id)) t,
  ];
  pp.Action? get publicProfileFollowAction => publicProfile?.ui?.actions?.firstWhereOrNull((a) => a.id == 'follow');

  // selected tab id; 'overview' shows the profile sections, any other tab lists its /items pages
  String publicProfileTab = 'overview';
  final Map<String, List<Object>> publicProfileTabItems = {};
  final Map<String, int> _publicProfileTabPage = {};
  final Set<String> _publicProfileTabMore = {};
  bool publicProfileTabLoading = false;

  bool get publicProfileTabHasMore => _publicProfileTabMore.contains(publicProfileTab);
  bool isFollowingProfile = false;
  // shortcut: like/join/follow on the public profile are local only; no endpoint for them yet
  final Set<String> likedProfileActivities = {};
  final Set<String> joinedProfileActivities = {};

  void selectPublicProfileTab(String id) {
    publicProfileTab = id;
    update([ControllerBuilders.publicProfile]);
    if (id != 'overview' && !publicProfileTabItems.containsKey(id)) loadPublicProfileTabItems();
  }

  /// Next page of the selected tab's items (the first page when it hasn't loaded yet).
  Future<void> loadPublicProfileTabItems() async {
    final tab = publicProfileTab;
    if (publicProfileTabLoading) return;
    publicProfileTabLoading = true;
    update([ControllerBuilders.publicProfile]);
    final page = (_publicProfileTabPage[tab] ?? 0) + 1;
    final data = await groupRepositoryImpl.publicProfileItems(publicProfile?.id ?? publicProfileId, tab, page);
    data.fold((l) => debugPrint('loadPublicProfileTabItems failed: $l'), (r) {
      if (r.success != true || r.data == null) return;
      publicProfileTabItems.update(tab, (items) => [...items, ...r.data!.items], ifAbsent: () => r.data!.items);
      _publicProfileTabPage[tab] = page;
      r.data!.hasMore ? _publicProfileTabMore.add(tab) : _publicProfileTabMore.remove(tab);
    });
    publicProfileTabLoading = false;
    update([ControllerBuilders.publicProfile]);
  }

  void toggleFollowProfile() {
    isFollowingProfile = !isFollowingProfile;
    update([ControllerBuilders.publicProfile]);
  }

  void toggleLikeProfileActivity(String id) {
    likedProfileActivities.contains(id) ? likedProfileActivities.remove(id) : likedProfileActivities.add(id);
    update([ControllerBuilders.publicProfile]);
  }

  void toggleJoinProfileActivity(String id) {
    joinedProfileActivities.contains(id) ? joinedProfileActivities.remove(id) : joinedProfileActivities.add(id);
    update([ControllerBuilders.publicProfile]);
  }

  // Group settings. shortcut: mock data kept in memory, no settings endpoint yet; persist through the API when one exists
  final List<Map<String, dynamic>> settingsGroups = [
    {'name': 'All groups', 'icon': Icons.tune_rounded, 'color': 0xFF075DC9},
    {'name': 'Ski Enthusiasts', 'icon': Icons.landscape_outlined, 'color': 0xFF2563EB},
    {'name': 'Golf Group', 'icon': Icons.flag_outlined, 'color': 0xFF1E6B55},
    {'name': 'Pine Valley MTB', 'icon': Icons.pedal_bike_rounded, 'color': 0xFFB4501F, 'admin': true},
  ];
  static const _defaultReach = {'Event reminders': true, 'New discussions': true, 'Weekly digest': false};
  final List<Map<String, String>> settingsReach = [
    {'title': 'Event reminders', 'subtitle': 'The day before and an hour before'},
    {'title': 'New discussions', 'subtitle': 'When someone starts a thread'},
    {'title': 'Weekly digest', 'subtitle': 'One email every Sunday morning'},
  ];
  // each row opens GroupSettingsPage on its 'page'
  final List<Map<String, dynamic>> settingsRows = [
    {'title': 'Notifications', 'value': '', 'icon': CupertinoIcons.bell, 'page': 'notifications'},
    {'title': 'Privacy and visibility', 'value': '', 'icon': CupertinoIcons.eye, 'page': 'privacy'},
    {'title': 'Activity interests', 'value': '', 'icon': CupertinoIcons.calendar, 'page': 'interests'},
    {'title': 'Content', 'value': '', 'icon': CupertinoIcons.doc_text, 'page': 'content'},
    {'title': 'Recommendations', 'value': '', 'icon': CupertinoIcons.sparkles, 'page': 'recommendations'},
    {'title': 'Blocked members', 'value': '', 'icon': Icons.block_rounded, 'page': 'blocked'},
  ];
  int settingsGroupIndex = 0;
  // per-group overrides; a group without an entry uses the All groups defaults
  final Map<int, Map<String, bool>> settingsReachByGroup = {0: Map.of(_defaultReach)};

  Map<String, bool> get currentReach => settingsReachByGroup[settingsGroupIndex] ?? settingsReachByGroup[0]!;

  void selectSettingsGroup(int index) {
    settingsGroupIndex = index;
    update([ControllerBuilders.groupSettings]);
  }

  void toggleSettingsReach(String title) {
    final reach = settingsReachByGroup.putIfAbsent(settingsGroupIndex, () => Map.of(currentReach));
    reach[title] = !(reach[title] ?? false);
    update([ControllerBuilders.groupSettings]);
  }

  void restoreDefaultSettings() {
    settingsReachByGroup
      ..clear()
      ..[0] = Map.of(_defaultReach);
    update([ControllerBuilders.groupSettings]);
  }

  // Settings sub-pages (GroupSettingsPage): title, subtitle and the prefs each one's restore button resets
  final Map<String, Map<String, dynamic>> settingsPages = {
    'interests': {
      'title': 'Activity interests',
      'subtitle': 'Tell us what you love doing so we can show you more of it.',
      'keys': ['interests', 'skill'],
    },
    'content': {
      'title': 'Content',
      'subtitle': 'Shape the posts, photos and conversations in your feed.',
      'keys': ['feed', 'order', 'hideSensitive'],
    },
    'notifications': {
      'title': 'Notifications',
      'subtitle': 'Keep the updates that matter. Turn down the rest.',
      'keys': ['notify'],
    },
    'privacy': {
      'title': 'Privacy and visibility',
      'subtitle': 'Choose what other members can see.',
      'keys': ['profile', 'joins', 'online', 'memberLists'],
    },
    'blocked': {
      'title': 'Blocked members',
      'subtitle': "People you block can't message you. Organizers can still review anything that's reported.",
      'keys': ['blocked'],
    },
    'recommendations': {
      'title': 'Recommendations',
      'subtitle': 'Decide what we suggest and what we use to suggest it.',
      'keys': ['suggest', 'learnHistory'],
    },
  };
  static const _settingsDefaults = <String, dynamic>{
    'interests': ['Skiing', 'Snowboarding', 'Golf', 'Mountain biking'],
    'skill': 3,
    'feed': ['Discussions', 'Activity posts', 'Photos and videos', 'Event announcements', 'Files and documents'],
    'order': 'Newest',
    'hideSensitive': true,
    'notify': ['New group posts', 'Announcements', 'Activity reminders', 'Activity invitations', 'Direct messages'],
    'profile': 'Members',
    'joins': 'Members',
    'online': 'Members',
    'memberLists': true,
    'blocked': ['Avery Brooks', 'Casey Morgan'],
    'suggest': ['Activities', 'Groups', 'People'],
    'learnHistory': true,
  };
  final Map<String, dynamic> settingsPrefs = {for (final e in _settingsDefaults.entries) e.key: e.value is List ? List<String>.of(e.value.cast<String>()) : e.value};

  final List<String> interestOptions = ['Skiing', 'Snowboarding', 'Hiking', 'Golf', 'Mountain biking', 'Social events', 'Training and coaching', 'Volunteering'];
  final List<String> skillLevels = ['All levels', 'Beginner', 'Intermediate', 'Advanced'];
  final List<String> skillDescriptions = [
    'Show me outings for every skill level',
    'New to it, or still learning the basics',
    'Comfortable at a steady pace on most terrain',
    'Long days, steep terrain and faster groups',
  ];
  final List<String> feedOptions = ['Discussions', 'Activity posts', 'Photos and videos', 'Event announcements', 'Files and documents', 'Gear for sale'];
  final List<String> orderOptions = ['Newest', 'Most active', 'Most liked'];
  final Map<String, List<Map<String, String>>> notifySections = {
    'From your groups': [
      {'title': 'New group posts', 'subtitle': 'New conversations in your groups'},
      {'title': 'Announcements', 'subtitle': 'Important updates from organizers'},
      {'title': 'Activity reminders', 'subtitle': 'Before an activity you joined starts'},
      {'title': 'Activity invitations', 'subtitle': 'Activities you may enjoy'},
    ],
    'Just for you': [
      {'title': 'Direct messages', 'subtitle': 'When someone messages you'},
      {'title': 'Weekly digest', 'subtitle': 'A roundup of your groups each week'},
    ],
  };
  final List<Map<String, String>> privacyQuestions = [
    {'key': 'profile', 'title': 'Who can see your profile', 'subtitle': 'Your bio, interests and photos'},
    {'key': 'joins', 'title': 'Who can see what you join', 'subtitle': 'Activities you’re going to or went to'},
    {'key': 'online', 'title': 'Who can see you’re online', 'subtitle': 'The green dot on your photo'},
  ];
  final List<String> privacyOptions = ['Everyone', 'Members', 'Only me'];
  final List<Map<String, String>> suggestOptions = [
    {'title': 'Activities', 'subtitle': 'Outings that match your interests'},
    {'title': 'Groups', 'subtitle': 'Groups you may want to join'},
    {'title': 'People', 'subtitle': 'Members who share your interests'},
    {'title': 'Something new', 'subtitle': 'Activities outside your usual interests'},
  ];
  final TextEditingController blockNameController = TextEditingController();
  final Map<String, String> blockedDates = {'Avery Brooks': 'Sep 12', 'Casey Morgan': 'Oct 3'};

  List<String> settingsList(String key) => settingsPrefs[key] as List<String>;

  int get notifyOnCount => settingsList('notify').length;

  int get notifyTotal => notifySections.values.fold(0, (sum, items) => sum + items.length);

  String settingsRowValue(Map<String, dynamic> row) => switch (row['page']) {
    'notifications' => '$notifyOnCount of $notifyTotal on',
    'privacy' => settingsPrefs['profile'] == 'Members' ? 'Members only' : settingsPrefs['profile'],
    'interests' => '${settingsList('interests').length} chosen',
    'recommendations' => settingsList('suggest').isEmpty ? 'Off' : 'On',
    'blocked' => settingsList('blocked').isEmpty ? 'None' : '${settingsList('blocked').length}',
    'content' => settingsList('feed').length == feedOptions.length ? 'Everything' : '${settingsList('feed').length} of ${feedOptions.length}',
    _ => row['value'],
  };

  void openSettingsPage(String page) => Get.toNamed(AppRoutes.groupSettingsPage, arguments: page);

  void setSettingsPref(String key, dynamic value) {
    settingsPrefs[key] = value;
    update([ControllerBuilders.groupSettings]);
  }

  void toggleSettingsItem(String key, String item) {
    final list = settingsList(key);
    list.contains(item) ? list.remove(item) : list.add(item);
    update([ControllerBuilders.groupSettings]);
  }

  void restoreSettingsPage(String page) {
    for (final key in settingsPages[page]!['keys'] as List<String>) {
      final value = _settingsDefaults[key];
      settingsPrefs[key] = value is List ? List<String>.of(value.cast<String>()) : value;
    }
    update([ControllerBuilders.groupSettings]);
  }

  /// shortcut: prefs already apply as they change and only live in memory; call the settings API here once one exists
  void saveSettingsPage() {
    Get.back();
    Get.snackbar('Saved', 'Your settings have been saved.', snackPosition: SnackPosition.BOTTOM);
  }

  void blockMember() {
    final name = blockNameController.text.trim();
    if (name.isEmpty || settingsList('blocked').contains(name)) return;
    settingsList('blocked').add(name);
    blockedDates[name] = DateFormat('MMM d').format(DateTime.now());
    blockNameController.clear();
    update([ControllerBuilders.groupSettings]);
  }

  void unblockMember(String name) {
    settingsList('blocked').remove(name);
    update([ControllerBuilders.groupSettings]);
  }
}

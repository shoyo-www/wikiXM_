import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wikixm/data/datasource/Repository_impl/group_repository_impl.dart';
import 'package:wikixm/data/datasource/remote/models/request/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_home.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_sections.dart';
import '../../constants/constants.dart';
import '../../data/datasource/remote/models/response/group_join.dart';
import '../../data/datasource/remote/models/response/interest_detail.dart';

class GroupController extends GetxController {
  bool isLoading = false;
  final GroupRepositoryImpl groupRepositoryImpl = GroupRepositoryImpl();
  GroupData? groupData;
  GroupSectionData? groupSectionData;
  JoinLeaveData? joinLeaveData;
  final Set<int> processingGroupIds = {};
  int currentStep = 0;
  InterestData? interestData;


  String selectedCover = 'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-crew.webp';

  final List<Map<String, String>> coverChoices = [
    {
      'file': 'cover-crew.webp',
      'name': 'Biking crew',
      'url':
      'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-crew.webp',
    },
    {
      'file': 'cover-town-ridgewood.webp',
      'name': 'Ridgewood',
      'url':
      'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-ridgewood.webp',
    },
    {
      'file': 'cover-town-mapleton.webp',
      'name': 'Mapleton',
      'url':
      'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-mapleton.webp',
    },
    {
      'file': 'cover-town-cedar-grove.webp',
      'name': 'Cedar Grove',
      'url':
      'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-cedar-grove.webp',
    },
    {
      'file': 'cover-town-highland.webp',
      'name': 'Highland',
      'url':
      'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-highland.webp',
    },
    {
      'file': 'cover-town-oak-creek.webp',
      'name': 'Oak Creek',
      'url':
      'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-oak-creek.webp',
    },
  ];

  final List<Map<String, String>> additionalPhotos = [
    {
      'file': 'cover-town-ridgewood.webp',
      'name': 'Ridgewood',
      'url':
      'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-ridgewood.webp',
    },
    {
      'file': 'cover-town-mapleton.webp',
      'name': 'Mapleton',
      'url':
      'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-mapleton.webp',
    },
    {
      'file': 'cover-town-cedar-grove.webp',
      'name': 'Cedar Grove',
      'url':
      'https://preetis-html.vercel.app/assets/images/groups/create-group/cover-town-cedar-grove.webp',
    },
  ];
  bool showAllNearbyTowns = false;

  Set<String> selectedTownIds = {
    'pine-valley',
    'ridgewood',
    'mapleton',
    'cedar-grove',
    'highland',
    'oak-creek',
    'timber-ridge',
    'aspen-springs',
  };

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

  final TextEditingController primaryTownController =
  TextEditingController(text: 'Issaquah');

  final TextEditingController customRadiusController =
  TextEditingController(text: '15');

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
    data.fold(
          (l) => debugPrint('getGroupHome failed: $l'),
          (r) {
        if (r.success == true) groupData = r.data;
      },
    );
  }

  // Interest discover state; tabs, categories, sorts and filters all come from the API.
  bool interestLoading = false;
  String interestSlug = '';
  String? interestTab;
  final TextEditingController interestSearchController = TextEditingController();
  String interestCategory = 'all';
  String? interestSort;
  Map<String, Set<String>> interestFilters = {};

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
    getInterestDetail(interestSlug);
  }

  void changeInterestCategory(String? category) {
    if (category == null || category == interestCategory) return;
    interestCategory = category;
    getInterestDetail(interestSlug);
  }

  void changeInterestSort(String? sort) {
    interestSort = sort;
    update([ControllerBuilders.interestDetailController]);
  }

  // Radio filters hold one value, checkbox filters many.
  void toggleInterestFilter(Filter filter, String value) {
    final name = filter.name ?? '';
    final selected = interestFilters[name] ?? {};
    if (filter.multiple == true) {
      if (!selected.remove(value)) selected.add(value);
      interestFilters[name] = selected;
    } else {
      interestFilters[name] = {value};
    }
    update([ControllerBuilders.interestDetailController]);
  }

  // Join state changed on the detail screen, keyed by groupId; overrides the (immutable) API item until the next fetch.
  final Map<int, bool> interestJoined = {};

  Future<void> toggleInterestGroup(int groupId, bool isLeave) async {
    if (groupId == 0 || processingGroupIds.contains(groupId)) return;
    processingGroupIds.add(groupId);
    update([ControllerBuilders.interestDetailController]);
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
    update([ControllerBuilders.interestDetailController]);
  }

  Future<void> getInterestDetail(String interest, {int page = 1}) async {
    if (interest != interestSlug) {
      interestSlug = interest;
      interestTab = null;
      interestData = null;
      resetInterestFilters();
    }
    interestLoading = true;
    update([ControllerBuilders.interestDetailController]);
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
    data.fold(
      (l) => debugPrint('getInterestDetail failed: $l'),
      (r) {
        if (r.success == true) {
          interestData = r.data;
          interestJoined.clear();
          interestTab = r.data?.discovery?.activeTab ?? interestTab;
          interestLoading = false;
          update([ControllerBuilders.interestDetailController]);
        }
      },
    );
    interestLoading = false;
    update([ControllerBuilders.interestDetailController]);
  }

  Future<void> getGroupSections() async {
    final data = await groupRepositoryImpl.getGroupSections();
    data.fold(
          (l) => debugPrint('getGroupSections failed: $l'),
          (r) {
        if (r.success == true) groupSectionData = r.data;
      },
    );
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
    _updateFeaturedGroup(
      groupId,
      isJoined: !isLeave,
      membersCount: newCount,
      membersLabel: newCount == null ? prevLabel : _membersLabel(newCount),
    );
    update([ControllerBuilders.groupController]);

    void rollback() => _updateFeaturedGroup(
      groupId,
      isJoined: prevIsJoined,
      membersCount: prevCount,
      membersLabel: prevLabel,
      canJoin: prevCanJoin,
    );

    try {
      final req = GroupJoinRequest(
        cityId: groupData?.location?.id ?? 0,
        groupId: groupId,
      );

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
      update([ControllerBuilders.groupController]);
    }
  }

  dynamic _findFeatured(int groupId) {
    final items = groupSectionData?.featuredGroups?.items ?? [];
    return items.firstWhereOrNull((item) => groupIdOf(item) == groupId);
  }

  void _updateFeaturedGroup(
      int groupId, {
        bool? isJoined,
        int? membersCount,
        String? membersLabel,
        bool? canJoin,
      }) {
    final item = _findFeatured(groupId);
    if (item == null) return;
    item.isJoined = isJoined ?? item.isJoined;
    item.membersCount = membersCount ?? item.membersCount;
    item.membersLabel = membersLabel ?? item.membersLabel;
    item.canJoin = canJoin ?? item.canJoin;
  }

  String _membersLabel(int count) => '$count ${count == 1 ? 'member' : 'members'}';
}
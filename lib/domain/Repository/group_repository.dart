import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/request/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_detail.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_sections.dart';
import 'package:wikixm/data/datasource/remote/models/response/interest_detail.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/activiyt_detail.dart';
import '../../data/datasource/remote/models/response/group_home.dart';
import '../../data/datasource/remote/models/response/my_group_summary.dart';
import '../../data/datasource/remote/models/response/my_group_list.dart';
import '../../data/datasource/remote/models/response/my_group_attention.dart';
import '../../data/datasource/remote/models/response/my_group_invitations.dart';
import '../../data/datasource/remote/models/response/my_group_activities.dart';
import '../../data/datasource/remote/models/response/my_group_settings.dart';
import '../../data/datasource/remote/models/response/activity_profile.dart';
import '../../data/datasource/remote/models/response/public_profile.dart';
import '../../data/datasource/remote/models/response/public_profile_feed.dart';
import '../../data/datasource/remote/models/response/public_profile_items.dart';
import '../../data/datasource/remote/models/response/search_group.dart';
import '../../data/datasource/remote/models/response/search_group_overview.dart';

abstract class GroupRepository {
  Future<Either<Failure, GroupHomeResponse>> getGroupHome();
  Future<Either<Failure, GroupSectionsResponse>> getGroupSections();
  Future<Either<Failure, GroupJoinResponse>> joinGroup(GroupJoinRequest req,bool isLeave);
  Future<Either<Failure, IntersetDetailResponse>> interestDetail(String interset , Map<String,dynamic> request);
  Future<Either<Failure, GroupDetailResponse>> groupDetail(String id , Map<String,dynamic> request);
  Future<Either<Failure, GroupActivityResponse>> activityDetail(String id ,Map<String,dynamic> params);
  Future<Either<Failure, MyGroupSummaryResponse>> myGroupSummary();
  Future<Either<Failure, MyGroupListResponse>> myGroupList(String url, Map<String, dynamic> params);
  Future<Either<Failure, MyGroupAttentionResponse>> myGroupAttention(int page);
  Future<Either<Failure, MyGroupInvitationsResponse>> myGroupInvitations();
  Future<Either<Failure, bool>> respondInvitation(int invitationId, bool accepted);
  Future<Either<Failure, MyGroupActivitiesResponse>> myGroupActivities(int page);
  Future<Either<Failure, MyGroupSettingsResponse>> getMyGroupSettings();
  Future<Either<Failure, MyGroupSettingsResponse>> saveMyGroupSettings(bool recommendations);
  Future<Either<Failure, ActivityProfileResponse>> activityProfile();

  Future<Either<Failure, PublicProfileResponse>> publicProfile(int id);

  Future<Either<Failure, PublicProfileFeedResponse>> publicProfileFeed(int id);

  Future<Either<Failure, PublicProfileItemsResponse>> publicProfileItems(int id, String type, int page);
  Future<Either<Failure, SearchGroupOverviewResponse>> discoverOverview(int townId);
  Future<Either<Failure, SearchGroupResponse>> discoverGroups(Map<String, dynamic> params);

}
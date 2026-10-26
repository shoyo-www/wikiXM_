import 'package:dartz/dartz.dart';
import 'package:wikixm/data/datasource/remote/models/request/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_join.dart';
import 'package:wikixm/data/datasource/remote/models/response/group_sections.dart';
import 'package:wikixm/data/datasource/remote/models/response/interest_detail.dart';
import '../../core/error/failures.dart';
import '../../data/datasource/remote/models/response/group_home.dart';

abstract class GroupRepository {
  Future<Either<Failure, GroupHomeResponse>> getGroupHome();
  Future<Either<Failure, GroupSectionsResponse>> getGroupSections();
  Future<Either<Failure, GroupJoinResponse>> joinGroup(GroupJoinRequest req,bool isLeave);
  Future<Either<Failure, IntersetDetailResponse>> interestDetail(String interset , Map<String,dynamic> request);

}
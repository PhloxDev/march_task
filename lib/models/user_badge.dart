import 'package:hive/hive.dart';
part 'user_badge.g.dart';

@HiveType(typeId: 2)
class UserBadge extends HiveObject {

  @HiveField(0)
  final String? whoId;

  @HiveField(1)
  final String? userId;

  @HiveField(2)
  final int? earnedBadgeId;

  UserBadge(this.whoId,this.userId,this.earnedBadgeId);
}
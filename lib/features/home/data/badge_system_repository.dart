import 'package:march_task/features/home/data/badge_system_local_data_source.dart';
import 'package:march_task/models/badge.dart';
import 'package:march_task/models/user_badge.dart';

abstract class BadgeSystemRepository {
  Future<List<Badge>> retrieveAllBadges();

  Future<void> insertBadges();

  Future<void> submitBadges(Map<String,UserBadge> userBadges);

  Future<bool> checkTaskStatus(String userId);

  Future<Map<String,List<int>>> retrieveUserBadges();
}

class BadgeSystemRepositoryImpl implements BadgeSystemRepository {
  BadgeSystemLocalDataSource dbService = BadgeSystemLocalDataSource();

  @override
  Future<List<Badge>> retrieveAllBadges() async{
    return dbService.retrieveBadges();
  }

  @override
  Future<void> insertBadges() async{
    return dbService.insertBadges();
  }

  @override
  Future<void> submitBadges(Map<String, UserBadge> userBadges) async{
    return dbService.submitBadges(userBadges);
  }

  @override
  Future<bool> checkTaskStatus(String userId) async{
    return dbService.checkTaskStatus(userId);
  }

  @override
  Future<Map<String, List<int>>> retrieveUserBadges() async{
    return dbService.retrieveUserBadges();
  }
}

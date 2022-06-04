import 'package:hive/hive.dart';
import 'package:march_task/core/utils/constants.dart';
import 'package:march_task/models/badge.dart';
import 'package:march_task/models/user_badge.dart';
import 'package:march_task/models/user_model.dart';
import 'package:march_task/models/user_sprint.dart';

// todo handle error
class BadgeSystemLocalDataSource {
  // badge table
  Future<Box<Badge>> openBadgeBox() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BadgeAdapter());
    }
    var box = await Hive.openBox<Badge>('badgeBox');
    return box;
  }

  // user badge table
  Future<Box<UserBadge>> openUserBadgeBox() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(UserBadgeAdapter());
    }
    var box = await Hive.openBox<UserBadge>('userBadgeBox');
    return box;
  }

  // user sprint table
  Future<Box<UserSprint>> openUserSprintBox() async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(UserSprintAdapter());
    }
    var box = await Hive.openBox<UserSprint>('userSprintBox');
    return box;
  }

  Future<void> insertBadges() async {
    List<String> badges = [
      'Batman/girl',
      'Spiderman/girl',
      'Sherlock',
      'Joker',
      'Ironman/girl'
    ];
    final box = await openBadgeBox();
    List.generate(5, (index) async {
      if (!box.containsKey(index)) {
        await box.put(index, Badge(index, badges[index]));
      }
    });
  }

  Future<List<Badge>> retrieveBadges() async {
    final box = await openBadgeBox();
    return box.values.toList();
  }

  Future<void> submitBadges(Map<String, UserBadge> userBadges) async {
    final box = await openUserBadgeBox();

    userBadges.values.map((UserBadge userBadge) async {
      await box.add(userBadge);
    }).toList();

    // insert user sprint to specify task completed by this user
    final userSprintBox = await openUserSprintBox();
    await userSprintBox.add(UserSprint(
        userBadges.values.toList()[0].whoId!, Constants.currentSprint));
  }

  Future<bool> checkTaskStatus(String userId) async {
    final box = await openUserSprintBox();

    bool isDone = false;

    box.values.map((UserSprint userSprint) {
      if (userSprint.userId == userId &&
          userSprint.sprintId == Constants.currentSprint) {
        isDone = true;
        return;
      }
    }).toList();

    return isDone;
  }

  Future<Map<String, List<int>>> retrieveUserBadges() async {
    final box = await openUserBadgeBox();

    Map<String, List<int>> userBadges = <String, List<int>>{};

    box.values.map((UserBadge userBadge) async {
      if (userBadges[userBadge.userId] != null) {
        userBadges[userBadge.userId!]?.add(userBadge.earnedBadgeId!);
      } else {
        userBadges[userBadge.userId!] = <int>[userBadge.earnedBadgeId!];
      }
    }).toList();

    return userBadges;
  }
}

import 'package:hive/hive.dart';
part 'user_sprint.g.dart';

@HiveType(typeId: 3)
class UserSprint extends HiveObject {

  @HiveField(0)
  final String userId;

  @HiveField(1)
  final int sprintId;

  UserSprint(this.userId,this.sprintId);
}
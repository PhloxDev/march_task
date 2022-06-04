import 'package:hive/hive.dart';

part 'badge.g.dart';

@HiveType(typeId: 1)
class Badge extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  Badge(this.id, this.title);
}

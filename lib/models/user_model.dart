import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String? uid;

  @HiveField(1)
  final bool? isVerified;

  @HiveField(2)
  final String? email;

  @HiveField(3)
  final String? password;

  @HiveField(4)
  final String? displayName;

  UserModel(
      {this.uid, this.email, this.password, this.displayName, this.isVerified});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
    };
  }

  UserModel copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    String? displayName,
    int? age,
  }) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        isVerified: isVerified ?? this.isVerified);
  }
}

import 'package:hive/hive.dart';
import 'package:march_task/models/user_model.dart';

// todo handle error
class UserLocalDataSource {
  Future<Box<UserModel>> openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    var box = await Hive.openBox<UserModel>('usersBox');
    return box;
  }

  Future<void> addUserData(UserModel userData) async {
    final box = await openBox();
    await box.add(userData);
  }

  Future<List<UserModel>> retrieveUserData() async {
    final box = await openBox();
    return box.values.toList();
  }

  Future<String?> retrieveUserName(final UserModel userModel) async {
    final box = await openBox();

    final UserModel user = box.values.firstWhere(
        (element) => element.email == userModel.email,
        orElse: () => UserModel(displayName: ''));
    return user.email;
  }
}

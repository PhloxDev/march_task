import 'package:firebase_auth/firebase_auth.dart';
import 'package:march_task/features/authentication/data/user_local_data_source.dart';
import 'package:march_task/models/user_model.dart';

import 'authenticate_service.dart';

// dependency inversion
abstract class AuthenticationRepository {
  Stream<UserModel> getCurrentUser();

  Future<UserCredential?> signUp(UserModel user);

  Future<UserCredential?> signIn(UserModel user);

  Future<void> signOut();

  Future<String?> retrieveUserName(UserModel user);

  Future<void> saveUserData(UserModel user);

  Future<List<UserModel>> retrieveFullUserData();
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationService service = AuthenticationService();
  UserLocalDataSource dbService = UserLocalDataSource();

  @override
  Stream<UserModel> getCurrentUser() {
    return service.retrieveCurrentUser();
  }

  @override
  Future<UserCredential?> signUp(UserModel user) {
    try {
      return service.signUp(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<UserCredential?> signIn(UserModel user) {
    try {
      return service.signIn(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> signOut() {
    return service.signOut();
  }

  @override
  Future<String?> retrieveUserName(UserModel user) async {
    return dbService.retrieveUserName(user);
  }

  @override
  Future<void> saveUserData(UserModel user) {
    return dbService.addUserData(user);
  }

  @override
  Future<List<UserModel>> retrieveFullUserData() async{
    return dbService.retrieveUserData();
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:march_task/features/authentication/data/authentication_repository.dart';
import 'package:march_task/features/home/data/badge_system_repository.dart';
import 'package:march_task/models/user_model.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final BadgeSystemRepository _badgeSystemRepository;

  AuthenticationBloc(
      this._authenticationRepository, this._badgeSystemRepository)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationStarted) {
        UserModel user = await _authenticationRepository.getCurrentUser().first;
        if (user.uid != "uid") {
          String? email =
              await _authenticationRepository.retrieveUserName(user);
          emit(AuthenticationSuccess(email: email ?? ''));

          _badgeSystemRepository.insertBadges();
        } else {
          emit(AuthenticationFailure());
        }
      } else if (event is AuthenticationSignedOut) {
        await _authenticationRepository.signOut();
        emit(AuthenticationFailure());
      }
    });
  }
}

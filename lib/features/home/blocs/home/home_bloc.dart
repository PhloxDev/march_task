import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:march_task/features/authentication/data/authentication_repository.dart';
import 'package:march_task/features/home/data/badge_system_repository.dart';
import 'package:march_task/models/badge.dart';
import 'package:march_task/models/user_badge.dart';
import 'package:march_task/models/user_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationRepository _authenticationRepository;
  final BadgeSystemRepository _badgeSystemRepository;

  Map<String, UserBadge> userBadges = <String, UserBadge>{};

  List<UserModel> listOfUserData = <UserModel>[];
  List<Badge> listOfBadge = <Badge>[];

  HomeBloc(this._authenticationRepository, this._badgeSystemRepository)
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is DataFetched) {
        await _fetchData(event, emit);
      }

      if (event is UserBadgeSelected) {
        await _onUserBadgeSelected(event, emit);
      }

      if (event is BadgeSubmitted) {
        _badgeSystemRepository.submitBadges(userBadges);

        emit(BadgeSubmitSuccess());
      }
    });
  }

  /// fetch user and badge list from local db
  Future<void> _fetchData(DataFetched event, Emitter<HomeState> emit) async {
    UserModel user = await _authenticationRepository.getCurrentUser().first;

    bool isDone = await _badgeSystemRepository.checkTaskStatus(user.uid!);

    if (isDone) {
      emit(BadgeSubmitSuccess());
    } else {
      listOfUserData = await _authenticationRepository.retrieveFullUserData();

      listOfBadge = await _badgeSystemRepository.retrieveAllBadges();

      emit(HomeSuccess(listOfUserData, listOfBadge, user));
    }
  }

  _onUserBadgeSelected(UserBadgeSelected event, Emitter<HomeState> emit) async {
    UserModel user = await _authenticationRepository.getCurrentUser().first;

    // check unique badges
    bool isUnique = true;
    userBadges.values.map((userBadge) {
      if (userBadge.earnedBadgeId == event.selectedBadge!.id &&
          userBadge.userId != event.userModel!.uid) {
        isUnique = false;
        return;
      }
    }).toList();

    if (isUnique) {
      userBadges[event.userModel!.uid!] =
          UserBadge(user.uid, event.userModel!.uid, event.selectedBadge!.id);
    } else {
      emit(
          HomeSuccess(listOfUserData, listOfBadge, user, isBadgeValid: false));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:march_task/features/authentication/data/authentication_repository.dart';
import 'package:march_task/features/home/data/badge_system_repository.dart';
import 'package:march_task/models/badge.dart';
import 'package:march_task/models/user_model.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AuthenticationRepository _authenticationRepository;
  final BadgeSystemRepository _badgeSystemRepository;

  AdminBloc(this._authenticationRepository, this._badgeSystemRepository)
      : super(AdminInitial()) {
    on<AdminEvent>((event, emit) async {
      if (event is DataFetched) {
        await _fetchData(event, emit);
      }
    });
  }

  Future<void> _fetchData(DataFetched event, Emitter<AdminState> emit) async {
    List<UserModel> listOfUserData =
        await _authenticationRepository.retrieveFullUserData();

    List<Badge> listOfBadge = await _badgeSystemRepository.retrieveAllBadges();

    Map<String, List<int>> userBadges =
        await _badgeSystemRepository.retrieveUserBadges();

    emit(AdminSuccess(listOfUserData, listOfBadge, userBadges));
  }
}

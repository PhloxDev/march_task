part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class DataFetched extends HomeEvent {
  const DataFetched();

  @override
  List<Object> get props => [];
}

class UserBadgeSelected extends HomeEvent {
  final UserModel? userModel;
  final Badge? selectedBadge;

  const UserBadgeSelected(
      {required this.userModel, required this.selectedBadge});

  @override
  List<Object?> get props => [userModel, selectedBadge];
}

class BadgeSubmitted extends HomeEvent {
  const BadgeSubmitted();

  @override
  List<Object> get props => [];
}

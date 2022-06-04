part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final List<UserModel> listOfUserData;
  final List<Badge> listOfBadge;
  final UserModel userModel;

  final bool isBadgeValid;

  const HomeSuccess(this.listOfUserData, this.listOfBadge, this.userModel,
      {this.isBadgeValid = true});

  @override
  List<Object> get props => [listOfUserData, listOfBadge, userModel];
}

class BadgeSubmitSuccess extends HomeState {}

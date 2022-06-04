part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminSuccess extends AdminState {
  final List<UserModel> listOfUserData;
  final List<Badge> listOfBadge;
  final Map<String, List<int>> listOfUserBadge;

  const AdminSuccess(
      this.listOfUserData, this.listOfBadge, this.listOfUserBadge);

  @override
  List<Object> get props => [listOfUserData, listOfBadge, listOfUserBadge];
}

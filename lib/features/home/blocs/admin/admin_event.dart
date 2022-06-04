part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class DataFetched extends AdminEvent {
  const DataFetched();

  @override
  List<Object> get props => [];
}
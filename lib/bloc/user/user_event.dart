part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class FetchUser extends UserEvent {
  final String query;
  final int page;

  FetchUser({
    @required this.query,
    this.page
  });
}

class ResetUserSearch extends UserEvent {}
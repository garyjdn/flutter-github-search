part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final List<User> users;

  UserState({this.users});
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  UserInitial(): super(users: []);
}

class UserLoadInProgress extends UserState {
  UserLoadInProgress({List<User> users}): super(users: users);
}

class UserLoadSuccess extends UserState {
  final bool hasReachedMax;

  UserLoadSuccess({
    List<User> users, 
    this.hasReachedMax = false,
  }): super(users: users);
}

class UserLoadFailure extends UserState {
  final AppError error;

  UserLoadFailure({
    List<User> users, 
    this.error
  }): super(users: users);
}
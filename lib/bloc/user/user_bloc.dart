import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository _userRepository;
  int loadedPage = 0;

  UserBloc(this._userRepository) : super(UserInitial());

  bool _hasReachedMax(UserState state) {
    return state is UserLoadSuccess && state.hasReachedMax;
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if(event is FetchUser && !_hasReachedMax(state)) {
      yield* _fetchUser(event);
    } else if(event is ResetUserSearch) {
      yield* _resetSearch();
    }
  }

  Stream<UserState> _fetchUser(FetchUser event) async* {
    final currentState = state;

    yield UserLoadInProgress(users: currentState.users);
    try {
      List<User> users = await _userRepository.fetchData(
        query: event.query,
        page: loadedPage,
      );
      if(users.isNotEmpty) {
        loadedPage += 1;
      }
      yield UserLoadSuccess(
        users: currentState.users + users,
        hasReachedMax: users.isEmpty
      );
    } on Exception {
      yield UserLoadFailure(
        users: currentState.users,
      );
    }
  }

  Stream<UserState> _resetSearch() async* {
    loadedPage = 0;
    yield UserLoadSuccess(users: []);
  }
}

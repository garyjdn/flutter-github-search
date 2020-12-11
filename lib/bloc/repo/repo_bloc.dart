import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

part 'repo_event.dart';
part 'repo_state.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  RepoRepository _repoRepository;
  int loadedPage = 0;

  RepoBloc(this._repoRepository) : super(RepoInitial());

  bool _hasReachedMax(RepoState state) {
    return state is RepoLoadSuccess && state.hasReachedMax;
  }

  @override
  Stream<RepoState> mapEventToState(
    RepoEvent event,
  ) async* {
    if(event is FetchRepo && !_hasReachedMax(state)) {
      yield* _fetchRepo(event);
    } else if(event is ResetRepoSearch) {
      yield* _resetSearch();
    }
  }

  Stream<RepoState> _fetchRepo(FetchRepo event) async* {
    final currentState = state;

    yield RepoLoadInProgress(repos: currentState.repos);
    try {
      List<Repo> repos = await _repoRepository.fetchData(
        query: event.query,
        page: loadedPage,
      );
      if(repos.isNotEmpty) {
        loadedPage += 1;
      }
      yield RepoLoadSuccess(
        repos: currentState.repos + repos,
        hasReachedMax: repos.isEmpty
      );
    } on Exception {
      yield RepoLoadFailure(
        repos: currentState.repos,
      );
    }
  }

  Stream<RepoState> _resetSearch() async* {
    loadedPage = 0;
    yield RepoLoadSuccess(repos: []);
  }
}

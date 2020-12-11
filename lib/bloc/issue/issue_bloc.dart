import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../../data/data.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';

part 'issue_event.dart';
part 'issue_state.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  IssueRepository _issueRepository;
  int loadedPage = 0;

  IssueBloc(this._issueRepository) : super(IssueInitial());

  bool _hasReachedMax(IssueState state) {
    return state is IssueLoadSuccess && state.hasReachedMax;
  }

  @override
  Stream<IssueState> mapEventToState(
    IssueEvent event,
  ) async* {
    if(event is FetchIssue && !_hasReachedMax(state)) {
      yield* _fetchIssue(event);
    } else if(event is ResetIssueSearch) {
      yield* _resetSearch();
    }
  }

  Stream<IssueState> _fetchIssue(FetchIssue event) async* {
    final currentState = state;

    yield IssueLoadInProgress(issues: currentState.issues);
    try {
      List<Issue> issues = await _issueRepository.fetchData(
        query: event.query,
        page: loadedPage,
      );
      if(issues.isNotEmpty) {
        loadedPage += 1;
      }
      yield IssueLoadSuccess(
        issues: currentState.issues + issues,
        hasReachedMax: issues.isEmpty
      );
    } on Exception {
      yield IssueLoadFailure(
        issues: currentState.issues
      );
    }
  }

  Stream<IssueState> _resetSearch() async* {
    loadedPage = 0;
    yield IssueLoadInProgress(issues: []);
  }
}

part of 'issue_bloc.dart';

abstract class IssueEvent extends Equatable {
  const IssueEvent();

  @override
  List<Object> get props => [];
}

class FetchIssue extends IssueEvent {
  final String query;
  final int page;

  FetchIssue({
    @required this.query,
    this.page
  });
}

class ResetIssueSearch extends IssueEvent {}
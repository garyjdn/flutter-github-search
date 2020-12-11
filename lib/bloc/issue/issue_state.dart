part of 'issue_bloc.dart';

abstract class IssueState extends Equatable {
  final List<Issue> issues;

  IssueState({this.issues});
  
  @override
  List<Object> get props => [];
}

class IssueInitial extends IssueState {
  IssueInitial(): super(issues: []);
}

class IssueLoadInProgress extends IssueState{
  IssueLoadInProgress({List<Issue> issues}): super(issues: issues);
}

class IssueLoadSuccess extends IssueState{
  final bool hasReachedMax;

  IssueLoadSuccess({
    List<Issue> issues, 
    this.hasReachedMax = false,
  }): super(issues: issues);
}

class IssueLoadFailure extends IssueState{
  final AppError error;

  IssueLoadFailure({
    List<Issue> issues, 
    this.error
  }): super(issues: issues);
}
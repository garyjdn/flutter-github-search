part of 'repo_bloc.dart';

abstract class RepoState extends Equatable {
  final List<Repo> repos;

  RepoState({this.repos});
  
  @override
  List<Object> get props => [];
}

class RepoInitial extends RepoState {
  RepoInitial(): super(repos: []);
}

class RepoLoadInProgress extends RepoState{
  RepoLoadInProgress({List<Repo> repos}): super(repos: repos);
}

class RepoLoadSuccess extends RepoState{
  final bool hasReachedMax;

  RepoLoadSuccess({
    List<Repo> repos, 
    this.hasReachedMax = false,
  }): super(repos: repos);
}

class RepoLoadFailure extends RepoState{
  final AppError error;

  RepoLoadFailure({
    List<Repo> repos, 
    this.error
  }): super(repos: repos);
}
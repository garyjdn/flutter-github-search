part of 'repo_bloc.dart';

abstract class RepoEvent extends Equatable {
  const RepoEvent();

  @override
  List<Object> get props => [];
}

class FetchRepo extends RepoEvent {
  final String query;
  final int page;

  FetchRepo({
    @required this.query,
    this.page
  });
}

class ResetRepoSearch extends RepoEvent {}
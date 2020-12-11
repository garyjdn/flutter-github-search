part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class ChangePage extends HomePageEvent {
  final int index;
  ChangePage(this.index);
}
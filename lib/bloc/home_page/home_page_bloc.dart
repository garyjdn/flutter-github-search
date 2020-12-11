import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, int> {
  HomePageBloc() : super(0);

  @override
  Stream<int> mapEventToState(
    HomePageEvent event,
  ) async* {
    if(event is ChangePage) {
      yield event.index;
    }
  }
}

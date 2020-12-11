import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc() : super(AppSettingsLightTheme());

  @override
  Stream<AppSettingsState> mapEventToState(
    AppSettingsEvent event,
  ) async* {
    if(event is SwitchToLight) {
      yield AppSettingsLightTheme();
    } else if(event is SwitchToDark) {
      yield AppSettingsDarkTheme();
    }
  }
}

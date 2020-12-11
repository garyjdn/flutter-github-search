part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object> get props => [];
}

class SwitchToLight extends AppSettingsEvent {}

class SwitchToDark extends AppSettingsEvent {}
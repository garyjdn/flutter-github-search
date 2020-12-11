import 'package:flutter/material.dart';
import './ui/ui.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SettingsScreen.routeName: (ctx) => SettingsScreen(),
};
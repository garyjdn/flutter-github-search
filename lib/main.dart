import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import './bloc/bloc.dart';
import './data/data.dart';
import './ui/ui.dart';
import './routes.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppSettingsBloc>(
            create: (BuildContext context) => AppSettingsBloc(), 
          ),
          BlocProvider<IssueBloc>(
            create: (BuildContext context) => IssueBloc(IssueRepository()),
          ),
          BlocProvider<RepoBloc>(
            create: (BuildContext context) => RepoBloc(RepoRepository()),
          ),
          BlocProvider<UserBloc>(
            create: (BuildContext context) => UserBloc(UserRepository()),
          )
        ],
        child: NeumorphicWidget()
      ),
    );
  }
}

class NeumorphicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appSettingsState = context.watch<AppSettingsBloc>().state;
    ThemeMode themeMode;
    if(appSettingsState is AppSettingsLightTheme) {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Github Search',
      themeMode: themeMode,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFDDDDDD),
        lightSource: LightSource.topLeft,
        depth: 10,
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Colors.black87
        )
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xff333333),
        accentColor: Colors.green,
        lightSource: LightSource.topLeft,
        depth: 4,
        intensity: 0.3,
        textTheme: TextTheme(
          headline6: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white70),
          headline5: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white70),
          headline4: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white70),
          headline3: Theme.of(context).textTheme.headline3.copyWith(color: Colors.white70),
          subtitle2: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white70),
          subtitle1: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white70),
          caption: Theme.of(context).textTheme.caption.copyWith(color: Colors.white70),
          bodyText2: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white70),
          bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white70),
        ),
        buttonStyle: NeumorphicStyle(
          color: Colors.white70,
        ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
          color: Colors.white70,
        )
      ),
      home: HomeScreen(),
      routes: routes,
    );
  }
}

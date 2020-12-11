import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../bloc/bloc.dart';

enum NeuThemeMode { lightTheme, darkTheme }

class SettingsTemplate extends StatefulWidget {

  @override
  _SettingsTemplateState createState() => _SettingsTemplateState();
}

class _SettingsTemplateState extends State<SettingsTemplate> {
  NeuThemeMode selectedTheme = NeuThemeMode.lightTheme;
  AppSettingsBloc appSettingsBloc;

  @override
  void initState() {
    super.initState();
    appSettingsBloc = BlocProvider.of<AppSettingsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Settings',
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme',
                style: Theme.of(context).textTheme.bodyText1
              ),

              RadioListTile<NeuThemeMode>(
                title: const Text('Light Theme'),
                value: NeuThemeMode.lightTheme,
                groupValue: selectedTheme,
                onChanged: (NeuThemeMode value) {
                  setState(() {
                    selectedTheme = value;
                  });
                  context.read<AppSettingsBloc>().add(SwitchToLight());
                },
              ),
              RadioListTile<NeuThemeMode>(
                title: const Text('Dark Theme'),
                value: NeuThemeMode.darkTheme,
                groupValue: selectedTheme,
                onChanged: (NeuThemeMode value) {
                  setState(() {
                    selectedTheme = value;
                  });
                  context.read<AppSettingsBloc>().add(SwitchToDark());
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
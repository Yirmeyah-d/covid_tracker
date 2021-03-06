import 'package:covid_tracker/src/core/styles/colors.dart';
import 'package:covid_tracker/src/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child:
            BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
          return DropdownButton<ThemeMode>(
            // Read the selected themeMode from the controller
            value: state.themeMode,
            // Call the updateThemeMode method any time the user selects a theme.
            onChanged: (ThemeMode? newThemeMode) {
              BlocProvider.of<SettingsBloc>(context)
                  .add(ThemeModeChangedEvent(themeMode: newThemeMode!));
            },
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('System Theme'),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Light Theme'),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Dark Theme'),
              )
            ],
          );
        }),
      ),
    );
  }
}

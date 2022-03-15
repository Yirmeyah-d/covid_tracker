import 'package:covid_tracker/src/core/use_case/use_case.dart';
import 'package:covid_tracker/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter/material.dart';

class LoadThemeMode {
  final SettingsRepository repository;

  LoadThemeMode(this.repository);

  Future<ThemeMode> call(NoParams params) async {
    return await repository.loadThemeMode();
  }
}

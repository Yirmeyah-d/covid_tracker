import 'package:covid_tracker/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UpdateThemeMode {
  final SettingsRepository repository;

  UpdateThemeMode(this.repository);

  Future<void> call(Params params) async {
    return await repository.updateThemeMode(params.themeMode);
  }
}

class Params extends Equatable {
  final ThemeMode themeMode;

  const Params({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void toggleTheme() {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: newMode));
  }

  void setThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }

  void setSystemTheme(bool enabled) {
    emit(state.copyWith(
      themeMode: enabled ? ThemeMode.system : ThemeMode.light,
      systemThemeEnabled: enabled,
    ));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState.fromJson(json);
    } catch (e) {
      return ThemeState.initial();
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}

class ThemeState {
  final ThemeMode themeMode;
  final bool systemThemeEnabled;

  ThemeState({
    required this.themeMode,
    required this.systemThemeEnabled,
  });

  factory ThemeState.initial() => ThemeState(
        themeMode: ThemeMode.light,
        systemThemeEnabled: false,
      );

  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? systemThemeEnabled,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      systemThemeEnabled: systemThemeEnabled ?? this.systemThemeEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode.index,
        'systemThemeEnabled': systemThemeEnabled,
      };

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      themeMode: ThemeMode.values[json['themeMode'] ?? 0],
      systemThemeEnabled: json['systemThemeEnabled'] ?? false,
    );
  }
}

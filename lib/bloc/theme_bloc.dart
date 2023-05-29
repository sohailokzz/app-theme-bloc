import 'package:app_theme_bloc/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData.light()) {
    on<InitialThemeSetEvent>((event, emit) async {
      final hasDarkTheme = await isDark();
      if (hasDarkTheme) {
        emit(
          ThemeData.dark(),
        );
      } else {
        emit(
          ThemeData.light(),
        );
      }
    });

    on<ThemeSwitchEvent>(
      (event, emit) {
        final isDark = state == ThemeData.dark();
        emit(
          isDark ? ThemeData.light() : ThemeData.dark(),
        );
        setTheme(isDark);
      },
    );
  }
}

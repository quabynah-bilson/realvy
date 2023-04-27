import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeBuilderX on BuildContext {
  ThemeData get useLightTheme {
    const backgroundColor = Color(0xffffffff);
    final colorScheme = useColorScheme();
    return ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        disabledColor: const Color(0xffe0e0e0),
        colorScheme: colorScheme,
        platform: TargetPlatform.iOS,
        dividerTheme: DividerThemeData(
            color: colorScheme.surface,
            indent: 24,
            endIndent: 24,
            space: 24),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: backgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0),
        textTheme: _textTheme());
  }

  ThemeData get useDarkTheme => ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: useColorScheme(ThemeMode.dark),
      platform: TargetPlatform.iOS,
      appBarTheme: const AppBarTheme(elevation: 0, scrolledUnderElevation: 0),
      textTheme: _textTheme(Colors.white));
}

/// setup color scheme
ColorScheme useColorScheme([ThemeMode mode = ThemeMode.light]) =>
    mode == ThemeMode.light
        ? const ColorScheme.light(
            background: Color(0xffffffff),
            onBackground: Color(0xff020f27),
            onPrimary: Colors.white,
            primary: Color(0xff020f27),
            secondary: Color(0xff117ff5),
            onSecondary: Colors.white,
            surface: Color(0xfff6f6f6),
            onSurface: Colors.black,
            error: Colors.pink,
            onError: Colors.white,
            errorContainer: Colors.pink,
            onErrorContainer: Colors.white,
            tertiary: Color(0xff322261),
            onTertiary: Colors.white,
            secondaryContainer: Color(0xffD5E048),
            onSecondaryContainer: Colors.black,
          )
        : const ColorScheme.dark(
            onBackground: Colors.white,
          );

/// setup font
const _primaryFont = GoogleFonts.dmSans,
    _secondaryFont = GoogleFonts.rubik;

TextTheme _textTheme([Color textColor = Colors.black]) => TextTheme(
      displayLarge: _primaryFont(
          color: textColor,
          fontSize: 105,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5),
      displayMedium: _primaryFont(
          color: textColor,
          fontSize: 65,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5),
      displaySmall: _primaryFont(
          color: textColor, fontSize: 52, fontWeight: FontWeight.w400),
      headlineMedium: _primaryFont(
          color: textColor,
          fontSize: 37,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25),
      headlineSmall: _primaryFont(
          color: textColor, fontSize: 26, fontWeight: FontWeight.w500),
      titleLarge: _primaryFont(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15),
      titleMedium: _primaryFont(
          color: textColor,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15),
      titleSmall: _primaryFont(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1),
      bodyLarge: _secondaryFont(
          color: textColor,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5),
      bodyMedium: _secondaryFont(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25),
      labelLarge: _secondaryFont(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25),
      bodySmall: _secondaryFont(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4),
      labelSmall: _secondaryFont(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5),
    );

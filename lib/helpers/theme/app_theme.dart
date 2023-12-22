/*
* File : App Theme
* Version : 1.0.0
* */

import 'package:flutter/material.dart';
import 'package:kyoumutechou/helpers/theme/theme_type.dart';

export 'custom_theme.dart';
export 'navigation_theme.dart';

ThemeData get theme => AppTheme.theme;

class AppTheme {
  static ThemeType themeType = ThemeType.light;
  static TextDirection textDirection = TextDirection.rtl;

  static ThemeData get theme {
    switch (themeType) {
      case ThemeType.light:
        return lightTheme;
      case ThemeType.dark:
        return darkTheme;
      default:
        return lightTheme;
    }
  }

  /// -------------------------- Light Theme  -------------------------------------------- ///
  static final ThemeData lightTheme = ThemeData(
    /// Brightness
    useMaterial3: true,
    brightness: Brightness.light,

    fontFamily: 'NotoSansJP',
    visualDensity: VisualDensity.adaptivePlatformDensity,

    primaryColor: const Color(0xFF2D6B27),
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: const Color(0xffffffff),
 
    colorScheme: lightColorScheme,
  );

  /// -------------------------- Dark Theme  -------------------------------------------- ///
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'NotoSansJP',
    visualDensity: VisualDensity.adaptivePlatformDensity,

    colorScheme: darkColorScheme,
    // 定义 NavigationRail 的暗主题样式
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Colors.black, // 暗主题的背景颜色
      selectedIconTheme: IconThemeData(color: Colors.green.shade700), // 选中图标颜色
      unselectedIconTheme:
          IconThemeData(color: Colors.grey.shade800), // 未选中图标颜色
      selectedLabelTextStyle: TextStyle(color: Colors.green.shade700), // 选中文本样式
      unselectedLabelTextStyle:
          TextStyle(color: Colors.grey.shade800), // 未选中文本样式
    ),
  );
}


const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF126D34),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFA0F6AE),
  onPrimaryContainer: Color(0xFF00210A),
  secondary: Color(0xFF506351),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD3E8D2),
  onSecondaryContainer: Color(0xFF0E1F11),
  tertiary: Color(0xFF39656D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFBDEAF4),
  onTertiaryContainer: Color(0xFF001F24),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFDF7),
  onBackground: Color(0xFF1A1C19),
  surface: Color(0xFFFCFDF7),
  onSurface: Color(0xFF1A1C19),
  surfaceVariant: Color(0xFFDDE5DA),
  onSurfaceVariant: Color(0xFF414941),
  outline: Color(0xFF727970),
  onInverseSurface: Color(0xFFF0F1EC),
  inverseSurface: Color(0xFF2E312E),
  inversePrimary: Color(0xFF85D993),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF126D34),
  outlineVariant: Color(0xFFC1C9BE),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF85D993),
  onPrimary: Color(0xFF003916),
  primaryContainer: Color(0xFF005323),
  onPrimaryContainer: Color(0xFFA0F6AE),
  secondary: Color(0xFFB7CCB6),
  onSecondary: Color(0xFF233425),
  secondaryContainer: Color(0xFF394B3B),
  onSecondaryContainer: Color(0xFFD3E8D2),
  tertiary: Color(0xFFA1CED7),
  onTertiary: Color(0xFF00363E),
  tertiaryContainer: Color(0xFF204D55),
  onTertiaryContainer: Color(0xFFBDEAF4),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C19),
  onBackground: Color(0xFFE2E3DE),
  surface: Color(0xFF1A1C19),
  onSurface: Color(0xFFE2E3DE),
  surfaceVariant: Color(0xFF414941),
  onSurfaceVariant: Color(0xFFC1C9BE),
  outline: Color(0xFF8B9389),
  onInverseSurface: Color(0xFF1A1C19),
  inverseSurface: Color(0xFFE2E3DE),
  inversePrimary: Color(0xFF126D34),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF85D993),
  outlineVariant: Color(0xFF414941),
  scrim: Color(0xFF000000),
);

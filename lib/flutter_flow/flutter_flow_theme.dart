// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';

SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color onSurface;
  late Color secondaryContainer;
  late Color onPrimaryContainer;
  late Color onAccent;
  late Color onError;
  late Color accentContainer;
  late Color onSecondary;
  late Color onWarning;
  late Color surfaceVariant;
  late Color onBackground;
  late Color onSuccess;
  late Color transparent;
  late Color primaryContainer;
  late Color onAccentContainer;
  late Color onSecondaryContainer;
  late Color onSurfaceVariant;
  late Color onInfo;
  late Color onPrimary;
  late Color fullContrast;
  late Color primary10;
  late Color background50;
  late Color onPrimary50;
  late Color primary30;
  late Color warning10;
  late Color fullContrast40;
  late Color info10;
  late Color secondary10;
  late Color accent10;
  late Color warning15;
  late Color success15;
  late Color error10;
  late Color error20;
  late Color info20;
  late Color primary5;
  late Color primary20;

  FFDesignTokens get designToken => FFDesignTokens(this);

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  bool get displayLargeIsCustom => typography.displayLargeIsCustom;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  bool get displayMediumIsCustom => typography.displayMediumIsCustom;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  bool get displaySmallIsCustom => typography.displaySmallIsCustom;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  bool get headlineLargeIsCustom => typography.headlineLargeIsCustom;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  bool get headlineMediumIsCustom => typography.headlineMediumIsCustom;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  bool get headlineSmallIsCustom => typography.headlineSmallIsCustom;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  bool get titleLargeIsCustom => typography.titleLargeIsCustom;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  bool get titleMediumIsCustom => typography.titleMediumIsCustom;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  bool get titleSmallIsCustom => typography.titleSmallIsCustom;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  bool get labelLargeIsCustom => typography.labelLargeIsCustom;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  bool get labelMediumIsCustom => typography.labelMediumIsCustom;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  bool get labelSmallIsCustom => typography.labelSmallIsCustom;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  bool get bodyLargeIsCustom => typography.bodyLargeIsCustom;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  bool get bodyMediumIsCustom => typography.bodyMediumIsCustom;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  bool get bodySmallIsCustom => typography.bodySmallIsCustom;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF005B94);
  late Color secondary = const Color(0xFF525F66);
  late Color tertiary = const Color(0xFF006B3F);
  late Color alternate = const Color(0xFF8C9199);
  late Color primaryText = const Color(0xFF1A1C1E);
  late Color secondaryText = const Color(0xFF44474E);
  late Color primaryBackground = const Color(0xFFF2EDE4);
  late Color secondaryBackground = const Color(0xFFF2EDE4);
  late Color accent1 = const Color(0x00000000);
  late Color accent2 = const Color(0x00000000);
  late Color accent3 = const Color(0xFF74777F);
  late Color accent4 = const Color(0x00000000);
  late Color success = const Color(0xFF2D6A4F);
  late Color warning = const Color(0xFFB45309);
  late Color error = const Color(0xFFBA1A1A);
  late Color info = const Color(0xFF005B94);

  late Color onSurface = const Color(0xFF1A1C1E);
  late Color secondaryContainer = const Color(0x1A525F66);
  late Color onPrimaryContainer = const Color(0xFF1A1C1E);
  late Color onAccent = const Color(0xFFFFFFFF);
  late Color onError = const Color(0xFFFFFFFF);
  late Color accentContainer = const Color(0x1A006B3F);
  late Color onSecondary = const Color(0xFFFFFFFF);
  late Color onWarning = const Color(0xFFFFFFFF);
  late Color surfaceVariant = const Color(0xFFE3DDD0);
  late Color onBackground = const Color(0xFF1A1C1E);
  late Color onSuccess = const Color(0xFFFFFFFF);
  late Color transparent = const Color(0x00000000);
  late Color primaryContainer = const Color(0x1A005B94);
  late Color onAccentContainer = const Color(0xFF1A1C1E);
  late Color onSecondaryContainer = const Color(0xFF1A1C1E);
  late Color onSurfaceVariant = const Color(0xFF44474E);
  late Color onInfo = const Color(0xFFFFFFFF);
  late Color onPrimary = const Color(0xFFFFFFFF);
  late Color fullContrast = const Color(0xFF000000);
  late Color primary10 = const Color(0x1A005B94);
  late Color background50 = const Color(0x80F2EDE4);
  late Color onPrimary50 = const Color(0x80FFFFFF);
  late Color primary30 = const Color(0x4D005B94);
  late Color warning10 = const Color(0x1AB45309);
  late Color fullContrast40 = const Color(0x66000000);
  late Color info10 = const Color(0x1A005B94);
  late Color secondary10 = const Color(0x1A525F66);
  late Color accent10 = const Color(0x1A006B3F);
  late Color warning15 = const Color(0x26B45309);
  late Color success15 = const Color(0x262D6A4F);
  late Color error10 = const Color(0x1ABA1A1A);
  late Color error20 = const Color(0x33BA1A1A);
  late Color info20 = const Color(0x33005B94);
  late Color primary5 = const Color(0x0D005B94);
  late Color primary20 = const Color(0x33005B94);
}

abstract class Typography {
  String get displayLargeFamily;
  bool get displayLargeIsCustom;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  bool get displayMediumIsCustom;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  bool get displaySmallIsCustom;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  bool get headlineLargeIsCustom;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  bool get headlineMediumIsCustom;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  bool get headlineSmallIsCustom;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  bool get titleLargeIsCustom;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  bool get titleMediumIsCustom;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  bool get titleSmallIsCustom;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  bool get labelLargeIsCustom;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  bool get labelMediumIsCustom;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  bool get labelSmallIsCustom;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  bool get bodyLargeIsCustom;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  bool get bodyMediumIsCustom;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  bool get bodySmallIsCustom;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Source Sans 3';
  bool get displayLargeIsCustom => false;
  TextStyle get displayLarge => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.bold,
        fontSize: 57.0,
        height: 1.12,
      );
  String get displayMediumFamily => 'Source Sans 3';
  bool get displayMediumIsCustom => false;
  TextStyle get displayMedium => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.bold,
        fontSize: 45.0,
        height: 1.16,
      );
  String get displaySmallFamily => 'Source Sans 3';
  bool get displaySmallIsCustom => false;
  TextStyle get displaySmall => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.bold,
        fontSize: 36.0,
        height: 1.22,
      );
  String get headlineLargeFamily => 'Source Sans 3';
  bool get headlineLargeIsCustom => false;
  TextStyle get headlineLarge => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
        height: 1.2,
      );
  String get headlineMediumFamily => 'Source Sans 3';
  bool get headlineMediumIsCustom => false;
  TextStyle get headlineMedium => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w600,
        fontSize: 28.0,
        height: 1.25,
      );
  String get headlineSmallFamily => 'Source Sans 3';
  bool get headlineSmallIsCustom => false;
  TextStyle get headlineSmall => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
        height: 1.3,
      );
  String get titleLargeFamily => 'Source Sans 3';
  bool get titleLargeIsCustom => false;
  TextStyle get titleLarge => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
        height: 1.27,
      );
  String get titleMediumFamily => 'Source Sans 3';
  bool get titleMediumIsCustom => false;
  TextStyle get titleMedium => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w600,
        fontSize: 17.0,
        height: 1.35,
      );
  String get titleSmallFamily => 'Source Sans 3';
  bool get titleSmallIsCustom => false;
  TextStyle get titleSmall => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
        height: 1.4,
      );
  String get labelLargeFamily => 'Source Sans 3';
  bool get labelLargeIsCustom => false;
  TextStyle get labelLarge => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w600,
        fontSize: 15.0,
        height: 1.33,
      );
  String get labelMediumFamily => 'Source Sans 3';
  bool get labelMediumIsCustom => false;
  TextStyle get labelMedium => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w600,
        fontSize: 13.0,
        height: 1.38,
      );
  String get labelSmallFamily => 'Source Sans 3';
  bool get labelSmallIsCustom => false;
  TextStyle get labelSmall => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.w600,
        fontSize: 11.0,
        height: 1.27,
      );
  String get bodyLargeFamily => 'Source Sans 3';
  bool get bodyLargeIsCustom => false;
  TextStyle get bodyLarge => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.normal,
        fontSize: 17.0,
        height: 1.7,
      );
  String get bodyMediumFamily => 'Source Sans 3';
  bool get bodyMediumIsCustom => false;
  TextStyle get bodyMedium => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.normal,
        fontSize: 15.0,
        height: 1.65,
      );
  String get bodySmallFamily => 'Source Sans 3';
  bool get bodySmallIsCustom => false;
  TextStyle get bodySmall => GoogleFonts.sourceSans3(
        fontWeight: FontWeight.normal,
        fontSize: 13.0,
        height: 1.6,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFFD1E4FF);
  late Color secondary = const Color(0xFFBEC8D2);
  late Color tertiary = const Color(0xFF86D992);
  late Color alternate = const Color(0xFF8E9199);
  late Color primaryText = const Color(0xFFE2E2E6);
  late Color secondaryText = const Color(0xFFC4C7CF);
  late Color primaryBackground = const Color(0xFF1A1C1E);
  late Color secondaryBackground = const Color(0xFF1A1C1E);
  late Color accent1 = const Color(0x00000000);
  late Color accent2 = const Color(0x00000000);
  late Color accent3 = const Color(0xFF8E9199);
  late Color accent4 = const Color(0x00000000);
  late Color success = const Color(0xFF86D992);
  late Color warning = const Color(0xFFFBBF24);
  late Color error = const Color(0xFFFFB4AB);
  late Color info = const Color(0xFFD1E4FF);

  late Color onSurface = const Color(0xFFE2E2E6);
  late Color secondaryContainer = const Color(0x24BEC8D2);
  late Color onPrimaryContainer = const Color(0xFFE2E2E6);
  late Color onAccent = const Color(0xFF000000);
  late Color onError = const Color(0xFF000000);
  late Color accentContainer = const Color(0x2486D992);
  late Color onSecondary = const Color(0xFF000000);
  late Color onWarning = const Color(0xFF000000);
  late Color surfaceVariant = const Color(0xFF44474E);
  late Color onBackground = const Color(0xFFE2E2E6);
  late Color onSuccess = const Color(0xFF000000);
  late Color transparent = const Color(0x00000000);
  late Color primaryContainer = const Color(0x24D1E4FF);
  late Color onAccentContainer = const Color(0xFFE2E2E6);
  late Color onSecondaryContainer = const Color(0xFFE2E2E6);
  late Color onSurfaceVariant = const Color(0xFFC4C7CF);
  late Color onInfo = const Color(0xFF000000);
  late Color onPrimary = const Color(0xFF000000);
  late Color fullContrast = const Color(0xFFFFFFFF);
  late Color primary10 = const Color(0x1AD1E4FF);
  late Color background50 = const Color(0x801A1C1E);
  late Color onPrimary50 = const Color(0x80000000);
  late Color primary30 = const Color(0x4DD1E4FF);
  late Color warning10 = const Color(0x1AFBBF24);
  late Color fullContrast40 = const Color(0x66FFFFFF);
  late Color info10 = const Color(0x1AD1E4FF);
  late Color secondary10 = const Color(0x1ABEC8D2);
  late Color accent10 = const Color(0x1A86D992);
  late Color warning15 = const Color(0x26FBBF24);
  late Color success15 = const Color(0x2686D992);
  late Color error10 = const Color(0x1AFFB4AB);
  late Color error20 = const Color(0x33FFB4AB);
  late Color info20 = const Color(0x33D1E4FF);
  late Color primary5 = const Color(0x0DD1E4FF);
  late Color primary20 = const Color(0x33D1E4FF);
}

class FFDesignTokens {
  const FFDesignTokens(this.theme);
  final FlutterFlowTheme theme;
  FFSpacing get spacing => const FFSpacing();
  FFRadius get radius => const FFRadius();
  FFShadows get shadow => FFShadows(theme);
}

class FFSpacing {
  const FFSpacing();
  double get none => 0.0;
  double get xs => 4.0;
  double get sm => 8.0;
  double get md => 16.0;
  double get lg => 24.0;
  double get xl => 32.0;
  double get xxl => 48.0;
  double get xxxl => 64.0;
}

class FFRadius {
  const FFRadius();
  double get none => 0.0;
  double get xs => 2.0;
  double get sm => 4.0;
  double get md => 6.0;
  double get lg => 12.0;
  double get xl => 16.0;
  double get xxl => 24.0;
  double get full => 9999.0;
}

class FFShadows {
  const FFShadows(this.theme);
  final FlutterFlowTheme theme;
  BoxShadow get lg => const BoxShadow(
      blurRadius: 8.0,
      color: const Color(0x0D000000),
      offset: const Offset(0.0, 4.0),
      spreadRadius: 0.0);
  BoxShadow get xl => const BoxShadow(
      blurRadius: 16.0,
      color: const Color(0x0D000000),
      offset: const Offset(0.0, 8.0),
      spreadRadius: 0.0);
  BoxShadow get xxl => const BoxShadow(
      blurRadius: 24.0,
      color: const Color(0x0D000000),
      offset: const Offset(0.0, 12.0),
      spreadRadius: 0.0);
  BoxShadow get sm => const BoxShadow(
      blurRadius: 2.0,
      color: const Color(0x0D000000),
      offset: const Offset(0.0, 1.0),
      spreadRadius: 0.0);
  BoxShadow get none => const BoxShadow(
      blurRadius: 0.0,
      color: const Color(0x00000000),
      offset: const Offset(0.0, 0.0),
      spreadRadius: 0.0);
  BoxShadow get md => const BoxShadow(
      blurRadius: 4.0,
      color: const Color(0x0D000000),
      offset: const Offset(0.0, 2.0),
      spreadRadius: 0.0);
  BoxShadow get xs => const BoxShadow(
      blurRadius: 1.0,
      color: const Color(0x0A000000),
      offset: const Offset(0.0, 1.0),
      spreadRadius: 0.0);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    String? package,
  }) {
    if (useGoogleFonts && fontFamily != null) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }

    return font != null
        ? font.copyWith(
            color: color ?? this.color,
            fontSize: fontSize ?? this.fontSize,
            letterSpacing: letterSpacing ?? this.letterSpacing,
            fontWeight: fontWeight ?? this.fontWeight,
            fontStyle: fontStyle ?? this.fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          )
        : copyWith(
            fontFamily: fontFamily,
            package: package,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          );
  }
}

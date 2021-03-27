import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/utils/app_assets.dart';
import 'package:math_app_for_kid/utils/app_config.dart';

class AppTheme {
  AppTheme._();

  /// Default theme
  factory AppTheme.origin() {
    return AppTheme._();
  }

  /// Default theme
  factory AppTheme.light() {
    return AppTheme._()
      ..assets = AppAssets.origin()
      ..isDark = false
      ..primaryColor = Colors.white
      ..accentColor = Colors.white
      ..backgroundColor = Colors.white
      ..headerBgColor = Colors.white;
  }

  AppAssets assets = AppAssets.origin();

  double defaultSpacing = 8.0;

  bool isDark = true;
  Color primaryColor = Color(0xFF845EC2);
  Color accentColor = Colors.blueGrey;
  Color backgroundColor = Color(0xFF845EC2);
  Color cardBackgroundColor = Color(0xFF333366);
  Color headerBgColor = Colors.blueGrey;

  Color successColor = Color(0xFF00C9A7);
  Color errorColor = Color(0xFFFF9671);
  Color warningColor = Color(0xFFF9F871);

  double spacing(double value) {
    return (value * defaultSpacing).floorToDouble();
  }

  /// Build theme data
  ThemeData buildThemeData() {
    return ThemeData(
      primaryColor: primaryColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      fontFamily: assets.fontFira,
      pageTransitionsTheme: _buildPageTransitionsTheme(),
      buttonTheme: _buildButtonTheme(),
      textTheme: _buildTextTheme(),
    );
  }

  /// Custom page transitions theme
  PageTransitionsTheme _buildPageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
      },
    );
  }

  /// Custom button theme full width
  ButtonThemeData _buildButtonTheme() {
    return ButtonThemeData(
      minWidth: double.infinity,
      shape: const Border(),
      buttonColor: accentColor,
      textTheme: ButtonTextTheme.primary,
      padding: const EdgeInsets.all(16),
    );
  }

  /// Custom text theme
  TextTheme _buildTextTheme() {
    return const TextTheme();
  }
}

class AppThemeProvider with ChangeNotifier {
  AppTheme get theme => AppConfig.I.theme;

  set theme(AppTheme value) {
    AppConfig.I.theme = value;
    notifyListeners();
  }
}

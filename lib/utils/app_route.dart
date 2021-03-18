import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/home/home_page.dart';
import 'package:provider/provider.dart';

class AppRoute {
  factory AppRoute() => _instance;

  AppRoute._private();

  static final AppRoute _instance = AppRoute._private();

  static AppRoute get I => _instance;

  ///#region ROUTE NAMES
  /// -----------------
  static const String routeRoot = '/';

  ///#endregion

  static Widget createProvider<P extends ChangeNotifier>(
      P Function(BuildContext context) provider, Widget child) {
    return ChangeNotifierProvider<P>(
        create: provider,
        builder: (_, __) {
          return child;
        });
  }

  // App route observer ( for watching route change )
  final RouteObserver<Route<dynamic>> routeObserver =
      RouteObserver<Route<dynamic>>();

  // App global navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Get app context
  BuildContext get appContext => navigatorKey.currentContext;

  // Generate route
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeRoot:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => HomePage());
      default:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (_) => HomePage(
                  title: "Page 2",
                ));
    }
  }
}

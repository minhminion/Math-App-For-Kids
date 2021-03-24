import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_app_for_kid/pages/landing/landing_page.dart';
import 'package:math_app_for_kid/pages/lesson/lesson_list_page.dart';
import 'package:math_app_for_kid/pages/splash/splash_screen.dart';
import 'package:math_app_for_kid/widgets/r_fade_route.dart';
import 'package:provider/provider.dart';

class AppRoute {
  ///#region ROUTE NAMES
  /// -----------------
  static const String routeRoot = '/';
  static const String routeLanding = '/landing';
  static const String lessonRoute = '/lesson';

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
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeRoot:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => SplashScreen(),
        );
      case routeLanding:
        return FadeRoute(
          page: LandingPage(),
        );
      case lessonRoute:
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (_) => LessonListPage(),
        );
      default:
        return onUnknownRoute(settings);
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for ${settings.name}'),
        ),
      ),
    );
  }
}

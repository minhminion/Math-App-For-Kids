import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_app_for_kid/pages/game/game_provider.dart';
import 'package:math_app_for_kid/pages/lesson/lession_provider.dart';
import 'package:math_app_for_kid/services/app/app_dialog.dart';
import 'package:math_app_for_kid/services/app/app_loading.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/services/app/auth_provider.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/cache/cache.dart';
import 'package:math_app_for_kid/services/cache/cache_preferences.dart';
import 'package:math_app_for_kid/services/cache/credential.dart';
import 'package:math_app_for_kid/services/rest_api/api_user.dart';
import 'package:math_app_for_kid/services/store/database_helper.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';
import 'package:math_app_for_kid/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> myMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft],
  );
  await DatabaseHelper.dbHelper.initDB();
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<AppRoute>(
          create: (_) => AppRoute(),
        ),
        Provider<Cache>(create: (_) => CachePreferences()),
        ChangeNotifierProvider<Credential>(
            create: (BuildContext context) =>
                Credential(context.read<Cache>())),
        ProxyProvider<Credential, ApiUser>(
            create: (_) => ApiUser(),
            update: (_, Credential credential, ApiUser userApi) {
              return userApi..token = credential.token;
            }),
        Provider<AppDialogProvider>(create: (_) => AppDialogProvider()),
        Provider<AppLoadingProvider>(create: (_) => AppLoadingProvider()),
        ChangeNotifierProvider<AppThemeProvider>(
            create: (_) => AppThemeProvider()),
        ChangeNotifierProvider<AuthProvider>(
            create: (BuildContext context) => AuthProvider(
                  context.read<ApiUser>(),
                  context.read<Credential>(),
                )),
        ChangeNotifierProvider<CharacterProvider>(
          create: (_) => new CharacterProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<LessonProvider>(create: (_) => LessonProvider()),
        ChangeNotifierProvider<GameProvider>(create: (_) => GameProvider()),
        ChangeNotifierProvider<AudioProvider>(create: (_) => AudioProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);
    // Init Page (Check User is logged)
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool hasCredential = true;
      if (hasCredential) {}
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      context.read<AudioProvider>().pauseAll();
    } else if (state == AppLifecycleState.resumed) {
      context.read<AudioProvider>().resumeAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppRoute appRoute = context.watch<AppRoute>();
    final AppTheme appTheme = context.appTheme();

    context
        .read<AudioProvider>()
        .playAudio(AudioType.music, "base/audios/background_audio.mp3");

    return MaterialApp(
      navigatorKey: appRoute.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: appTheme.buildThemeData(),
      initialRoute: AppRoute.routeRoot,
      onGenerateRoute: AppRoute.generateRoute,
      onUnknownRoute: AppRoute.onUnknownRoute,
      navigatorObservers: <NavigatorObserver>[appRoute.routeObserver],
    );
  }
}

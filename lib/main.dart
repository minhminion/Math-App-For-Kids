import 'package:math_app_for_kid/my_app.dart';
import 'package:math_app_for_kid/utils/app_config.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_theme.dart';

Future<void> main() async {
  // Init dev config
  AppConfig(env: Env.dev(), theme: AppTheme.origin());
  await myMain();
}

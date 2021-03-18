import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/app_dialog.dart';
import 'package:math_app_for_kid/services/app/app_loading.dart';
import 'package:math_app_for_kid/services/app/auth_provider.dart';
import 'package:math_app_for_kid/services/rest_api/api_error.dart';
import 'package:math_app_for_kid/services/rest_api/api_error_type.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/utils/app_route.dart';

import 'package:provider/provider.dart';

abstract class PageStateful<T extends StatefulWidget> extends BaseStateful<T>
    with ApiError {
  AuthProvider authProvider;

  @mustCallSuper
  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    authProvider = Provider.of(context, listen: false);
  }

  @override
  Future<int> onApiError(dynamic error) async {
    final ApiErrorType errorType = parseApiErrorType(error);
    if (errorType.message != null && errorType.message.isNotEmpty) {
      await AppDialogProvider.show(context, errorType.message, title: 'Error');
    }
    if (errorType.code == ApiErrorCode.unauthorized) {
      await logout(context);
      return 1;
    }
    return 0;
  }

  /// Logout function
  Future<void> logout(BuildContext context) async {
    await apiCallSafety(
      authProvider.logout,
      onStart: () async {
        AppLoadingProvider.show(context);
      },
      onFinally: () async {
        AppLoadingProvider.hide(context);
        context
            .navigator()
            ?.pushNamedAndRemoveUntil(AppRoute.routeRoot, (_) => false);
      },
      skipOnError: true,
    );
  }
}

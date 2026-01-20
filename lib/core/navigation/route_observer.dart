import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/core/logger/app_logger.dart';

class MyRouteObserver extends AutoRouteObserver {
  final logger = di<AppLogger>();

  @override
  void didPush(Route route, Route? previousRoute) {
    logger.i('Navigated to ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    logger.i('Popped from ${route.settings.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    logger.i('Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

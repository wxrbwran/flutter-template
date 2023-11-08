import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigator_manager.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    if (route != null) {
      NavigatorManager().addRouter(route);
    }
  }

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    if (route != null) {
      NavigatorManager().removeRouter(route);
    }
  }

  @override
  void didRemove(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    if (route != null) {
      NavigatorManager().removeRouter(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null && oldRoute != null) {
      NavigatorManager().replaceRouter(newRoute, oldRoute);
    }
  }
}

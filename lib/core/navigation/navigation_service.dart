import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_service.g.dart';

class NavigationService  {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Pushes a new named route onto the stack
  Future<void> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  // Replaces the current route with a new named route
  Future<void> replaceWith(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop({Object? result}) {
    navigatorKey.currentState!.pop(result);
  }
}

@riverpod
NavigationService navigationService(Ref ref) {
  return NavigationService();
}
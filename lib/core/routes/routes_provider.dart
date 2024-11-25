import 'package:breath_better_bnb_marathon/core/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'routes_provider.g.dart';

@riverpod
RouteFactory routeFactory(Ref ref) {
  return (settings) => generateRoute(settings, ref); // Pass ref to generateRoute
}
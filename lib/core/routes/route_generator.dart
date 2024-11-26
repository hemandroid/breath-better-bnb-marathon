import 'package:breath_better_bnb_marathon/core/routes/route_constants.dart';
import 'package:breath_better_bnb_marathon/core/widgets/no_connectivity.dart';
import 'package:breath_better_bnb_marathon/features/favourites/presentation/favourites_screen.dart';
import 'package:breath_better_bnb_marathon/features/history/presentation/history_screen.dart';
import 'package:breath_better_bnb_marathon/features/home/presentation/home_screen.dart';
import 'package:breath_better_bnb_marathon/features/launcher_screen.dart';
import 'package:breath_better_bnb_marathon/features/precautions/presentation/precaution_detail_screen.dart';
import 'package:breath_better_bnb_marathon/features/precautions/presentation/precautions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Route<dynamic> generateRoute(RouteSettings settings, Ref ref) {

  // Use the appRoutes constants to compare in the switch
  switch (settings.name) {
    case RouteConstants.launchScreen:
      return MaterialPageRoute(builder: (_) => const LauncherScreen());
    case RouteConstants.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    case RouteConstants.history:
      return MaterialPageRoute(builder: (_) => const HistoryScreen());
    case RouteConstants.favourites:
      return MaterialPageRoute(builder: (_) => const FavouritesScreen());
    case RouteConstants.precautions:
      return MaterialPageRoute(builder: (_) => const PrecautionsScreen());
    case RouteConstants.precautionDetail:
      return MaterialPageRoute(builder: (_) => const PrecautionDetailScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => const NoConnectivityScreen(),
      );
  }
}


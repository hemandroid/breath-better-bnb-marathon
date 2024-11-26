import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:breath_better_bnb_marathon/features/favourites/presentation/favourites_screen.dart';
import 'package:breath_better_bnb_marathon/features/history/presentation/history_screen.dart';
import 'package:breath_better_bnb_marathon/features/home/presentation/home_screen.dart';
import '../core/routes/route_constants.dart';

// State provider to track the selected tab index
final selectedTabProvider = StateProvider<int>((ref) => 0);

class LauncherScreen extends ConsumerStatefulWidget {
  const LauncherScreen({super.key});

  @override
  ConsumerState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends ConsumerState<LauncherScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedTabProvider);

    return Scaffold(
      // Body content based on selected tab
      body: _getSelectedScreen(selectedIndex),

      // Bottom Navigation Bar that stays visible across all screens
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  // Get the screen corresponding to the selected tab
  Widget _getSelectedScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const FavouritesScreen();
      case 2:
        return const HistoryScreen();
      default:
        return const HomeScreen(); // Default to Home screen
    }
  }
}

class CustomBottomNavigationBar extends ConsumerWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        ref.read(selectedTabProvider.notifier).state = index;

      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );
  }
}

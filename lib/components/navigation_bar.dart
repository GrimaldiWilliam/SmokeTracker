import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SmokeTracker/screens/home_screen.dart';
import 'package:SmokeTracker/screens/history_screen.dart';
import 'package:SmokeTracker/screens/health_screen.dart';
import '/l10n/app_localizations.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavigationBar({super.key, required this.currentIndex});

  Future<void> _onItemTapped(BuildContext context, int index) async {
    if (index != currentIndex) {
      Widget? targetScreen;

      switch (index) {
        case 0:
          targetScreen = const HomeScreen();
          break;
        case 1:
          print('Dovrei entrare in History Screen');
          targetScreen = HistoryScreen();
          break;
        case 2:
          targetScreen = HealthScreen();
          break;
        default:
          return;
      }

      // Determine the direction of the slide transition
      final direction = index > currentIndex ? Offset(1.0, 0.0) : Offset(-1.0, 0.0);

      _navigateWithCustomTransition(context, targetScreen, direction);
        }
  }

  void _navigateWithCustomTransition(
      BuildContext context, Widget screen, Offset direction) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          final tween = Tween(begin: direction, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300), // Adjust transition duration
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.health_and_safety),
          label: 'Health',
        ),
      ],
    );
  }
}

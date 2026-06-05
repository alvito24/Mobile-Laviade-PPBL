import 'package:flutter/material.dart';

import '../core/constants/app_spacing.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/manage/manage_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../widgets/app_bottom_nav.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  void _setTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      CartScreen(onContinueBrowsing: () => _setTab(0)),
      const ManageScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: IndexedStack(index: _currentIndex, children: screens),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: _setTab,
      ),
    );
  }
}

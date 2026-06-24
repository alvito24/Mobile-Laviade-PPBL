import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'data/preferences/preference_helper.dart';
import 'providers/insight_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_note_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/splash/splash_screen.dart';

class LaviadeApp extends StatefulWidget {
  const LaviadeApp({super.key});

  @override
  State<LaviadeApp> createState() => _LaviadeAppState();
}

class _LaviadeAppState extends State<LaviadeApp> {
  final _prefs = PreferenceHelper.instance;
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    try {
      final isDarkMode = _prefs.getDarkMode();
      setState(() {
        _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      });
    } catch (e) {
      // Use default light theme on error
    }
  }

  void _updateTheme() {
    _loadThemePreference();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ProductNoteProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => InsightProvider()),
      ],
      child: MaterialApp(
        title: 'Laviade Studio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        home: SplashScreen(onThemeChanged: _updateTheme),
      ),
    );
  }
}

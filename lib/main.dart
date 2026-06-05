import 'package:flutter/material.dart';

import 'app.dart';
import 'data/database/database_helper.dart';
import 'data/preferences/preference_helper.dart';
import 'data/seed/seed_data.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database
  await DatabaseHelper.instance.database;
  
  // Initialize preferences
  await PreferenceHelper.instance.init();
  
  // Run seed data (will only seed if tables are empty)
  await SeedData.runSeeds();
  
  runApp(const LaviadeApp());
}

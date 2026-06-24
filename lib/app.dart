// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/material.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'package:provider/provider.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import 'core/theme/app_theme.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'data/preferences/preference_helper.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'providers/insight_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'providers/order_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'providers/product_note_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'providers/wishlist_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'screens/splash/splash_screen.dart';

// Mendefinisikan class utama untuk bagian fitur ini.
class LaviadeApp extends StatefulWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const LaviadeApp({super.key});

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  State<LaviadeApp> createState() => _LaviadeAppState();
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _LaviadeAppState extends State<LaviadeApp> {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final _prefs = PreferenceHelper.instance;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  ThemeMode _themeMode = ThemeMode.light;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void initState() {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    super.initState();
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    _loadThemePreference();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Theme is still driven by SharedPreferences so Settings can update it safely.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _loadThemePreference() async {
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final isDarkMode = _prefs.getDarkMode();
      // Memperbarui state lokal agar UI menampilkan data terbaru.
      setState(() {
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      // Menutup blok kode agar struktur Dart tetap valid.
      });
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Use default light theme on error
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void _updateTheme() {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    _loadThemePreference();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Providers are registered above MaterialApp so all sub-screens can access them.
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return MultiProvider(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      providers: [
        // Menghubungkan UI dengan state Provider yang ringan.
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        // Menghubungkan UI dengan state Provider yang ringan.
        ChangeNotifierProvider(create: (_) => ProductNoteProvider()),
        // Menghubungkan UI dengan state Provider yang ringan.
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        // Menghubungkan UI dengan state Provider yang ringan.
        ChangeNotifierProvider(create: (_) => InsightProvider()),
      // Menutup blok kode agar struktur Dart tetap valid.
      ],
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      child: MaterialApp(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        title: 'Laviade Studio',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        debugShowCheckedModeBanner: false,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        theme: AppTheme.lightTheme,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        darkTheme: AppTheme.darkTheme,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        themeMode: _themeMode,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        home: SplashScreen(onThemeChanged: _updateTheme),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}

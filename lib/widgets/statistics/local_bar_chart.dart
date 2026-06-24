// Mengambil package atau file lain yang dipakai di file ini.
import 'package:fl_chart/fl_chart.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/material.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_colors.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_radius.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_spacing.dart';

/// fl_chart wrapper for local SQLite statistics; zero values are hidden for clarity.
// Mendefinisikan class utama untuk bagian fitur ini.
class LocalBarChart extends StatelessWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const LocalBarChart({
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    super.key,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.items,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    this.emptyLabel = 'Belum ada data statistik lokal.',
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    this.height = 220,
  // Menutup blok kode agar struktur Dart tetap valid.
  });

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final List<LocalChartItem> items;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String emptyLabel;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final double height;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Hide zero-value bars so an empty database shows a clear empty state instead.
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final visibleItems = items.where((item) => item.value > 0).toList();
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final maxValue = visibleItems.isEmpty
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ? 0
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        : visibleItems.map((item) => item.value).reduce((a, b) => a > b ? a : b);

    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return Container(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      padding: const EdgeInsets.all(AppSpacing.md),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      decoration: BoxDecoration(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        color: AppColors.surface,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        borderRadius: BorderRadius.circular(AppRadius.lg),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        border: Border.all(color: AppColors.border),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      child: Column(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        children: [
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          Text('Distribusi Data Lokal', style: Theme.of(context).textTheme.titleLarge),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.xs),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const Text(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            'Chart dari SQLite lokal. Bukan analytics online dan tidak ada tracking user.',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.lg),
          // Memeriksa kondisi agar alur aplikasi tetap aman.
          if (visibleItems.isEmpty)
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            Text(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              emptyLabel,
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              style: const TextStyle(color: AppColors.textSecondary),
            // Menutup blok kode agar struktur Dart tetap valid.
            )
          // Menangani kondisi alternatif dari percabangan sebelumnya.
          else
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            SizedBox(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              height: height,
              // Menyiapkan visual statistik lokal menggunakan fl_chart.
              child: BarChart(
                // BarChart receives only aggregated local counts, not online analytics data.
                // Menyiapkan visual statistik lokal menggunakan fl_chart.
                BarChartData(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  maxY: maxValue.toDouble() + 1,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  minY: 0,
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  gridData: FlGridData(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    show: true,
                    // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
                    drawVerticalLine: false,
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    getDrawingHorizontalLine: (value) => const FlLine(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      color: AppColors.outlineVariant,
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      strokeWidth: 1,
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  borderData: FlBorderData(show: false),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  titlesData: FlTitlesData(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    leftTitles: AxisTitles(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      sideTitles: SideTitles(
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        showTitles: true,
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        reservedSize: 28,
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        interval: maxValue <= 4 ? 1 : (maxValue / 4).ceilToDouble(),
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        getTitlesWidget: (value, meta) {
                          // Memeriksa kondisi agar alur aplikasi tetap aman.
                          if (value < 0 || value > maxValue + 1) {
                            // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                            return const SizedBox.shrink();
                          // Menutup blok kode agar struktur Dart tetap valid.
                          }
                          // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                          return Text(
                            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                            value.round().toString(),
                            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                            style: const TextStyle(
                              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                              color: AppColors.textSecondary,
                              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                              fontSize: 10,
                            // Menutup blok kode agar struktur Dart tetap valid.
                            ),
                          // Menutup blok kode agar struktur Dart tetap valid.
                          );
                        // Menutup blok kode agar struktur Dart tetap valid.
                        },
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    bottomTitles: AxisTitles(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      sideTitles: SideTitles(
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        showTitles: true,
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        reservedSize: 44,
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        getTitlesWidget: (value, meta) {
                          // Menyimpan nilai yang dipakai oleh alur fitur ini.
                          final index = value.toInt();
                          // Memeriksa kondisi agar alur aplikasi tetap aman.
                          if (index < 0 || index >= visibleItems.length) {
                            // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                            return const SizedBox.shrink();
                          // Menutup blok kode agar struktur Dart tetap valid.
                          }
                          // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                          return Padding(
                            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                            padding: const EdgeInsets.only(top: AppSpacing.xs),
                            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                            child: Text(
                              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                              visibleItems[index].shortLabel,
                              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                              textAlign: TextAlign.center,
                              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                              style: const TextStyle(
                                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                color: AppColors.textSecondary,
                                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                fontSize: 10,
                                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                fontWeight: FontWeight.w700,
                              // Menutup blok kode agar struktur Dart tetap valid.
                              ),
                            // Menutup blok kode agar struktur Dart tetap valid.
                            ),
                          // Menutup blok kode agar struktur Dart tetap valid.
                          );
                        // Menutup blok kode agar struktur Dart tetap valid.
                        },
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  barGroups: List.generate(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    visibleItems.length,
                    // Menyiapkan visual statistik lokal menggunakan fl_chart.
                    (index) => BarChartGroupData(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      x: index,
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      barRods: [
                        // Menyiapkan visual statistik lokal menggunakan fl_chart.
                        BarChartRodData(
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          toY: visibleItems[index].value.toDouble(),
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          width: 18,
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          color: index.isEven ? AppColors.primary : AppColors.accent,
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          borderRadius: BorderRadius.circular(AppRadius.base),
                        // Menutup blok kode agar struktur Dart tetap valid.
                        ),
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ],
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  barTouchData: BarTouchData(
                    // Tooltip helps explain the exact local count during demo.
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    enabled: true,
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    touchTooltipData: BarTouchTooltipData(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        // Menyimpan nilai yang dipakai oleh alur fitur ini.
                        final item = visibleItems[group.x];
                        // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                        return BarTooltipItem(
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          '${item.label}\n${item.value}',
                          // Menyimpan nilai yang dipakai oleh alur fitur ini.
                          const TextStyle(
                            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                            color: AppColors.onPrimary,
                            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                            fontWeight: FontWeight.w700,
                          // Menutup blok kode agar struktur Dart tetap valid.
                          ),
                        // Menutup blok kode agar struktur Dart tetap valid.
                        );
                      // Menutup blok kode agar struktur Dart tetap valid.
                      },
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
            // Menutup blok kode agar struktur Dart tetap valid.
            ),
        // Menutup blok kode agar struktur Dart tetap valid.
        ],
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class LocalChartItem {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const LocalChartItem({
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.label,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.shortLabel,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.value,
  // Menutup blok kode agar struktur Dart tetap valid.
  });

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String label;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String shortLabel;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final int value;
// Menutup blok kode agar struktur Dart tetap valid.
}

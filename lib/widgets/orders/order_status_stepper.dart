// Mengambil package atau file lain yang dipakai di file ini.
import 'dart:math' as math;

// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/material.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_colors.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_radius.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_spacing.dart';

/// Custom-drawn status stepper for local order simulation, not delivery tracking.
// Mendefinisikan class utama untuk bagian fitur ini.
class OrderStatusStepper extends StatelessWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const OrderStatusStepper({
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    super.key,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.currentStatus,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    this.onStatusTap,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    this.compact = false,
  // Menutup blok kode agar struktur Dart tetap valid.
  });

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String currentStatus;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final ValueChanged<String>? onStatusTap;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final bool compact;

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  static const List<_OrderStep> _steps = [
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    _OrderStep('dibuat', 'Dibuat'),
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    _OrderStep('diproses', 'Diproses'),
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    _OrderStep('selesai', 'Selesai'),
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    _OrderStep('dibatalkan', 'Dibatalkan'),
  // Menutup blok kode agar struktur Dart tetap valid.
  ];

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  int get _currentIndex {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final normalized = currentStatus.toLowerCase();
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final index = _steps.indexWhere((step) => step.status == normalized);
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return index < 0 ? 0 : index;
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final currentIndex = _currentIndex;

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
          Text('Status Simulasi', style: Theme.of(context).textTheme.titleLarge),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.xs),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const Text(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            'Visual status lokal. Ini bukan tracking pengiriman real.',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.md),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          SizedBox(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            height: compact ? 86 : 106,
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            child: LayoutBuilder(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              builder: (context, constraints) {
                // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                return Stack(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  children: [
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    Positioned.fill(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      top: 8,
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      bottom: compact ? 30 : 44,
                      // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
                      child: CustomPaint(
                        // Painter draws the line and nodes; labels stay as normal widgets for readability.
                        // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
                        painter: _OrderStatusStepperPainter(
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          stepCount: _steps.length,
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          currentIndex: currentIndex,
                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                          isCancelled: _steps[currentIndex].status == 'dibatalkan',
                        // Menutup blok kode agar struktur Dart tetap valid.
                        ),
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    Positioned.fill(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      child: Row(
                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                        children: List.generate(_steps.length, (index) {
                          // Menyimpan nilai yang dipakai oleh alur fitur ini.
                          final step = _steps[index];
                          // Menyimpan nilai yang dipakai oleh alur fitur ini.
                          final isCurrent = index == currentIndex;
                          // Menyimpan nilai yang dipakai oleh alur fitur ini.
                          final isCompleted = index <= currentIndex;
                          // Mengembalikan hasil yang dibutuhkan pemanggil kode.
                          return Expanded(
                            // Menangani interaksi pengguna pada komponen ini.
                            child: GestureDetector(
                              // Tap is the gesture requirement: it updates local simulation status only.
                              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                              behavior: HitTestBehavior.opaque,
                              // Menangani interaksi pengguna pada komponen ini.
                              onTap: onStatusTap == null
                                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                  ? null
                                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                  : () => onStatusTap!(step.status),
                              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                              child: Column(
                                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                mainAxisAlignment: MainAxisAlignment.end,
                                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                children: [
                                  // Menyimpan nilai yang dipakai oleh alur fitur ini.
                                  const SizedBox(height: 46),
                                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                  Text(
                                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                    step.label,
                                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                    textAlign: TextAlign.center,
                                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                    style: TextStyle(
                                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                      color: isCompleted
                                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                          ? AppColors.textPrimary
                                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                          : AppColors.textSecondary,
                                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                      fontSize: compact ? 10 : 11,
                                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                      fontWeight:
                                          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                          isCurrent ? FontWeight.w800 : FontWeight.w700,
                                    // Menutup blok kode agar struktur Dart tetap valid.
                                    ),
                                  // Menutup blok kode agar struktur Dart tetap valid.
                                  ),
                                  // Memeriksa kondisi agar alur aplikasi tetap aman.
                                  if (!compact && isCurrent) ...[
                                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                                    const SizedBox(height: AppSpacing.xs),
                                    // Menyimpan nilai yang dipakai oleh alur fitur ini.
                                    const Text(
                                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                      'aktif',
                                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                      style: TextStyle(
                                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                        color: AppColors.textSecondary,
                                        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                                        fontSize: 10,
                                      // Menutup blok kode agar struktur Dart tetap valid.
                                      ),
                                    // Menutup blok kode agar struktur Dart tetap valid.
                                    ),
                                  // Menutup blok kode agar struktur Dart tetap valid.
                                  ],
                                // Menutup blok kode agar struktur Dart tetap valid.
                                ],
                              // Menutup blok kode agar struktur Dart tetap valid.
                              ),
                            // Menutup blok kode agar struktur Dart tetap valid.
                            ),
                          // Menutup blok kode agar struktur Dart tetap valid.
                          );
                        // Menutup blok kode agar struktur Dart tetap valid.
                        }),
                      // Menutup blok kode agar struktur Dart tetap valid.
                      ),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ],
                // Menutup blok kode agar struktur Dart tetap valid.
                );
              // Menutup blok kode agar struktur Dart tetap valid.
              },
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

/// Draws the visual progress line and circular status nodes manually on canvas.
// Mendefinisikan class utama untuk bagian fitur ini.
class _OrderStatusStepperPainter extends CustomPainter {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const _OrderStatusStepperPainter({
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.stepCount,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.currentIndex,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.isCancelled,
  // Menutup blok kode agar struktur Dart tetap valid.
  });

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final int stepCount;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final int currentIndex;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final bool isCancelled;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void paint(Canvas canvas, Size size) {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (stepCount <= 1) return;

    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final centerY = size.height / 2;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final usableWidth = size.width - 32;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final startX = 16.0;
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final gap = usableWidth / (stepCount - 1);
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final points = List<Offset>.generate(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      stepCount,
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      (index) => Offset(startX + (gap * index), centerY),
    // Menutup blok kode agar struktur Dart tetap valid.
    );

    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final inactivePaint = Paint()
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ..color = AppColors.outlineVariant
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ..strokeWidth = 3
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ..strokeCap = StrokeCap.round;

    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final activePaint = Paint()
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ..color = isCancelled ? AppColors.textSecondary : AppColors.primary
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ..strokeWidth = 4
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ..strokeCap = StrokeCap.round;

    // Base line is always drawn first, then the active segment overlays it.
    // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
    canvas.drawLine(points.first, points.last, inactivePaint);
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final activeEnd = points[math.min(currentIndex, points.length - 1)];
    // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
    canvas.drawLine(points.first, activeEnd, activePaint);

    // Melakukan perulangan untuk memproses data yang tersedia.
    for (var index = 0; index < points.length; index++) {
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final point = points[index];
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final isCurrent = index == currentIndex;
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final isCompleted = index <= currentIndex;

      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final fillPaint = Paint()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..color = isCompleted
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            ? (isCancelled && isCurrent ? AppColors.textSecondary : AppColors.primary)
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            : AppColors.surface;
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final borderPaint = Paint()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..color = isCompleted ? AppColors.primary : AppColors.outlineVariant
        // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
        ..style = PaintingStyle.stroke
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..strokeWidth = isCurrent ? 4 : 2;

      // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
      canvas.drawCircle(point, isCurrent ? 12 : 9, fillPaint);
      // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
      canvas.drawCircle(point, isCurrent ? 12 : 9, borderPaint);

      // Completed nodes get a small check mark to make the progress easy to explain.
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (isCompleted) {
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        final checkPaint = Paint()
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ..color = AppColors.onPrimary
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ..strokeWidth = 2
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ..strokeCap = StrokeCap.round
          // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
          ..style = PaintingStyle.stroke;
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        final path = Path()
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ..moveTo(point.dx - 4, point.dy)
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ..lineTo(point.dx - 1, point.dy + 4)
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ..lineTo(point.dx + 5, point.dy - 5);
        // Menggambar visual custom untuk memenuhi kebutuhan CustomPainter.
        canvas.drawPath(path, checkPaint);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool shouldRepaint(covariant _OrderStatusStepperPainter oldDelegate) {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return oldDelegate.currentIndex != currentIndex ||
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        oldDelegate.stepCount != stepCount ||
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        oldDelegate.isCancelled != isCancelled;
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _OrderStep {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const _OrderStep(this.status, this.label);

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String status;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String label;
// Menutup blok kode agar struktur Dart tetap valid.
}

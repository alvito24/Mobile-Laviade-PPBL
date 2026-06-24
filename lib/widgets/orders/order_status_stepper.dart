import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

class OrderStatusStepper extends StatelessWidget {
  const OrderStatusStepper({
    super.key,
    required this.currentStatus,
    this.onStatusTap,
    this.compact = false,
  });

  final String currentStatus;
  final ValueChanged<String>? onStatusTap;
  final bool compact;

  static const List<_OrderStep> _steps = [
    _OrderStep('dibuat', 'Dibuat'),
    _OrderStep('diproses', 'Diproses'),
    _OrderStep('selesai', 'Selesai'),
    _OrderStep('dibatalkan', 'Dibatalkan'),
  ];

  int get _currentIndex {
    final normalized = currentStatus.toLowerCase();
    final index = _steps.indexWhere((step) => step.status == normalized);
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status Simulasi', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Visual status lokal. Ini bukan tracking pengiriman real.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: compact ? 86 : 106,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Positioned.fill(
                      top: 8,
                      bottom: compact ? 30 : 44,
                      child: CustomPaint(
                        painter: _OrderStatusStepperPainter(
                          stepCount: _steps.length,
                          currentIndex: currentIndex,
                          isCancelled: _steps[currentIndex].status == 'dibatalkan',
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Row(
                        children: List.generate(_steps.length, (index) {
                          final step = _steps[index];
                          final isCurrent = index == currentIndex;
                          final isCompleted = index <= currentIndex;
                          return Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: onStatusTap == null
                                  ? null
                                  : () => onStatusTap!(step.status),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const SizedBox(height: 46),
                                  Text(
                                    step.label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isCompleted
                                          ? AppColors.textPrimary
                                          : AppColors.textSecondary,
                                      fontSize: compact ? 10 : 11,
                                      fontWeight:
                                          isCurrent ? FontWeight.w800 : FontWeight.w700,
                                    ),
                                  ),
                                  if (!compact && isCurrent) ...[
                                    const SizedBox(height: AppSpacing.xs),
                                    const Text(
                                      'aktif',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderStatusStepperPainter extends CustomPainter {
  const _OrderStatusStepperPainter({
    required this.stepCount,
    required this.currentIndex,
    required this.isCancelled,
  });

  final int stepCount;
  final int currentIndex;
  final bool isCancelled;

  @override
  void paint(Canvas canvas, Size size) {
    if (stepCount <= 1) return;

    final centerY = size.height / 2;
    final usableWidth = size.width - 32;
    final startX = 16.0;
    final gap = usableWidth / (stepCount - 1);
    final points = List<Offset>.generate(
      stepCount,
      (index) => Offset(startX + (gap * index), centerY),
    );

    final inactivePaint = Paint()
      ..color = AppColors.outlineVariant
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final activePaint = Paint()
      ..color = isCancelled ? AppColors.textSecondary : AppColors.primary
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(points.first, points.last, inactivePaint);
    final activeEnd = points[math.min(currentIndex, points.length - 1)];
    canvas.drawLine(points.first, activeEnd, activePaint);

    for (var index = 0; index < points.length; index++) {
      final point = points[index];
      final isCurrent = index == currentIndex;
      final isCompleted = index <= currentIndex;

      final fillPaint = Paint()
        ..color = isCompleted
            ? (isCancelled && isCurrent ? AppColors.textSecondary : AppColors.primary)
            : AppColors.surface;
      final borderPaint = Paint()
        ..color = isCompleted ? AppColors.primary : AppColors.outlineVariant
        ..style = PaintingStyle.stroke
        ..strokeWidth = isCurrent ? 4 : 2;

      canvas.drawCircle(point, isCurrent ? 12 : 9, fillPaint);
      canvas.drawCircle(point, isCurrent ? 12 : 9, borderPaint);

      if (isCompleted) {
        final checkPaint = Paint()
          ..color = AppColors.onPrimary
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
        final path = Path()
          ..moveTo(point.dx - 4, point.dy)
          ..lineTo(point.dx - 1, point.dy + 4)
          ..lineTo(point.dx + 5, point.dy - 5);
        canvas.drawPath(path, checkPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _OrderStatusStepperPainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex ||
        oldDelegate.stepCount != stepCount ||
        oldDelegate.isCancelled != isCancelled;
  }
}

class _OrderStep {
  const _OrderStep(this.status, this.label);

  final String status;
  final String label;
}

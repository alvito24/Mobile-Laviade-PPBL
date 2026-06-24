import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

class OrderStatusStepperPlaceholder extends StatelessWidget {
  const OrderStatusStepperPlaceholder({super.key, required this.currentStatus});

  final String currentStatus;

  static const _steps = ['Dibuat', 'Diproses', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _steps.indexOf(currentStatus).clamp(0, _steps.length - 1);

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
          const SizedBox(height: AppSpacing.md),
          Row(
            children: List.generate(_steps.length, (index) {
              final isActive = index <= currentIndex;
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.primary : AppColors.surfaceContainer,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      _steps[index],
                      style: TextStyle(
                        color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'CustomPaint final untuk stepper akan dibuat pada batch custom drawing.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

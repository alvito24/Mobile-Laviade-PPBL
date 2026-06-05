import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_radius.dart';
import '../core/constants/app_spacing.dart';

class StockBadge extends StatelessWidget {
  const StockBadge({super.key, required this.stock});

  final int stock;

  @override
  Widget build(BuildContext context) {
    final isAvailable = stock > 0;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: isAvailable
            ? AppColors.surfaceMuted
            : AppColors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(
          color: isAvailable ? AppColors.border : AppColors.error,
        ),
      ),
      child: Text(
        isAvailable ? 'Stok $stock' : 'Habis',
        style: TextStyle(
          color: isAvailable ? AppColors.textSecondary : AppColors.error,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

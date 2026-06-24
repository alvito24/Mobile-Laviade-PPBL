import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

class LocalBarChartPlaceholder extends StatelessWidget {
  const LocalBarChartPlaceholder({super.key, required this.values});

  final List<ChartBarPreview> values;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.isEmpty
        ? 1
        : values.map((value) => value.amount).reduce((a, b) => a > b ? a : b);

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
          Text('Distribusi Data Lokal', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Placeholder chart tanpa fl_chart. Data real akan dihitung dari SQLite.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (values.isEmpty)
            const Text('Belum ada data statistik lokal.')
          else
            ...values.map((value) {
              final widthFactor = value.amount / maxValue;
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  children: [
                    SizedBox(width: 72, child: Text(value.label)),
                    Expanded(
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: widthFactor.clamp(0.08, 1.0),
                        child: Container(
                          height: 18,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(AppRadius.base),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text('${value.amount}'),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}

class ChartBarPreview {
  const ChartBarPreview(this.label, this.amount);

  final String label;
  final int amount;
}

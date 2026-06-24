import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

class LocalBarChart extends StatelessWidget {
  const LocalBarChart({
    super.key,
    required this.items,
    this.emptyLabel = 'Belum ada data statistik lokal.',
    this.height = 220,
  });

  final List<LocalChartItem> items;
  final String emptyLabel;
  final double height;

  @override
  Widget build(BuildContext context) {
    final visibleItems = items.where((item) => item.value > 0).toList();
    final maxValue = visibleItems.isEmpty
        ? 0
        : visibleItems.map((item) => item.value).reduce((a, b) => a > b ? a : b);

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
            'Chart dari SQLite lokal. Bukan analytics online dan tidak ada tracking user.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (visibleItems.isEmpty)
            Text(
              emptyLabel,
              style: const TextStyle(color: AppColors.textSecondary),
            )
          else
            SizedBox(
              height: height,
              child: BarChart(
                BarChartData(
                  maxY: maxValue.toDouble() + 1,
                  minY: 0,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => const FlLine(
                      color: AppColors.outlineVariant,
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: maxValue <= 4 ? 1 : (maxValue / 4).ceilToDouble(),
                        getTitlesWidget: (value, meta) {
                          if (value < 0 || value > maxValue + 1) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            value.round().toString(),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 44,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= visibleItems.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.xs),
                            child: Text(
                              visibleItems[index].shortLabel,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    visibleItems.length,
                    (index) => BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: visibleItems[index].value.toDouble(),
                          width: 18,
                          color: index.isEven ? AppColors.primary : AppColors.accent,
                          borderRadius: BorderRadius.circular(AppRadius.base),
                        ),
                      ],
                    ),
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final item = visibleItems[group.x];
                        return BarTooltipItem(
                          '${item.label}\n${item.value}',
                          const TextStyle(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class LocalChartItem {
  const LocalChartItem({
    required this.label,
    required this.shortLabel,
    required this.value,
  });

  final String label;
  final String shortLabel;
  final int value;
}

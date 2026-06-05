import 'package:flutter/material.dart';

import '../core/constants/app_spacing.dart';
import '../core/utils/currency_formatter.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
    required this.total,
    this.note = 'Cart ini hanya simulasi lokal, bukan checkout real.',
  });

  final int total;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(child: Text('Total sementara')),
                Text(
                  CurrencyFormatter.formatRupiah(total),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(note, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

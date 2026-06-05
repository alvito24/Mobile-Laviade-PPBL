import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/utils/dummy_data.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/stock_badge.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final DummyProduct product;

  void _showAddToCartSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(content: Text('Produk berhasil ditambahkan ke cart.')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
              ),
              child: Center(
                child: Text(
                  product.imageName,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                CategoryChip(
                  label: product.categoryName,
                  isSelected: true,
                  onTap: () {},
                ),
                const SizedBox(width: AppSpacing.sm),
                StockBadge(stock: product.stock),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              CurrencyFormatter.formatRupiah(product.price),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Deskripsi', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              product.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: 'Tambah ke Cart',
              icon: Icons.shopping_bag_outlined,
              onPressed: () => _showAddToCartSnackbar(context),
            ),
          ],
        ),
      ),
    );
  }
}

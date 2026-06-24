import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../widgets/manage_menu_card.dart';
import '../../widgets/section_title.dart';
import '../orders/order_list_screen.dart';
import '../statistics/insight_statistics_screen.dart';
import '../wishlist/wishlist_screen.dart';
import 'manage_category_screen.dart';
import 'manage_product_screen.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const SectionTitle(
          title: 'Manage Data',
          subtitle: 'Hub data lokal untuk katalog dan demo CRUD SQLite.',
        ),
        const SizedBox(height: AppSpacing.lg),
        ManageMenuCard(
          title: 'Manage Product',
          description: 'Tambah, edit, dan hapus data produk demo.',
          icon: Icons.inventory_2_outlined,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const ManageProductScreen(),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ManageMenuCard(
          title: 'Manage Category',
          description: 'Kelola kategori untuk katalog lokal.',
          icon: Icons.category_outlined,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const ManageCategoryScreen(),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ManageMenuCard(
          title: 'Wishlist Lokal',
          description: 'Lihat dan hapus produk favorit yang tersimpan di SQLite.',
          icon: Icons.favorite_border,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const WishlistScreen()),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ManageMenuCard(
          title: 'Simulasi Order Lokal',
          description: 'Pantau riwayat order simulasi tanpa pembayaran real.',
          icon: Icons.receipt_long_outlined,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const OrderListScreen()),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ManageMenuCard(
          title: 'Insight Lokal',
          description: 'Lihat statistik SQLite lokal tanpa analytics online.',
          icon: Icons.bar_chart_outlined,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const InsightStatisticsScreen(),
            ),
          ),
        ),
      ],
    );
  }
}

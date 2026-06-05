import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../widgets/manage_menu_card.dart';
import '../../widgets/section_title.dart';
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
          subtitle: 'Kelola data lokal untuk demo SQLite.',
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
      ],
    );
  }
}

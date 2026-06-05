import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/utils/dummy_data.dart';
import '../../widgets/category_manage_tile.dart';
import '../../widgets/delete_confirmation_dialog.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/primary_button.dart';
import 'category_form_screen.dart';

class ManageCategoryScreen extends StatelessWidget {
  const ManageCategoryScreen({super.key});

  void _openForm(BuildContext context, {DummyCategory? category}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CategoryFormScreen(category: category),
      ),
    );
  }

  void _showDelete(BuildContext context, DummyCategory category) {
    if (category.isUsed) {
      showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Kategori tidak bisa dihapus'),
          content: const Text(
            'Kategori tidak bisa dihapus karena masih digunakan produk.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: 'Hapus kategori?',
        description: 'Kategori ini akan dihapus dari database lokal.',
        onConfirm: () => ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            const SnackBar(content: Text('Kategori berhasil dihapus.')),
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = DummyData.categories
        .where((category) => category.id != 0)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Category')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: categories.isEmpty ? 2 : categories.length + 1,
          separatorBuilder: (_, index) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            if (index == 0) {
              return PrimaryButton(
                label: 'Tambah Kategori',
                icon: Icons.add,
                onPressed: () => _openForm(context),
              );
            }

            if (categories.isEmpty) {
              return EmptyState(
                title: 'Belum ada kategori.',
                description:
                    'Tambahkan kategori pertama untuk mengelompokkan produk lokal.',
                actionLabel: 'Tambah Kategori',
                onAction: () => _openForm(context),
              );
            }

            final category = categories[index - 1];
            return CategoryManageTile(
              name: category.name,
              note: category.isUsed
                  ? 'Masih digunakan produk'
                  : 'Belum digunakan produk',
              onEdit: () => _openForm(context, category: category),
              onDelete: () => _showDelete(context, category),
            );
          },
        ),
      ),
    );
  }
}

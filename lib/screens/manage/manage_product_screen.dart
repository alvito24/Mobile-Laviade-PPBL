import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/utils/dummy_data.dart';
import '../../widgets/delete_confirmation_dialog.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/product_manage_tile.dart';
import 'product_form_screen.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({super.key});

  void _openForm(BuildContext context, {DummyProduct? product}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductFormScreen(product: product),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: 'Hapus produk?',
        description: 'Produk ini akan dihapus dari database lokal.',
        onConfirm: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil dihapus.')),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Product')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: DummyData.products.length + 1,
          separatorBuilder: (_, index) => const SizedBox(height: AppSpacing.sm),
          itemBuilder: (context, index) {
            if (index == 0) {
              return PrimaryButton(
                label: 'Tambah Produk',
                icon: Icons.add,
                onPressed: () => _openForm(context),
              );
            }

            final product = DummyData.products[index - 1];
            return ProductManageTile(
              name: product.name,
              categoryName: product.categoryName,
              price: product.price,
              stock: product.stock,
              onEdit: () => _openForm(context, product: product),
              onDelete: () => _showDeleteDialog(context),
            );
          },
        ),
      ),
    );
  }
}

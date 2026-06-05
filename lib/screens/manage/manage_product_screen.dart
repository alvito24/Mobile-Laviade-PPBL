import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../data/database/database_helper.dart';
import '../../models/product_model.dart';
import '../../widgets/delete_confirmation_dialog.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/product_manage_tile.dart';
import 'product_form_screen.dart';

class ManageProductScreen extends StatefulWidget {
  const ManageProductScreen({super.key});

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final _db = DatabaseHelper.instance;

  Future<void> _openForm(BuildContext context, {ProductModel? product}) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductFormScreen(product: product),
      ),
    );
    // Refresh data setelah kembali dari form
    setState(() {});
  }

  Future<void> _showDeleteDialog(BuildContext context, int productId) async {
    showDialog<void>(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: 'Hapus produk?',
        description: 'Produk ini akan dihapus dari database lokal.',
        onConfirm: () => _deleteProduct(productId),
      ),
    );
  }

  Future<void> _deleteProduct(int id) async {
    try {
      await _db.deleteProduct(id);
      if (!mounted) return;
      
      setState(() {});
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Produk berhasil dihapus.')),
        );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal menghapus produk: $e')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Product')),
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>>(
          future: _db.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Data produk gagal dimuat.',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ElevatedButton(
                        onPressed: () => setState(() {}),
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final products = snapshot.data ?? [];

            return ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: products.isEmpty ? 2 : products.length + 1,
              separatorBuilder: (_, index) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return PrimaryButton(
                    label: 'Tambah Produk',
                    icon: Icons.add,
                    onPressed: () => _openForm(context),
                  );
                }

                if (products.isEmpty) {
                  return EmptyState(
                    title: 'Belum ada produk.',
                    description:
                        'Tambahkan produk pertama untuk katalog lokal Laviade.',
                    actionLabel: 'Tambah Produk',
                    onAction: () => _openForm(context),
                  );
                }

                final product = products[index - 1];
                return ProductManageTile(
                  name: product.name,
                  categoryName: product.categoryName ?? 'Unknown',
                  price: product.price,
                  stock: product.stock,
                  onEdit: () => _openForm(context, product: product),
                  onDelete: () => _showDeleteDialog(context, product.id!),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../data/database/database_helper.dart';
import '../../models/category_model.dart';
import '../../widgets/category_manage_tile.dart';
import '../../widgets/delete_confirmation_dialog.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/primary_button.dart';
import 'category_form_screen.dart';

class ManageCategoryScreen extends StatefulWidget {
  const ManageCategoryScreen({super.key});

  @override
  State<ManageCategoryScreen> createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen> {
  final _db = DatabaseHelper.instance;

  Future<void> _openForm(BuildContext context, {CategoryModel? category}) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CategoryFormScreen(category: category),
      ),
    );
    // Refresh data setelah kembali dari form
    setState(() {});
  }

  Future<void> _showDelete(BuildContext context, CategoryModel category) async {
    // Cek apakah kategori masih digunakan oleh produk
    try {
      final products = await _db.getProducts();
      final isUsed = products.any((product) => product.categoryId == category.id);
      
      if (!mounted) return;

      if (isUsed) {
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
          onConfirm: () => _deleteCategory(category.id!),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
    }
  }

  Future<void> _deleteCategory(int id) async {
    try {
      await _db.deleteCategory(id);
      if (!mounted) return;
      
      setState(() {});
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Kategori berhasil dihapus.')),
        );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal menghapus kategori: $e')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Category')),
      body: SafeArea(
        child: FutureBuilder<List<CategoryModel>>(
          future: _db.getCategories(),
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
                        'Data kategori gagal dimuat.',
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

            final categories = snapshot.data ?? [];

            return ListView.separated(
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
                
                return FutureBuilder<List>(
                  // Check if category is used by products
                  future: _db.getProducts().then(
                    (products) => products.where((p) => p.categoryId == category.id).toList(),
                  ),
                  builder: (context, productSnapshot) {
                    final productCount = productSnapshot.data?.length ?? 0;
                    final isUsed = productCount > 0;
                    
                    return CategoryManageTile(
                      name: category.name,
                      note: isUsed
                          ? 'Digunakan $productCount produk'
                          : 'Belum digunakan produk',
                      onEdit: () => _openForm(context, category: category),
                      onDelete: () => _showDelete(context, category),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

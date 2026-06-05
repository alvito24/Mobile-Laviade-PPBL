import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/database_helper.dart';
import '../../models/product_model.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/stock_badge.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _db = DatabaseHelper.instance;
  bool _isAddingToCart = false;

  Future<void> _addToCart(ProductModel product) async {
    if (_isAddingToCart) return;
    
    setState(() => _isAddingToCart = true);

    try {
      await _db.addToCart(product.id!);
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Produk berhasil ditambahkan ke cart.')),
        );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal menambahkan ke cart: $e')),
        );
    } finally {
      if (mounted) {
        setState(() => _isAddingToCart = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: SafeArea(
        child: FutureBuilder<ProductModel?>(
          future: _db.getProductById(widget.productId),
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
                        'Detail produk gagal dimuat.',
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

            final product = snapshot.data;
            if (product == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Produk tidak ditemukan.',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text(
                        'Produk mungkin sudah dihapus dari database lokal.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Kembali ke Katalog'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView(
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
                      product.imageName ?? 'product.png',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    CategoryChip(
                      label: product.categoryName ?? 'Unknown',
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
                  product.description ?? 'Tidak ada deskripsi.',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(
                  label: _isAddingToCart ? 'Menambahkan...' : 'Tambah ke Cart',
                  icon: Icons.shopping_bag_outlined,
                  onPressed: _isAddingToCart ? null : () => _addToCart(product),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

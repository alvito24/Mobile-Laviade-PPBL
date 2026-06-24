import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/database/database_helper.dart';
import '../../models/product_model.dart';
import '../../providers/wishlist_provider.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/stock_badge.dart';
import '../notes/product_note_screen.dart';

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

  Future<void> _toggleWishlist(ProductModel product) async {
    try {
      await context.read<WishlistProvider>().toggleWishlist(product.id!);
      if (!mounted) return;
      final isWishlisted = context
          .read<WishlistProvider>()
          .wishlistedProductIds
          .contains(product.id);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
              isWishlisted
                  ? 'Produk disimpan ke wishlist lokal.'
                  : 'Produk dihapus dari wishlist lokal.',
            ),
          ),
        );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text('Wishlist gagal diperbarui: $e')));
    }
  }

  void _openProductNotes(ProductModel product) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductNoteScreen(
          productId: product.id!,
          productName: product.name,
        ),
      ),
    );
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
              return ErrorState(
                title: 'Detail produk gagal dimuat.',
                onAction: () => setState(() {}),
              );
            }

            final product = snapshot.data;
            if (product == null) {
              return EmptyState(
                title: 'Produk tidak ditemukan.',
                description: 'Produk mungkin sudah dihapus dari database lokal.',
                actionLabel: 'Kembali ke Katalog',
                onAction: () => Navigator.of(context).pop(),
              );
            }

            context.read<WishlistProvider>().isWishlisted(product.id!);

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
                const SizedBox(height: AppSpacing.lg),
                Consumer<WishlistProvider>(
                  builder: (context, provider, _) {
                    final isWishlisted = provider.wishlistedProductIds.contains(product.id);
                    return OutlinedButton.icon(
                      onPressed: () => _toggleWishlist(product),
                      icon: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                      ),
                      label: Text(
                        isWishlisted ? 'Tersimpan di Wishlist' : 'Simpan ke Wishlist',
                      ),
                    );
                  },
                ),
                OutlinedButton.icon(
                  onPressed: () => _openProductNotes(product),
                  icon: const Icon(Icons.note_alt_outlined),
                  label: const Text('Catatan Produk'),
                ),
                const SizedBox(height: AppSpacing.md),
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

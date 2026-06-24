import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_spacing.dart';
import '../../providers/wishlist_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/section_title.dart';
import '../../widgets/wishlist/wishlist_item_tile.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<WishlistProvider>().loadWishlist();
      }
    });
  }

  Future<void> _removeWishlist(int productId, String productName) async {
    try {
      await context.read<WishlistProvider>().removeWishlist(productId);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('$productName dihapus dari wishlist lokal.')),
        );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal menghapus wishlist: $e')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: Consumer<WishlistProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return ErrorState(
              title: provider.errorMessage!,
              onAction: provider.loadWishlist,
            );
          }

          final items = provider.wishlistProducts;

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              const SectionTitle(
                title: 'Wishlist Lokal',
                subtitle: 'Produk favorit tersimpan di SQLite pada perangkat ini.',
              ),
              const SizedBox(height: AppSpacing.lg),
              if (items.isEmpty)
                const EmptyState(
                  title: 'Wishlist masih kosong.',
                  description: 'Simpan produk dari Product Detail untuk mengisi wishlist lokal.',
                )
              else
                ...items.map(
                  (item) {
                    final productId = item['product_id'] as int;
                    final productName = item['product_name'] as String? ?? 'Unknown Product';
                    final price = (item['product_price'] as num?)?.toInt() ?? 0;
                    final stock = (item['product_stock'] as num?)?.toInt() ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: WishlistItemTile(
                        productName: productName,
                        categoryName: item['category_name'] as String? ?? 'Unknown',
                        price: price,
                        statusLabel: 'Stok $stock',
                        onRemove: () => _removeWishlist(productId, productName),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

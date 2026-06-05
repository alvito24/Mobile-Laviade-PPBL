import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../data/database/database_helper.dart';
import '../../models/cart_item_model.dart';
import '../../widgets/cart_item_tile.dart';
import '../../widgets/cart_summary.dart';
import '../../widgets/delete_confirmation_dialog.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.onContinueBrowsing});

  final VoidCallback? onContinueBrowsing;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _db = DatabaseHelper.instance;
  List<CartItemModel> _cartItems = [];
  bool _loading = true;
  bool _updating = false;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    try {
      final items = await _db.getCartItems();
      setState(() {
        _cartItems = items;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _incrementQuantity(CartItemModel item) async {
    if (_updating) return;
    
    setState(() => _updating = true);

    try {
      await _db.updateCartQuantity(item.id!, item.quantity + 1);
      await _loadCart();
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Cart berhasil diperbarui.')),
        );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal memperbarui cart: $e')),
        );
    } finally {
      if (mounted) {
        setState(() => _updating = false);
      }
    }
  }

  Future<void> _decrementQuantity(CartItemModel item) async {
    if (_updating) return;
    if (item.quantity <= 1) return;

    setState(() => _updating = true);

    try {
      await _db.updateCartQuantity(item.id!, item.quantity - 1);
      await _loadCart();
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Cart berhasil diperbarui.')),
        );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal memperbarui cart: $e')),
        );
    } finally {
      if (mounted) {
        setState(() => _updating = false);
      }
    }
  }

  void _showDeleteDialog(CartItemModel item) {
    showDialog<void>(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: 'Hapus item?',
        description: 'Produk ini akan dihapus dari cart lokal.',
        onConfirm: () => _deleteCartItem(item.id!),
      ),
    );
  }

  Future<void> _deleteCartItem(int cartItemId) async {
    try {
      await _db.deleteCartItem(cartItemId);
      await _loadCart();
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Cart berhasil diperbarui.')),
        );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal menghapus item: $e')),
        );
    }
  }

  int _calculateTotal() {
    return _cartItems.fold(0, (sum, item) => sum + item.getSubtotal());
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final total = _calculateTotal();

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const SectionTitle(
          title: 'Cart',
          subtitle: 'Simulasi cart lokal dengan data SQLite.',
        ),
        const SizedBox(height: AppSpacing.lg),
        if (_cartItems.isEmpty)
          EmptyState(
            title: 'Cart masih kosong.',
            description:
                'Tambahkan produk dari katalog untuk melihat simulasi cart lokal.',
            actionLabel: 'Lihat Produk',
            onAction: widget.onContinueBrowsing,
          )
        else
          ..._cartItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: CartItemTile(
                productName: item.productName ?? 'Unknown Product',
                price: item.productPrice ?? 0,
                quantity: item.quantity,
                onIncrement: () => _incrementQuantity(item),
                onDecrement: () => _decrementQuantity(item),
                onDelete: () => _showDeleteDialog(item),
              ),
            ),
          ),
        if (_cartItems.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          CartSummary(total: total),
        ],
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: 'Lanjut Lihat Produk',
          icon: Icons.arrow_back,
          onPressed: widget.onContinueBrowsing,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/cart_item_tile.dart';
import '../../widgets/cart_summary.dart';
import '../../widgets/delete_confirmation_dialog.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/section_title.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.onContinueBrowsing});

  final VoidCallback? onContinueBrowsing;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _quantity = 1;
  bool _isDeleted = false;

  static const int _price = 329000;

  void _showDeleteDialog() {
    showDialog<void>(
      context: context,
      builder: (_) => DeleteConfirmationDialog(
        title: 'Hapus item?',
        description: 'Produk ini akan dihapus dari cart lokal.',
        onConfirm: () {
          setState(() => _isDeleted = true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cart berhasil diperbarui.')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = _isDeleted ? 0 : _price * _quantity;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const SectionTitle(
          title: 'Cart',
          subtitle: 'Simulasi cart lokal dengan data dummy.',
        ),
        const SizedBox(height: AppSpacing.lg),
        if (_isDeleted)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Cart masih kosong',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    'Tambahkan produk dari katalog untuk melihat simulasi cart lokal.',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          )
        else
          CartItemTile(
            productName: 'Black Box Hoodie',
            price: _price,
            quantity: _quantity,
            onIncrement: () => setState(() => _quantity++),
            onDecrement: () {
              if (_quantity > 1) setState(() => _quantity--);
            },
            onDelete: _showDeleteDialog,
          ),
        const SizedBox(height: AppSpacing.md),
        CartSummary(total: total),
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

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/dummy_data.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key, this.product});

  final DummyProduct? product;

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imageNameController;

  int? _categoryId;
  bool _showValidation = false;

  bool get _isEdit => widget.product != null;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    _nameController = TextEditingController(text: product?.name ?? '');
    _priceController = TextEditingController(
      text: product?.price.toString() ?? '',
    );
    _stockController = TextEditingController(
      text: product?.stock.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: product?.description ?? '',
    );
    _imageNameController = TextEditingController(
      text: product?.imageName ?? '',
    );
    _categoryId = product?.categoryId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    _imageNameController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() => _showValidation = true);
    final price = int.tryParse(_priceController.text.trim()) ?? 0;
    final stock = int.tryParse(_stockController.text.trim()) ?? -1;
    final isValid =
        _nameController.text.trim().isNotEmpty &&
        _categoryId != null &&
        price > 0 &&
        stock >= 0;

    if (!isValid) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(content: Text('Produk berhasil disimpan.')),
      );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final categoryOptions = DummyData.categories
        .where((category) => category.id != 0)
        .toList();
    final price = int.tryParse(_priceController.text.trim()) ?? 0;
    final stock = int.tryParse(_stockController.text.trim()) ?? -1;

    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Edit Product' : 'Add Product')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              _isEdit
                  ? 'Edit data produk lokal.'
                  : 'Tambah produk untuk katalog lokal.',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            CustomTextField(
              label: 'Nama produk',
              controller: _nameController,
              errorText: _showValidation && _nameController.text.trim().isEmpty
                  ? 'Nama produk wajib diisi.'
                  : null,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSpacing.md),
            CustomDropdown<DummyCategory>(
              label: 'Kategori',
              items: categoryOptions,
              value:
                  categoryOptions.any((category) => category.id == _categoryId)
                  ? categoryOptions.firstWhere(
                      (category) => category.id == _categoryId,
                    )
                  : null,
              itemLabelBuilder: (category) => category.name,
              errorText: _showValidation && _categoryId == null
                  ? 'Kategori wajib dipilih.'
                  : null,
              onChanged: (category) =>
                  setState(() => _categoryId = category?.id),
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              label: 'Harga',
              controller: _priceController,
              keyboardType: TextInputType.number,
              errorText: _showValidation && price <= 0
                  ? 'Harga harus lebih dari 0.'
                  : null,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              label: 'Stok',
              controller: _stockController,
              keyboardType: TextInputType.number,
              errorText: _showValidation && stock < 0
                  ? 'Stok tidak boleh negatif.'
                  : null,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              label: 'Deskripsi',
              controller: _descriptionController,
              maxLines: 3,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              label: 'Image asset name',
              hintText: 'Contoh: hoodie_black.png',
              controller: _imageNameController,
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(label: 'Simpan Produk', onPressed: _save),
            const SizedBox(height: AppSpacing.sm),
            SecondaryButton(
              label: 'Batal',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../data/database/database_helper.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key, this.product});

  final ProductModel? product;

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _db = DatabaseHelper.instance;
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imageNameController;

  int? _categoryId;
  bool _showValidation = false;
  bool _isSaving = false;
  List<CategoryModel> _categories = [];
  bool _loadingCategories = true;

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
    
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _db.getCategories();
      setState(() {
        _categories = categories;
        _loadingCategories = false;
      });
    } catch (e) {
      setState(() => _loadingCategories = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal memuat kategori: $e')),
        );
    }
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

  Future<void> _save() async {
    setState(() => _showValidation = true);
    
    final name = _nameController.text.trim();
    final price = int.tryParse(_priceController.text.trim()) ?? 0;
    final stock = int.tryParse(_stockController.text.trim()) ?? -1;
    final description = _descriptionController.text.trim();
    final imageName = _imageNameController.text.trim();
    
    final isValid =
        name.isNotEmpty &&
        _categoryId != null &&
        price > 0 &&
        stock >= 0;

    if (!isValid) return;

    setState(() => _isSaving = true);

    try {
      if (_isEdit) {
        // Update existing product
        final updatedProduct = ProductModel(
          id: widget.product!.id,
          categoryId: _categoryId!,
          name: name,
          price: price,
          stock: stock,
          description: description.isEmpty ? null : description,
          imageName: imageName.isEmpty ? null : imageName,
        );
        await _db.updateProduct(updatedProduct);
      } else {
        // Insert new product
        final newProduct = ProductModel(
          categoryId: _categoryId!,
          name: name,
          price: price,
          stock: stock,
          description: description.isEmpty ? null : description,
          imageName: imageName.isEmpty ? null : imageName,
        );
        await _db.insertProduct(newProduct);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Produk berhasil disimpan.')),
        );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal menyimpan produk: $e')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final price = int.tryParse(_priceController.text.trim()) ?? 0;
    final stock = int.tryParse(_stockController.text.trim()) ?? -1;

    if (_loadingCategories) {
      return Scaffold(
        appBar: AppBar(title: Text(_isEdit ? 'Edit Product' : 'Add Product')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_categories.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(_isEdit ? 'Edit Product' : 'Add Product')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum ada kategori.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  'Tambahkan kategori terlebih dahulu sebelum membuat produk.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Kembali'),
                ),
              ],
            ),
          ),
        ),
      );
    }

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
            CustomDropdown<CategoryModel>(
              label: 'Kategori',
              items: _categories,
              value: _categories.any((category) => category.id == _categoryId)
                  ? _categories.firstWhere(
                      (category) => category.id == _categoryId,
                    )
                  : null,
              itemLabelBuilder: (category) => category.name,
              errorText: _showValidation && _categoryId == null
                  ? 'Kategori wajib dipilih.'
                  : null,
              onChanged: (category) => setState(() => _categoryId = category?.id),
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
            PrimaryButton(
              label: _isSaving ? 'Menyimpan...' : 'Simpan Produk',
              onPressed: _isSaving ? null : _save,
            ),
            const SizedBox(height: AppSpacing.sm),
            SecondaryButton(
              label: 'Batal',
              onPressed: _isSaving
                  ? null
                  : () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

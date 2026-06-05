import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../data/database/database_helper.dart';
import '../../models/category_model.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

class CategoryFormScreen extends StatefulWidget {
  const CategoryFormScreen({super.key, this.category});

  final CategoryModel? category;

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _db = DatabaseHelper.instance;
  late final TextEditingController _nameController;
  bool _showValidation = false;
  bool _isSaving = false;

  bool get _isEdit => widget.category != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _showValidation = true);
    
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _isSaving = true);

    try {
      if (_isEdit) {
        // Update existing category
        final updatedCategory = widget.category!.copyWith(name: name);
        await _db.updateCategory(updatedCategory);
      } else {
        // Insert new category
        final newCategory = CategoryModel(name: name);
        await _db.insertCategory(newCategory);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          const SnackBar(content: Text('Kategori berhasil disimpan.')),
        );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(content: Text('Gagal menyimpan kategori: $e')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Edit Category' : 'Add Category')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              _isEdit
                  ? 'Edit kategori lokal.'
                  : 'Tambah kategori untuk katalog lokal.',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            CustomTextField(
              label: 'Nama kategori',
              controller: _nameController,
              errorText: _showValidation && _nameController.text.trim().isEmpty
                  ? 'Nama kategori wajib diisi.'
                  : null,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSpacing.xl),
            PrimaryButton(
              label: _isSaving ? 'Menyimpan...' : 'Simpan Kategori',
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

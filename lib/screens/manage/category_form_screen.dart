import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/utils/dummy_data.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

class CategoryFormScreen extends StatefulWidget {
  const CategoryFormScreen({super.key, this.category});

  final DummyCategory? category;

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  late final TextEditingController _nameController;
  bool _showValidation = false;

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

  void _save() {
    setState(() => _showValidation = true);
    if (_nameController.text.trim().isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kategori berhasil disimpan.')),
    );
    Navigator.of(context).pop();
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
            PrimaryButton(label: 'Simpan Kategori', onPressed: _save),
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

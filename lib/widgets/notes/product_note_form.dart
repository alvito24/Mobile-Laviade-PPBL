import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../custom_text_field.dart';
import '../primary_button.dart';

class ProductNoteForm extends StatefulWidget {
  const ProductNoteForm({
    super.key,
    this.initialNote,
    this.isEditing = false,
    this.isSaving = false,
    this.onCancelEdit,
    this.onSave,
  });

  final String? initialNote;
  final bool isEditing;
  final bool isSaving;
  final VoidCallback? onCancelEdit;
  final ValueChanged<String>? onSave;

  @override
  State<ProductNoteForm> createState() => _ProductNoteFormState();
}

class _ProductNoteFormState extends State<ProductNoteForm> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialNote ?? '');
  }

  @override
  void didUpdateWidget(covariant ProductNoteForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialNote != widget.initialNote) {
      _controller.text = widget.initialNote ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    widget.onSave?.call(_controller.text.trim());
    if (!widget.isEditing) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          label: widget.isEditing ? 'Edit catatan lokal' : 'Catatan lokal',
          hintText: 'Tulis catatan produk untuk data lokal...',
          controller: _controller,
          maxLines: 3,
        ),
        const SizedBox(height: AppSpacing.sm),
        PrimaryButton(
          label: widget.isSaving
              ? 'Menyimpan...'
              : widget.isEditing
                  ? 'Update Catatan'
                  : 'Simpan Catatan',
          icon: Icons.note_add_outlined,
          onPressed: widget.isSaving ? null : _save,
        ),
        if (widget.isEditing && widget.onCancelEdit != null) ...[
          const SizedBox(height: AppSpacing.xs),
          TextButton(
            onPressed: widget.isSaving ? null : widget.onCancelEdit,
            child: const Text('Batal Edit'),
          ),
        ],
      ],
    );
  }
}

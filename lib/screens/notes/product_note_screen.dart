import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_spacing.dart';
import '../../models/product_note_model.dart';
import '../../providers/product_note_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/notes/product_note_card.dart';
import '../../widgets/notes/product_note_form.dart';
import '../../widgets/section_title.dart';

class ProductNoteScreen extends StatefulWidget {
  const ProductNoteScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  final int productId;
  final String productName;

  @override
  State<ProductNoteScreen> createState() => _ProductNoteScreenState();
}

class _ProductNoteScreenState extends State<ProductNoteScreen> {
  ProductNoteModel? _editingNote;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProductNoteProvider>().loadNotes(widget.productId);
      }
    });
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _saveNote(String noteText) async {
    if (noteText.trim().isEmpty) {
      _showSnack('Catatan produk tidak boleh kosong.');
      return;
    }

    setState(() => _isSaving = true);
    try {
      final provider = context.read<ProductNoteProvider>();
      final editingNote = _editingNote;
      if (editingNote == null) {
        await provider.addNote(productId: widget.productId, note: noteText);
        if (!mounted) return;
        _showSnack('Catatan produk tersimpan lokal.');
      } else {
        await provider.updateNote(editingNote.copyWith(note: noteText));
        if (!mounted) return;
        setState(() => _editingNote = null);
        _showSnack('Catatan produk diperbarui.');
      }
    } catch (e) {
      if (!mounted) return;
      _showSnack('Gagal menyimpan catatan: $e');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _deleteNote(ProductNoteModel note) async {
    if (note.id == null) return;

    try {
      await context.read<ProductNoteProvider>().deleteNote(note.id!, widget.productId);
      if (!mounted) return;
      if (_editingNote?.id == note.id) {
        setState(() => _editingNote = null);
      }
      _showSnack('Catatan produk dihapus.');
    } catch (e) {
      if (!mounted) return;
      _showSnack('Gagal menghapus catatan: $e');
    }
  }

  String _formatDate(String value) {
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catatan Produk')),
      body: Consumer<ProductNoteProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return ErrorState(
              title: provider.errorMessage!,
              onAction: () => provider.loadNotes(widget.productId),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              SectionTitle(
                title: 'Catatan Produk Lokal',
                subtitle: 'Catatan untuk ${widget.productName} tersimpan di SQLite lokal.',
              ),
              const SizedBox(height: AppSpacing.lg),
              ProductNoteForm(
                key: ValueKey(_editingNote?.id ?? 'new-note'),
                initialNote: _editingNote?.note,
                isEditing: _editingNote != null,
                isSaving: _isSaving,
                onCancelEdit: () => setState(() => _editingNote = null),
                onSave: _saveNote,
              ),
              const SizedBox(height: AppSpacing.lg),
              if (provider.notes.isEmpty)
                const EmptyState(
                  title: 'Belum ada catatan.',
                  description: 'Tulis catatan produk lokal untuk kebutuhan review katalog.',
                )
              else
                ...provider.notes.map(
                  (note) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: ProductNoteCard(
                      noteText: note.note,
                      createdAt: _formatDate(note.updatedAt),
                      onEdit: () => setState(() => _editingNote = note),
                      onDelete: () => _deleteNote(note),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

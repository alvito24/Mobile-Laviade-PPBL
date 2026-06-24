// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/material.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'package:provider/provider.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_spacing.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/product_note_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../providers/product_note_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/empty_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/error_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/notes/product_note_card.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/notes/product_note_form.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/section_title.dart';

/// Handles local product notes for one selected product.
// Mendefinisikan class utama untuk bagian fitur ini.
class ProductNoteScreen extends StatefulWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const ProductNoteScreen({
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    super.key,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.productId,
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    required this.productName,
  // Menutup blok kode agar struktur Dart tetap valid.
  });

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final int productId;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final String productName;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  State<ProductNoteScreen> createState() => _ProductNoteScreenState();
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _ProductNoteScreenState extends State<ProductNoteScreen> {
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  ProductNoteModel? _editingNote;
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool _isSaving = false;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void initState() {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    super.initState();
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (mounted) {
        // Menghubungkan UI dengan state Provider yang ringan.
        context.read<ProductNoteProvider>().loadNotes(widget.productId);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    });
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void _showSnack(String message) {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    ScaffoldMessenger.of(context)
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ..clearSnackBars()
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ..showSnackBar(SnackBar(content: Text(message)));
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _saveNote(String noteText) async {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (noteText.trim().isEmpty) {
      // Keep validation in UI too so users get feedback before SQLite rejects it.
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _showSnack('Catatan produk tidak boleh kosong.');
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      return;
    // Menutup blok kode agar struktur Dart tetap valid.
    }

    // Memperbarui state lokal agar UI menampilkan data terbaru.
    setState(() => _isSaving = true);
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final provider = context.read<ProductNoteProvider>();
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final editingNote = _editingNote;
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (editingNote == null) {
        // No editing note means the form is creating a new product note.
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        await provider.addNote(productId: widget.productId, note: noteText);
        // Memeriksa kondisi agar alur aplikasi tetap aman.
        if (!mounted) return;
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        _showSnack('Catatan produk tersimpan lokal.');
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      } else {
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        await provider.updateNote(editingNote.copyWith(note: noteText));
        // Memeriksa kondisi agar alur aplikasi tetap aman.
        if (!mounted) return;
        // Memperbarui state lokal agar UI menampilkan data terbaru.
        setState(() => _editingNote = null);
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        _showSnack('Catatan produk diperbarui.');
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _showSnack('Gagal menyimpan catatan: $e');
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    } finally {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (mounted) {
        // Memperbarui state lokal agar UI menampilkan data terbaru.
        setState(() => _isSaving = false);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _deleteNote(ProductNoteModel note) async {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (note.id == null) return;

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menghubungkan UI dengan state Provider yang ringan.
      await context.read<ProductNoteProvider>().deleteNote(note.id!, widget.productId);
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (_editingNote?.id == note.id) {
        // Memperbarui state lokal agar UI menampilkan data terbaru.
        setState(() => _editingNote = null);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _showSnack('Catatan produk dihapus.');
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _showSnack('Gagal menghapus catatan: $e');
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  String _formatDate(String value) {
    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final date = DateTime.tryParse(value);
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (date == null) return value;
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return '${date.day.toString().padLeft(2, '0')}/'
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return Scaffold(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      appBar: AppBar(title: const Text('Catatan Produk')),
      // Menghubungkan UI dengan state Provider yang ringan.
      body: Consumer<ProductNoteProvider>(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        builder: (context, provider, _) {
          // Memeriksa kondisi agar alur aplikasi tetap aman.
          if (provider.isLoading) {
            // Mengembalikan hasil yang dibutuhkan pemanggil kode.
            return const Center(child: CircularProgressIndicator());
          // Menutup blok kode agar struktur Dart tetap valid.
          }

          // Memeriksa kondisi agar alur aplikasi tetap aman.
          if (provider.errorMessage != null) {
            // Mengembalikan hasil yang dibutuhkan pemanggil kode.
            return ErrorState(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              title: provider.errorMessage!,
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              onAction: () => provider.loadNotes(widget.productId),
            // Menutup blok kode agar struktur Dart tetap valid.
            );
          // Menutup blok kode agar struktur Dart tetap valid.
          }

          // Mengembalikan hasil yang dibutuhkan pemanggil kode.
          return ListView(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            padding: const EdgeInsets.all(AppSpacing.md),
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            children: [
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              SectionTitle(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                title: 'Catatan Produk Lokal',
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                subtitle: 'Catatan untuk ${widget.productName} tersimpan di SQLite lokal.',
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SizedBox(height: AppSpacing.lg),
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              ProductNoteForm(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                key: ValueKey(_editingNote?.id ?? 'new-note'),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                initialNote: _editingNote?.note,
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                isEditing: _editingNote != null,
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                isSaving: _isSaving,
                // Memperbarui state lokal agar UI menampilkan data terbaru.
                onCancelEdit: () => setState(() => _editingNote = null),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                onSave: _saveNote,
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
              // Menyimpan nilai yang dipakai oleh alur fitur ini.
              const SizedBox(height: AppSpacing.lg),
              // Memeriksa kondisi agar alur aplikasi tetap aman.
              if (provider.notes.isEmpty)
                // Menyimpan nilai yang dipakai oleh alur fitur ini.
                const EmptyState(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  title: 'Belum ada catatan.',
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  description: 'Tulis catatan produk lokal untuk kebutuhan review katalog.',
                // Menutup blok kode agar struktur Dart tetap valid.
                )
              // Menangani kondisi alternatif dari percabangan sebelumnya.
              else
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                ...provider.notes.map(
                  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                  (note) => Padding(
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                    child: ProductNoteCard(
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      noteText: note.note,
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      createdAt: _formatDate(note.updatedAt),
                      // Memperbarui state lokal agar UI menampilkan data terbaru.
                      onEdit: () => setState(() => _editingNote = note),
                      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                      onDelete: () => _deleteNote(note),
                    // Menutup blok kode agar struktur Dart tetap valid.
                    ),
                  // Menutup blok kode agar struktur Dart tetap valid.
                  ),
                // Menutup blok kode agar struktur Dart tetap valid.
                ),
            // Menutup blok kode agar struktur Dart tetap valid.
            ],
          // Menutup blok kode agar struktur Dart tetap valid.
          );
        // Menutup blok kode agar struktur Dart tetap valid.
        },
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}

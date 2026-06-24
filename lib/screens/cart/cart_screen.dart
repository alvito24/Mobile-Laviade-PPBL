// Mengambil package atau file lain yang dipakai di file ini.
import 'package:flutter/material.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import 'package:provider/provider.dart';

// Mengambil package atau file lain yang dipakai di file ini.
import '../../core/constants/app_spacing.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../data/database/database_helper.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../data/preferences/preference_helper.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../models/cart_item_model.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../providers/order_provider.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/cart_item_tile.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/cart_summary.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/delete_confirmation_dialog.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/empty_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/error_state.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/primary_button.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../../widgets/section_title.dart';
// Mengambil package atau file lain yang dipakai di file ini.
import '../orders/order_list_screen.dart';

// Mendefinisikan class utama untuk bagian fitur ini.
class CartScreen extends StatefulWidget {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  const CartScreen({super.key, this.onContinueBrowsing});

  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final VoidCallback? onContinueBrowsing;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  State<CartScreen> createState() => _CartScreenState();
// Menutup blok kode agar struktur Dart tetap valid.
}

// Mendefinisikan class utama untuk bagian fitur ini.
class _CartScreenState extends State<CartScreen> {
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final _db = DatabaseHelper.instance;
  // Menyimpan nilai yang dipakai oleh alur fitur ini.
  final _prefs = PreferenceHelper.instance;
  
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  List<CartItemModel> _cartItems = [];
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool _loading = true;
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  bool _updating = false;
  // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
  String? _loadError;

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void initState() {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    super.initState();
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    _saveCartLastOpened();
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    _loadCart();
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _saveCartLastOpened() async {
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await _prefs.saveCartLastOpened();
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Silent fail, not critical
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _loadCart() async {
    // Memperbarui state lokal agar UI menampilkan data terbaru.
    setState(() {
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _loading = true;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      _loadError = null;
    // Menutup blok kode agar struktur Dart tetap valid.
    });

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menyimpan nilai yang dipakai oleh alur fitur ini.
      final items = await _db.getCartItems();
      // Memperbarui state lokal agar UI menampilkan data terbaru.
      setState(() {
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        _cartItems = items;
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        _loading = false;
      // Menutup blok kode agar struktur Dart tetap valid.
      });
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Memperbarui state lokal agar UI menampilkan data terbaru.
      setState(() {
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        _loading = false;
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        _loadError = 'Cart gagal dimuat.';
      // Menutup blok kode agar struktur Dart tetap valid.
      });
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _incrementQuantity(CartItemModel item) async {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (_updating) return;
    
    // Memperbarui state lokal agar UI menampilkan data terbaru.
    setState(() => _updating = true);

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.updateCartQuantity(item.id!, item.quantity + 1);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await _loadCart();
      
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SnackBar(content: Text('Cart berhasil diperbarui.')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          SnackBar(content: Text('Gagal memperbarui cart: $e')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    } finally {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (mounted) {
        // Memperbarui state lokal agar UI menampilkan data terbaru.
        setState(() => _updating = false);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _decrementQuantity(CartItemModel item) async {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (_updating) return;
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (item.quantity <= 1) return;

    // Memperbarui state lokal agar UI menampilkan data terbaru.
    setState(() => _updating = true);

    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.updateCartQuantity(item.id!, item.quantity - 1);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await _loadCart();
      
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SnackBar(content: Text('Cart berhasil diperbarui.')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          SnackBar(content: Text('Gagal memperbarui cart: $e')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    } finally {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (mounted) {
        // Memperbarui state lokal agar UI menampilkan data terbaru.
        setState(() => _updating = false);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  void _showDeleteDialog(CartItemModel item) {
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    showDialog<void>(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      context: context,
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      builder: (_) => DeleteConfirmationDialog(
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        title: 'Hapus item?',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        description: 'Produk ini akan dihapus dari cart lokal.',
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        onConfirm: () => _deleteCartItem(item.id!),
      // Menutup blok kode agar struktur Dart tetap valid.
      ),
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _deleteCartItem(int cartItemId) async {
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menjalankan akses SQLite untuk menyimpan atau membaca data lokal.
      await _db.deleteCartItem(cartItemId);
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      await _loadCart();
      
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SnackBar(content: Text('Cart berhasil diperbarui.')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          SnackBar(content: Text('Gagal menghapus item: $e')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Creates a local order snapshot from cart; cart is not cleared automatically.
  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  Future<void> _createLocalOrderSimulation() async {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (_cartItems.isEmpty || _updating) return;

    // Memperbarui state lokal agar UI menampilkan data terbaru.
    setState(() => _updating = true);
    // Membungkus proses yang berpotensi gagal agar bisa ditangani.
    try {
      // Menghubungkan UI dengan state Provider yang ringan.
      await context.read<OrderProvider>().createOrderFromCart(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            note: 'Dibuat dari cart lokal. Tidak ada pembayaran real.',
          // Menutup blok kode agar struktur Dart tetap valid.
          );
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SnackBar(content: Text('Simulasi Order Lokal berhasil dibuat.')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
      // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
      Navigator.of(context).push(
        // Mengatur perpindahan screen tanpa mengubah bottom navigation utama.
        MaterialPageRoute<void>(builder: (_) => const OrderListScreen()),
      // Menutup blok kode agar struktur Dart tetap valid.
      );
    // Menangani error supaya aplikasi tidak berhenti mendadak.
    } catch (e) {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (!mounted) return;
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      ScaffoldMessenger.of(context)
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..clearSnackBars()
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        ..showSnackBar(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          SnackBar(content: Text('Gagal membuat Simulasi Order Lokal: $e')),
        // Menutup blok kode agar struktur Dart tetap valid.
        );
    // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
    } finally {
      // Memeriksa kondisi agar alur aplikasi tetap aman.
      if (mounted) {
        // Memperbarui state lokal agar UI menampilkan data terbaru.
        setState(() => _updating = false);
      // Menutup blok kode agar struktur Dart tetap valid.
      }
    // Menutup blok kode agar struktur Dart tetap valid.
    }
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menjalankan fungsi penting untuk kebutuhan fitur ini.
  int _calculateTotal() {
    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return _cartItems.fold(0, (sum, item) => sum + item.getSubtotal());
  // Menutup blok kode agar struktur Dart tetap valid.
  }

  // Menandai bahwa method di bawah mengganti perilaku bawaan parent class.
  @override
  // Membangun tampilan UI berdasarkan state yang sedang aktif.
  Widget build(BuildContext context) {
    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (_loading) {
      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return const Center(child: CircularProgressIndicator());
    // Menutup blok kode agar struktur Dart tetap valid.
    }

    // Memeriksa kondisi agar alur aplikasi tetap aman.
    if (_loadError != null) {
      // Mengembalikan hasil yang dibutuhkan pemanggil kode.
      return ErrorState(title: _loadError!, onAction: _loadCart);
    // Menutup blok kode agar struktur Dart tetap valid.
    }

    // Menyimpan nilai yang dipakai oleh alur fitur ini.
    final total = _calculateTotal();

    // Mengembalikan hasil yang dibutuhkan pemanggil kode.
    return ListView(
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      padding: const EdgeInsets.all(AppSpacing.md),
      // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
      children: [
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        const SectionTitle(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          title: 'Cart',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          subtitle: 'Simulasi cart lokal dengan data SQLite.',
        // Menutup blok kode agar struktur Dart tetap valid.
        ),
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        const SizedBox(height: AppSpacing.lg),
        // Memeriksa kondisi agar alur aplikasi tetap aman.
        if (_cartItems.isEmpty)
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          EmptyState(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            title: 'Cart masih kosong.',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            description:
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                'Tambahkan produk dari katalog untuk melihat simulasi cart lokal.',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            actionLabel: 'Lihat Produk',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            onAction: widget.onContinueBrowsing,
          // Menutup blok kode agar struktur Dart tetap valid.
          )
        // Menangani kondisi alternatif dari percabangan sebelumnya.
        else
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          ..._cartItems.map(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            (item) => Padding(
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
              child: CartItemTile(
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                productName: item.productName ?? 'Unknown Product',
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                price: item.productPrice ?? 0,
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                quantity: item.quantity,
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                onIncrement: () => _incrementQuantity(item),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                onDecrement: () => _decrementQuantity(item),
                // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
                onDelete: () => _showDeleteDialog(item),
              // Menutup blok kode agar struktur Dart tetap valid.
              ),
            // Menutup blok kode agar struktur Dart tetap valid.
            ),
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
        // Memeriksa kondisi agar alur aplikasi tetap aman.
        if (_cartItems.isNotEmpty) ...[
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.md),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          CartSummary(total: total),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.md),
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          PrimaryButton(
            // Wording avoids checkout/payment because this is only local simulation.
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            label: _updating ? 'Membuat Simulasi...' : 'Buat Simulasi Order Lokal',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            icon: Icons.receipt_long_outlined,
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            onPressed: _updating ? null : _createLocalOrderSimulation,
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const SizedBox(height: AppSpacing.xs),
          // Menyimpan nilai yang dipakai oleh alur fitur ini.
          const Text(
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            'Data tersimpan di perangkat. Tidak ada pembayaran real.',
            // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
            textAlign: TextAlign.center,
          // Menutup blok kode agar struktur Dart tetap valid.
          ),
        // Menutup blok kode agar struktur Dart tetap valid.
        ],
        // Menyimpan nilai yang dipakai oleh alur fitur ini.
        const SizedBox(height: AppSpacing.lg),
        // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
        PrimaryButton(
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          label: 'Lanjut Lihat Produk',
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          icon: Icons.arrow_back,
          // Menjalankan bagian kode berikut sesuai alur fitur lokal aplikasi.
          onPressed: widget.onContinueBrowsing,
        // Menutup blok kode agar struktur Dart tetap valid.
        ),
      // Menutup blok kode agar struktur Dart tetap valid.
      ],
    // Menutup blok kode agar struktur Dart tetap valid.
    );
  // Menutup blok kode agar struktur Dart tetap valid.
  }
// Menutup blok kode agar struktur Dart tetap valid.
}

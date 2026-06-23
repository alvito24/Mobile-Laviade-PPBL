# task_breakdown.md
# Tugas Besar Implementation Task Breakdown
## Laviade Studio Mobile — Local Commerce Simulation

Dokumen ini dibuat dari nol karena audit dokumen Assessment 2 menemukan `task_breakdown.md` kosong. Task disusun agar kecil, aman, urut, tidak merusak Assessment 2, tidak menggunakan Maps, tidak menambah backend/payment, dan bisa dipakai sebagai dasar eksekusi bertahap di Antigravity.

---

## Phase 0 — Backup & Baseline Protection

### Task 0.1: Backup Baseline Assessment 2

Tujuan:
Menyimpan kondisi source code dan dokumen Assessment 2 sebelum schema dan fitur Tugas Besar ditambahkan.

Scope:
- Buat branch/tag/commit baseline A2.
- Simpan dokumen A2 lama.
- Catat dependency existing.
- Catat database version existing.

Out of scope:
- Tidak mengubah kode.
- Tidak menambah fitur.

File/folder yang kemungkinan dibuat:
- Tidak ada, kecuali catatan backup internal.

File/folder yang kemungkinan diubah:
- Tidak ada.

Requirement yang dipenuhi:
- Regression safety.
- Baseline protection.

Dependency:
- Tidak ada.

Acceptance criteria:
- Baseline A2 bisa dikembalikan jika implementasi TB gagal.
- Dokumen A2 lama tidak hilang.
- Source code sebelum migration tersimpan.

Manual test:
- Jalankan aplikasi baseline.
- Pastikan Home, Cart, Manage, Settings masih jalan.

Risiko:
- Jika tidak backup, perubahan schema bisa merusak baseline.

Catatan untuk AI Agent:
- Jangan mengubah kode pada task ini.

---

### Task 0.2: Verify Current Code Baseline

Tujuan:
Memastikan kondisi kode real sesuai audit terakhir sebelum implementasi.

Scope:
- Cek struktur `lib/`.
- Cek `pubspec.yaml`.
- Cek `database_helper.dart`.
- Cek `preference_helper.dart`.
- Cek screen existing.
- Cek widget existing.

Out of scope:
- Tidak refactor.
- Tidak autofix.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- Tidak ada.

Requirement yang dipenuhi:
- Ground truth source code.

Dependency:
- Tidak ada.

Acceptance criteria:
- Agent melaporkan kondisi file penting.
- Jika ada mismatch dari audit, tulis “perlu verifikasi manual”.

Manual test:
- `flutter analyze`.
- Run app jika memungkinkan.

Risiko:
- Implementasi TB dibuat berdasarkan asumsi jika verifikasi dilewati.

Catatan untuk AI Agent:
- Jangan mengarang file yang tidak ada.

---

## Phase 1 — Assessment 2 Stabilization Fix

### Task 1.1: Activate Splash as Initial Screen

Tujuan:
Membuat `SplashScreen` menjadi initial screen tanpa merusak theme callback dan MainNavigation.

Scope:
- Baca `app.dart`, `splash_screen.dart`, `main_navigation.dart`.
- Ubah initial home menjadi `SplashScreen` jika aman.
- Pastikan setelah delay masuk `MainNavigation`.
- Pastikan theme/dark mode tetap bekerja.

Out of scope:
- Tidak membuat onboarding.
- Tidak membuat login.
- Tidak redesign splash.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/app.dart`
- `lib/screens/splash/splash_screen.dart` jika perlu.

Requirement yang dipenuhi:
- UI flow.
- A2 stabilization.

Dependency:
- Tidak ada dependency baru.

Acceptance criteria:
- App menampilkan Splash saat dibuka.
- Setelah delay masuk ke Home/MainNavigation.
- Dark mode callback tetap aman.

Manual test:
- Run app dari awal.
- Restart app.
- Pastikan Splash tampil dan tidak crash.

Risiko:
- Callback theme putus jika Splash tidak menerima parameter yang dibutuhkan.

Catatan untuk AI Agent:
- Implementasikan minimal dan jangan membuat onboarding panjang.

---

### Task 1.2: Add Explicit Error State for Home and Cart

Tujuan:
Mengganti silent error pada loading data Home/Cart menjadi error state yang jelas.

Scope:
- Tambahkan local error variable.
- Gunakan `ErrorState` reusable.
- Tambahkan retry action.
- Jangan ubah desain besar.

Out of scope:
- Tidak rewrite query.
- Tidak ubah database schema.
- Tidak menambah dependency.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/screens/home/home_screen.dart`
- `lib/screens/cart/cart_screen.dart`
- `lib/widgets/error_state.dart` jika perlu.

Requirement yang dipenuhi:
- UI state: error.
- Regression safety.

Dependency:
- Tidak ada.

Acceptance criteria:
- Jika load gagal, error UI muncul.
- Retry dapat memanggil load ulang.
- Empty state tetap bekerja.

Manual test:
- Simulasikan throw error sementara jika diperlukan.
- Buka Home/Cart.
- Pastikan error UI muncul.
- Kembalikan simulasi error.

Risiko:
- Error state menimpa empty state jika logic tidak rapi.

Catatan untuk AI Agent:
- Jangan menampilkan raw SQLite error ke user.

---

### Task 1.3: Add Cart Stock Validation

Tujuan:
Mencegah quantity cart melebihi stok produk.

Scope:
- Update `addToCart`.
- Update `updateCartQuantity`.
- Validasi product exists.
- Validasi quantity tidak melebihi stock.
- Tampilkan pesan user-friendly.

Out of scope:
- Tidak membuat order simulation dulu.
- Tidak mengubah UI besar.
- Tidak mengubah schema.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/data/database/database_helper.dart`
- `lib/screens/home/product_detail_screen.dart`
- `lib/screens/cart/cart_screen.dart`

Requirement yang dipenuhi:
- Cart reliability.
- Persiapan order simulation.

Dependency:
- Tidak ada.

Acceptance criteria:
- Add to Cart ditolak jika stok tidak cukup.
- Update quantity ditolak jika melebihi stok.
- Quantity minimum tetap 1.
- Snackbar/error message jelas.

Manual test:
- Set stok produk kecil.
- Add produk melebihi stok.
- Increment quantity melebihi stok.
- Pastikan ditolak.

Risiko:
- Jika validasi hanya di UI, database masih bisa invalid. Validasi sebaiknya ada di helper juga.

Catatan untuk AI Agent:
- Jangan mengubah schema.

---

### Task 1.4: Implement Sort/View Preference Persistence

Tujuan:
Menyelaraskan behavior persist untuk sort/view mode.

Scope:
- Auto-save `product_sort_type` saat user mengubah sort di Home.
- Auto-save `preferred_view_mode` saat user mengubah grid/list di Home.
- Selaraskan value sort dengan helper.
- Pertahankan Settings sebagai tempat pengaturan utama.

Out of scope:
- Tidak membuat sort kompleks.
- Tidak menambah key baru.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/screens/home/home_screen.dart`
- `lib/data/preferences/preference_helper.dart` jika validasi perlu diperbaiki.

Requirement yang dipenuhi:
- SharedPreferences consistency.

Dependency:
- Tidak ada.

Acceptance criteria:
- Sort/view yang diubah di Home tersimpan.
- Setelah app restart, pilihan tetap ada.
- Value sort valid.

Manual test:
- Ubah sort.
- Ubah view grid/list.
- Restart app.
- Pastikan nilai tetap.

Risiko:
- Value sort di Home dan helper tidak konsisten.

Catatan untuk AI Agent:
- Jangan menambah key baru.

---

### Task 1.5: Verify and Remove Unused Dummy Data

Tujuan:
Membersihkan `dummy_data.dart` jika tidak lagi digunakan.

Scope:
- Search semua import/usage `dummy_data.dart`.
- Jika tidak dipakai, hapus file.
- Jika masih dipakai untuk preview/test, dokumentasikan “perlu verifikasi manual”.

Out of scope:
- Tidak menghapus seed data.
- Tidak menghapus model/helper.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/core/utils/dummy_data.dart`
- file import terkait jika ada.

Requirement yang dipenuhi:
- Code cleanliness.

Dependency:
- Tidak ada.

Acceptance criteria:
- Tidak ada unused import.
- App tetap berjalan.
- `flutter analyze` tidak error.

Manual test:
- Run `flutter analyze`.
- Run app.

Risiko:
- File masih dipakai di tempat tersembunyi.

Catatan untuk AI Agent:
- Jangan hapus sebelum memastikan tidak ada reference.

---

## Phase 2 — Database & Local Storage Extension

### Task 2.1: Add SQLite Migration Version 2

Tujuan:
Menyiapkan database upgrade dari version 1 ke version 2.

Scope:
- Naikkan database version.
- Tambahkan `onUpgrade`.
- Tambahkan helper create table modular.
- Jangan drop tabel lama.

Out of scope:
- Belum implement UI fitur baru.
- Belum add provider/chart.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/data/database/database_helper.dart`

Requirement yang dipenuhi:
- SQLite migration.
- Regression safety.

Dependency:
- Tidak ada.

Acceptance criteria:
- Database lama bisa upgrade ke version 2.
- Tabel lama tetap ada.
- Tidak ada data lama yang dihapus.

Manual test:
- Run app dari database existing.
- Pastikan tidak crash.
- Cek data product/category/cart tetap ada.

Risiko:
- Migration gagal jika SQL salah.

Catatan untuk AI Agent:
- Gunakan `CREATE TABLE IF NOT EXISTS`.

---

### Task 2.2: Add Wishlist Table

Tujuan:
Menambahkan tabel `wishlist_items`.

Scope:
- Create table `wishlist_items`.
- Foreign key ke `products`.
- Cegah duplikasi product dengan logic atau unique index jika aman.

Out of scope:
- Belum UI wishlist.
- Belum provider.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/data/database/database_helper.dart`

Requirement yang dipenuhi:
- CRUD 4 foundation.

Dependency:
- SQLite existing.

Acceptance criteria:
- Tabel dibuat saat install/migration.
- Tidak merusak tabel lama.

Manual test:
- Run app.
- Pastikan migration tidak crash.

Risiko:
- Foreign key enforcement perlu verifikasi manual.

Catatan untuk AI Agent:
- Jangan pakai SharedPreferences untuk wishlist.

---

### Task 2.3: Add Order Tables

Tujuan:
Menambahkan tabel `orders` dan `order_items`.

Scope:
- Create `orders`.
- Create `order_items`.
- Tentukan status order lokal.
- Simpan snapshot product name/price.

Out of scope:
- Tidak membuat payment/checkout real.
- Tidak membuat shipping/address.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/data/database/database_helper.dart`

Requirement yang dipenuhi:
- CRUD 5 foundation.
- Order simulation.

Dependency:
- SQLite existing.

Acceptance criteria:
- Tabel order berhasil dibuat.
- Tabel order items berhasil dibuat.
- Relasi order-items jelas.

Manual test:
- Run app setelah migration.
- Tidak crash.

Risiko:
- Order simulation disalahpahami sebagai checkout production.

Catatan untuk AI Agent:
- Gunakan istilah “simulation” di UI/copy.

---

### Task 2.4: Add Product Notes Table

Tujuan:
Menambahkan tabel `product_notes`.

Scope:
- Create table `product_notes`.
- Relasi ke `products`.
- Kolom note text dan timestamps.

Out of scope:
- Tidak membuat review online/rating marketplace.
- Tidak membuat upload media.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/data/database/database_helper.dart`

Requirement yang dipenuhi:
- CRUD 6 foundation.

Dependency:
- SQLite existing.

Acceptance criteria:
- Tabel dibuat.
- Product notes dapat disimpan nanti.

Manual test:
- Run app setelah migration.

Risiko:
- Fitur review bisa melebar ke online review/rating.

Catatan untuk AI Agent:
- Sebut sebagai local note/review sederhana.

---

## Phase 3 — Model, Helper, and Provider Layer

### Task 3.1: Create WishlistItemModel

Tujuan:
Membuat model untuk wishlist.

Scope:
- Field: id, productId, createdAt, updatedAt.
- `fromMap`, `toMap`, `copyWith` jika konsisten dengan model existing.

Out of scope:
- Tidak membuat UI.

File/folder yang kemungkinan dibuat:
- `lib/models/wishlist_item_model.dart`

File/folder yang kemungkinan diubah:
- Tidak ada kecuali export jika ada.

Requirement yang dipenuhi:
- Model layer CRUD wishlist.

Dependency:
- Tidak ada.

Acceptance criteria:
- Model compile.
- Mapping cocok dengan schema.

Manual test:
- `flutter analyze`.

Risiko:
- Nama field Dart dan database tidak sinkron.

Catatan untuk AI Agent:
- Ikuti gaya model existing.

---

### Task 3.2: Create OrderModel and OrderItemModel

Tujuan:
Membuat model untuk order simulation.

Scope:
- `OrderModel`.
- `OrderItemModel`.
- Mapping schema.
- Status order lokal.

Out of scope:
- Tidak membuat UI.
- Tidak membuat payment/order production.

File/folder yang kemungkinan dibuat:
- `lib/models/order_model.dart`
- `lib/models/order_item_model.dart`

File/folder yang kemungkinan diubah:
- Tidak ada.

Requirement yang dipenuhi:
- Model layer order.

Dependency:
- Tidak ada.

Acceptance criteria:
- Model compile.
- Field sesuai technical design.

Manual test:
- `flutter analyze`.

Risiko:
- Snapshot price/name terlupakan.

Catatan untuk AI Agent:
- Simpan snapshot untuk menjaga order lama tetap bisa dibaca walau produk berubah.

---

### Task 3.3: Create ProductNoteModel

Tujuan:
Membuat model note/review lokal produk.

Scope:
- Field: id, productId, noteText, createdAt, updatedAt.
- Mapping.

Out of scope:
- Tidak membuat rating kompleks.

File/folder yang kemungkinan dibuat:
- `lib/models/product_note_model.dart`

File/folder yang kemungkinan diubah:
- Tidak ada.

Requirement yang dipenuhi:
- Model layer notes.

Dependency:
- Tidak ada.

Acceptance criteria:
- Model compile.

Manual test:
- `flutter analyze`.

Risiko:
- Penamaan `review` vs `note` tidak konsisten.

Catatan untuk AI Agent:
- Gunakan nama `ProductNoteModel` agar tidak terlalu marketplace.

---

### Task 3.4: Add Wishlist Database Operations

Tujuan:
Menambahkan operasi CRUD wishlist di `DatabaseHelper`.

Scope:
- `addWishlistItem`
- `getWishlistItems`
- `isProductWishlisted`
- `removeWishlistItem`
- `toggleWishlistItem`

Out of scope:
- Tidak membuat screen.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/data/database/database_helper.dart`

Requirement yang dipenuhi:
- Wishlist CRUD.

Dependency:
- SQLite.

Acceptance criteria:
- Product bisa ditambah ke wishlist.
- Duplicate dicegah.
- Wishlist bisa dibaca dan dihapus.

Manual test:
- Test via UI nanti atau debug call sementara.

Risiko:
- Duplicate wishlist jika logic tidak dicek.

Catatan untuk AI Agent:
- Jangan menyimpan wishlist di SharedPreferences.

---

### Task 3.5: Add Order Database Operations

Tujuan:
Menambahkan operasi order simulation.

Scope:
- `createOrderFromCart`
- `getOrders`
- `getOrderById`
- `getOrderItemsByOrderId`
- `updateOrderStatus`
- `deleteOrder`

Out of scope:
- Tidak payment.
- Tidak shipping.
- Tidak checkout production.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/data/database/database_helper.dart`

Requirement yang dipenuhi:
- Order CRUD.

Dependency:
- SQLite.

Acceptance criteria:
- Order dibuat dari cart.
- Order items snapshot tersimpan.
- Order bisa dibaca, update status, dan delete.

Manual test:
- Nanti dari Cart/Order UI.

Risiko:
- Cart kosong atau stok invalid.

Catatan untuk AI Agent:
- Validasi cart sebelum create order.

---

### Task 3.6: Add Product Note Database Operations

Tujuan:
Menambahkan operasi CRUD product note.

Scope:
- `insertProductNote`
- `getProductNotes`
- `getProductNoteById`
- `updateProductNote`
- `deleteProductNote`

Out of scope:
- Tidak rating online.
- Tidak komentar multi-user.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `lib/data/database/database_helper.dart`

Requirement yang dipenuhi:
- Product Note CRUD.

Dependency:
- SQLite.

Acceptance criteria:
- Note bisa create/read/update/delete.

Manual test:
- Nanti dari Product Detail/Notes UI.

Risiko:
- Note kosong tersimpan jika validasi tidak ada.

Catatan untuk AI Agent:
- Validasi note text.

---

### Task 3.7: Add Provider Dependency and Base Providers

Tujuan:
Menambahkan `provider` dan provider dasar secara terkendali.

Scope:
- Tambah dependency `provider`.
- Setup `MultiProvider` jika aman.
- Buat provider minimal: Theme/Preference, Cart, Wishlist, Order, Statistics.

Out of scope:
- Tidak memindahkan semua logic sekaligus.
- Tidak rewrite screen A2 besar-besaran.

File/folder yang kemungkinan dibuat:
- `lib/providers/theme_provider.dart`
- `lib/providers/cart_provider.dart`
- `lib/providers/wishlist_provider.dart`
- `lib/providers/order_provider.dart`
- `lib/providers/statistics_provider.dart`

File/folder yang kemungkinan diubah:
- `pubspec.yaml`
- `lib/main.dart`
- `lib/app.dart`

Requirement yang dipenuhi:
- Library state management.

Dependency:
- `provider`

Acceptance criteria:
- App compile.
- Provider tidak merusak flow existing.

Manual test:
- `flutter pub get`
- `flutter analyze`
- Run app.

Risiko:
- Theme callback existing konflik.

Catatan untuk AI Agent:
- Integrasi bertahap, jangan rewrite semua.

---

## Phase 4 — Existing Feature Regression Safety

### Task 4.1: Regression Test Product and Category CRUD

Tujuan:
Memastikan Product/Category CRUD existing tidak rusak setelah migration/provider.

Scope:
- Test add/edit/delete product.
- Test add/edit/delete category.
- Test delete category conflict.

Out of scope:
- Tidak menambah fitur baru.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- Bug fix kecil jika ditemukan.

Requirement yang dipenuhi:
- Regression A2.

Dependency:
- Tidak ada.

Acceptance criteria:
- Product/category CRUD tetap berjalan.

Manual test:
- Tambah kategori.
- Tambah produk.
- Edit.
- Delete.
- Conflict delete.

Risiko:
- Migration merusak query existing.

Catatan untuk AI Agent:
- Jangan refactor besar.

---

### Task 4.2: Regression Test Cart and Settings

Tujuan:
Memastikan Cart dan Settings existing tetap aman.

Scope:
- Test Add to Cart.
- Test update quantity.
- Test delete item.
- Test 6 SharedPreferences.

Out of scope:
- Tidak order dulu.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- Bug fix kecil jika ditemukan.

Requirement yang dipenuhi:
- Regression A2.

Dependency:
- Tidak ada.

Acceptance criteria:
- Cart dan Settings tetap bekerja.

Manual test:
- Add item.
- Increment/decrement.
- Save preferences.
- Restart app.

Risiko:
- Provider/preference refresh konflik.

Catatan untuk AI Agent:
- Fix minimal.

---

## Phase 5 — New Feature UI Planning

### Task 5.1: Generate/Review UI with Google Stitch

Tujuan:
Membuat desain high-fidelity untuk screen baru Tugas Besar.

Scope:
- Gunakan `STITCH_PROMPT_TUGAS_BESAR.md`.
- Generate screen baru: Wishlist, Orders, Order Detail, Notes, Statistics.
- Pertahankan screen A2.

Out of scope:
- Belum coding UI final sebelum desain direview.

File/folder yang kemungkinan dibuat:
- Output desain dari Stitch.

File/folder yang kemungkinan diubah:
- Tidak ada di Flutter.

Requirement yang dipenuhi:
- UI planning.

Dependency:
- Google Stitch, bukan Flutter dependency.

Acceptance criteria:
- Desain screen baru tersedia.
- Style konsisten dengan A2.
- Tidak ada Maps/payment/backend UI.

Manual test:
- Audit visual.

Risiko:
- Stitch membuat UI terlalu marketplace/generic.

Catatan untuk AI Agent:
- Coding menunggu design handoff final.

---

## Phase 6 — Wishlist Implementation

### Task 6.1: Implement Wishlist UI

Tujuan:
Membuat screen wishlist sesuai design final.

Scope:
- Wishlist list.
- Empty state.
- Remove action.
- Navigation ke Product Detail.
- Gunakan widget reusable.

Out of scope:
- Tidak chart/order.

File/folder yang kemungkinan dibuat:
- `lib/screens/wishlist/wishlist_screen.dart`
- `lib/widgets/wishlist_item_tile.dart`
- `lib/widgets/wishlist_toggle_button.dart`

File/folder yang kemungkinan diubah:
- `lib/screens/home/home_screen.dart`
- `lib/screens/home/product_detail_screen.dart`
- `lib/screens/manage/manage_screen.dart` atau navigation sesuai desain.

Requirement yang dipenuhi:
- Wishlist feature.
- Custom widget.

Dependency:
- Provider optional.

Acceptance criteria:
- Wishlist tampil.
- Empty state.
- Remove item.
- Toggle dari product.

Manual test:
- Add wishlist.
- Buka Wishlist.
- Remove wishlist.
- Restart app.

Risiko:
- Duplicate wishlist.

Catatan untuk AI Agent:
- Jangan jadikan wishlist online.

---

### Task 6.2: Integrate Wishlist Data

Tujuan:
Menghubungkan UI wishlist ke SQLite/helper/provider.

Scope:
- Load wishlist items.
- Toggle wishlist.
- Remove wishlist.
- Refresh state.

Out of scope:
- Tidak membuat data di SharedPreferences.

File/folder yang kemungkinan dibuat:
- Tidak ada jika model/helper sudah ada.

File/folder yang kemungkinan diubah:
- `wishlist_screen.dart`
- `product_detail_screen.dart`
- `home_screen.dart`
- `wishlist_provider.dart`
- `database_helper.dart` jika kurang method.

Requirement yang dipenuhi:
- Wishlist CRUD.

Dependency:
- SQLite, Provider jika digunakan.

Acceptance criteria:
- Wishlist CRUD berjalan real.

Manual test:
- Create/read/delete/toggle.
- Restart app.

Risiko:
- State tidak refresh setelah toggle.

Catatan untuk AI Agent:
- Pastikan data persist SQLite.

---

## Phase 7 — Order Simulation Implementation

### Task 7.1: Implement Orders and Order Detail UI

Tujuan:
Membuat UI order simulation lokal.

Scope:
- Orders list.
- Order detail.
- Order item list.
- Order status.
- Empty/error/loading state.

Out of scope:
- Tidak payment.
- Tidak shipping/address.

File/folder yang kemungkinan dibuat:
- `lib/screens/orders/orders_screen.dart`
- `lib/screens/orders/order_detail_screen.dart`
- `lib/widgets/order_item_tile.dart`
- `lib/widgets/order_summary_card.dart`

File/folder yang kemungkinan diubah:
- `lib/screens/cart/cart_screen.dart`
- `lib/screens/manage/manage_screen.dart`

Requirement yang dipenuhi:
- Order Simulation CRUD.

Dependency:
- SQLite, Provider optional.

Acceptance criteria:
- Orders screen tampil.
- Order detail tampil.
- Tidak ada payment/shipping copy.

Manual test:
- Navigasi ke Orders.
- Empty state.

Risiko:
- UI terlihat seperti checkout production.

Catatan untuk AI Agent:
- Gunakan istilah “Simulasi Order Lokal”.

---

### Task 7.2: Integrate Create Order from Cart

Tujuan:
Membuat order simulation dari cart.

Scope:
- Button create order di Cart.
- Validasi cart tidak kosong.
- Validasi stok.
- Buat order dan order_items.
- Optional clear cart setelah berhasil.
- Snackbar success.

Out of scope:
- Tidak pembayaran.
- Tidak alamat pengiriman.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `cart_screen.dart`
- `database_helper.dart`
- `order_provider.dart`

Requirement yang dipenuhi:
- Order Create.

Dependency:
- SQLite.

Acceptance criteria:
- Order dibuat dari cart.
- Cart bisa dikosongkan setelah order jika dipilih.
- Order muncul di Orders.

Manual test:
- Isi cart.
- Create order.
- Buka Orders.
- Buka detail.

Risiko:
- Order snapshot salah jika product berubah.

Catatan untuk AI Agent:
- Simpan product_name_snapshot dan price_snapshot.

---

### Task 7.3: Integrate Order Status Update and Delete

Tujuan:
Menyelesaikan update/delete order simulation.

Scope:
- Update status order.
- Delete/cancel order.
- Confirmation dialog.
- Refresh Orders.

Out of scope:
- Tidak tracking real.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `order_detail_screen.dart`
- `orders_screen.dart`
- `database_helper.dart`
- `order_provider.dart`

Requirement yang dipenuhi:
- Order Update/Delete.

Dependency:
- SQLite/Provider.

Acceptance criteria:
- Status order berubah.
- Order bisa delete/cancel.
- UI refresh.

Manual test:
- Update status.
- Delete order.
- Restart app.

Risiko:
- Status value tidak konsisten.

Catatan untuk AI Agent:
- Gunakan enum/string constants sederhana.

---

## Phase 8 — Product Review/Note Implementation

### Task 8.1: Implement Product Notes UI

Tujuan:
Membuat UI note/review lokal produk.

Scope:
- List notes per product.
- Add note form.
- Edit note.
- Delete note.
- Empty state.

Out of scope:
- Tidak rating online.
- Tidak user account.

File/folder yang kemungkinan dibuat:
- `lib/screens/notes/product_notes_screen.dart`
- `lib/screens/notes/product_note_form_screen.dart`
- `lib/widgets/product_note_tile.dart`

File/folder yang kemungkinan diubah:
- `product_detail_screen.dart`

Requirement yang dipenuhi:
- Product Note CRUD.

Dependency:
- SQLite.

Acceptance criteria:
- Notes screen/form tersedia.
- Akses dari Product Detail.

Manual test:
- Buka detail.
- Add note.
- Edit/delete.

Risiko:
- Note dianggap review marketplace.

Catatan untuk AI Agent:
- Copy harus “catatan lokal” atau “review lokal”.

---

### Task 8.2: Integrate Product Notes Data

Tujuan:
Menghubungkan Product Notes UI ke SQLite.

Scope:
- Create/read/update/delete note.
- Validasi note tidak kosong.
- Refresh list.

Out of scope:
- Tidak online review.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `product_notes_screen.dart`
- `product_note_form_screen.dart`
- `database_helper.dart`

Requirement yang dipenuhi:
- CRUD 6.

Dependency:
- SQLite.

Acceptance criteria:
- Product note CRUD real berjalan.
- Data persist.

Manual test:
- Add note.
- Restart.
- Edit/delete.

Risiko:
- productId null/invalid.

Catatan untuk AI Agent:
- Tangani product not found.

---

## Phase 9 — Chart & Statistics Implementation

### Task 9.1: Add fl_chart Dependency

Tujuan:
Menambahkan library chart.

Scope:
- Tambah `fl_chart` di `pubspec.yaml`.
- `flutter pub get`.
- Pastikan app compile.

Out of scope:
- Belum membuat chart screen penuh.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `pubspec.yaml`

Requirement yang dipenuhi:
- Library chart.

Dependency:
- `fl_chart`

Acceptance criteria:
- Dependency terinstall.
- App compile.

Manual test:
- `flutter pub get`
- `flutter analyze`

Risiko:
- Version conflict.

Catatan untuk AI Agent:
- Jangan tambah Maps.

---

### Task 9.2: Add Statistics Database Queries

Tujuan:
Menyiapkan query summary lokal untuk chart.

Scope:
- Product count by category.
- Wishlist count.
- Order count.
- Note count.
- Local dashboard summary.

Out of scope:
- Tidak analytics online.

File/folder yang kemungkinan dibuat:
- `lib/models/statistics_summary_model.dart` jika diperlukan.

File/folder yang kemungkinan diubah:
- `database_helper.dart`
- `statistics_provider.dart`

Requirement yang dipenuhi:
- Chart data source.

Dependency:
- SQLite.

Acceptance criteria:
- Summary bisa dibaca dari SQLite.
- Empty data aman.

Manual test:
- Debug/print summary atau UI nanti.

Risiko:
- Query join salah.

Catatan untuk AI Agent:
- Query harus ringan.

---

### Task 9.3: Implement Statistics Screen

Tujuan:
Membuat screen statistik lokal.

Scope:
- Summary cards.
- Chart produk per kategori.
- Chart/order/wishlist summary jika aman.
- Empty state.

Out of scope:
- Tidak dashboard enterprise.
- Tidak Maps.

File/folder yang kemungkinan dibuat:
- `lib/screens/statistics/statistics_screen.dart`
- `lib/widgets/stat_card.dart`
- `lib/widgets/local_chart_card.dart`

File/folder yang kemungkinan diubah:
- `manage_screen.dart`
- `statistics_provider.dart`

Requirement yang dipenuhi:
- Chart/statistics.
- Custom widget tambahan.

Dependency:
- `fl_chart`, Provider optional.

Acceptance criteria:
- Chart tampil dari data lokal.
- Empty chart state tersedia.
- UI tidak ramai.

Manual test:
- Buka Statistics.
- Tambah data.
- Chart berubah.

Risiko:
- Chart sulit dibaca.

Catatan untuk AI Agent:
- Gunakan warna sesuai design system.

---

## Phase 10 — Custom Widget and Custom Drawing/Gesture

### Task 10.1: Implement OrderStatusStepper with CustomPaint

Tujuan:
Memenuhi requirement custom drawing.

Scope:
- Buat `OrderStatusStepper`.
- Buat `OrderStatusPainter`.
- Tampilkan status order.
- Integrasi ke Order Detail.

Out of scope:
- Tidak animasi kompleks.
- Tidak Maps.

File/folder yang kemungkinan dibuat:
- `lib/widgets/order_status_stepper.dart`
- `lib/painters/order_status_painter.dart`

File/folder yang kemungkinan diubah:
- `order_detail_screen.dart`

Requirement yang dipenuhi:
- Custom drawing/gesture.
- Custom widget tambahan.

Dependency:
- Flutter `CustomPaint`, tidak perlu dependency.

Acceptance criteria:
- Stepper tampil.
- Status aktif terlihat.
- Bisa dijelaskan sebagai custom drawing.

Manual test:
- Buka Order Detail.
- Ubah status.
- Stepper berubah.

Risiko:
- Painter terlalu kompleks.

Catatan untuk AI Agent:
- Buat sederhana: circles + line + label.

---

### Task 10.2: Formalize Custom Widgets per Member

Tujuan:
Memastikan setiap anggota punya custom widget yang bisa dijelaskan.

Scope:
- Pastikan widget anggota 1/2/3 ada.
- Pastikan widget dipakai di screen nyata.
- Catat mapping untuk presentasi.

Out of scope:
- Tidak membuat widget kosmetik tidak terpakai.

File/folder yang kemungkinan dibuat:
- Dokumentasi internal jika perlu.

File/folder yang kemungkinan diubah:
- Widget/screen terkait jika widget belum dipakai.

Requirement yang dipenuhi:
- 1 custom widget per orang.

Dependency:
- Tidak ada.

Acceptance criteria:
- Minimal 3 widget jelas.
- Setiap widget punya props.
- Setiap widget dipakai.

Manual test:
- Buka screen yang memakai widget.

Risiko:
- Widget terlalu sederhana.

Catatan untuk AI Agent:
- Jangan klaim built-in widget sebagai custom widget.

---

## Phase 11 — SharedPreferences Completion

### Task 11.1: Verify 6 SharedPreferences Keys

Tujuan:
Memastikan 6 key existing tetap berjalan.

Scope:
- Test save/load:
  - `user_name`
  - `is_dark_mode`
  - `last_selected_category_id`
  - `product_sort_type`
  - `preferred_view_mode`
  - `cart_last_opened`

Out of scope:
- Tidak tambah key baru.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- `preference_helper.dart`
- `settings_screen.dart`
- `home_screen.dart`
- `cart_screen.dart`

Requirement yang dipenuhi:
- SharedPreferences 2 key per anggota.

Dependency:
- `shared_preferences`

Acceptance criteria:
- 6 key bisa didemokan.
- Persist setelah restart.

Manual test:
- Ubah setting.
- Restart app.
- Cek value.

Risiko:
- IndexedStack membuat refresh tidak langsung.

Catatan untuk AI Agent:
- Jangan simpan data utama di preferences.

---

## Phase 12 — Testing & QA

### Task 12.1: Full CRUD QA

Tujuan:
Memastikan 6 CRUD berjalan.

Scope:
- Category CRUD.
- Product CRUD.
- Cart CRUD.
- Wishlist CRUD.
- Order CRUD.
- Product Note CRUD.

Out of scope:
- Tidak menambah fitur.

File/folder yang kemungkinan dibuat:
- QA checklist jika perlu.

File/folder yang kemungkinan diubah:
- Bug fix kecil.

Requirement yang dipenuhi:
- 6 CRUD.

Dependency:
- SQLite.

Acceptance criteria:
- Semua CRUD pass manual test.

Manual test:
- Test create/read/update/delete masing-masing entity.

Risiko:
- Salah satu CRUD tidak lengkap.

Catatan untuk AI Agent:
- Laporkan hasil per CRUD.

---

### Task 12.2: Persistence QA

Tujuan:
Memastikan SQLite dan SharedPreferences persist.

Scope:
- Test data SQLite setelah restart.
- Test preference setelah restart.

Out of scope:
- Tidak test cloud.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- Bug fix kecil.

Requirement yang dipenuhi:
- Local-first persistence.

Dependency:
- SQLite, SharedPreferences.

Acceptance criteria:
- Data tetap ada setelah app restart.

Manual test:
- Tambah data.
- Restart app.
- Cek data.

Risiko:
- Migration atau seed membuat data duplikat.

Catatan untuk AI Agent:
- Jangan reset database tanpa izin.

---

### Task 12.3: UI/Navigation Regression QA

Tujuan:
Memastikan semua screen bisa dibuka dan tidak overflow.

Scope:
- Screen A2.
- Screen Tugas Besar.
- Bottom nav.
- Push/pop.
- Error/empty/loading.

Out of scope:
- Tidak redesign.

File/folder yang kemungkinan dibuat:
- Tidak ada.

File/folder yang kemungkinan diubah:
- UI bug fix kecil.

Requirement yang dipenuhi:
- Demo readiness.

Dependency:
- Tidak ada.

Acceptance criteria:
- Tidak ada crash.
- Tidak ada overflow fatal.
- Navigasi tidak dead-end.

Manual test:
- Buka semua screen.

Risiko:
- Screen baru membuat Manage terlalu ramai.

Catatan untuk AI Agent:
- Fix minimal.

---

## Phase 13 — Documentation & Presentation Prep

### Task 13.1: Update Final Documentation

Tujuan:
Menyinkronkan dokumen dengan implementasi final.

Scope:
- PRD.
- Technical design.
- Task breakdown.
- Design handoff final setelah Stitch.
- UI tasks final.
- Antigravity prompts final.
- AGENTS final.

Out of scope:
- Tidak mengarang fitur belum jadi.

File/folder yang kemungkinan dibuat/diubah:
- docs terkait.

Requirement yang dipenuhi:
- Documentation readiness.

Dependency:
- Tidak ada.

Acceptance criteria:
- Dokumen sesuai source code final.
- Tidak ada klaim palsu.

Manual test:
- Review dokumen vs app.

Risiko:
- Dokumen menyebut fitur yang belum ada.

Catatan untuk AI Agent:
- Jika belum pasti, tulis “perlu verifikasi manual”.

---

### Task 13.2: Prepare Presentation and Demo Script

Tujuan:
Menyiapkan presentasi final Tugas Besar.

Scope:
- Script 3 orang.
- Demo flow.
- Q&A.
- Penjelasan SQLite.
- Penjelasan SharedPreferences.
- Penjelasan 6 CRUD.
- Penjelasan library.
- Penjelasan custom widget/drawing.

Out of scope:
- Tidak membuat slide jika belum diminta.

File/folder yang kemungkinan dibuat:
- `docs/PRESENTATION_SCRIPT.md` jika diperlukan.

File/folder yang kemungkinan diubah:
- Tidak ada.

Requirement yang dipenuhi:
- Demo readiness.

Dependency:
- Tidak ada.

Acceptance criteria:
- Setiap anggota tahu bagian.
- Demo flow jelas.
- Q&A siap.

Manual test:
- Simulasi presentasi.

Risiko:
- Anggota hanya paham bagiannya sendiri.

Catatan untuk AI Agent:
- Gunakan bahasa natural mahasiswa.

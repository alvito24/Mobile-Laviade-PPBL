# AGENTS_BASE.md
# AI Agent Base Rules — Tugas Besar
## Laviade Studio Mobile — Local Commerce Simulation

File ini adalah aturan dasar untuk AI Agent sebelum UI final Google Stitch selesai. File ini belum menggantikan `AGENTS.md` final. Bagian UI detail akan diperbarui setelah `design_handoff.md` final dibuat dari hasil UI high-fidelity Google Stitch.

---

## 1. Project Context Final

Project final:
**Laviade Studio Mobile — Local Commerce Simulation**

Baseline:
**Laviade Studio Mobile — Local Catalog & Cart**

Platform:
Flutter mobile app, target Android.

Jenis aplikasi:
Local-first mobile commerce simulation untuk katalog produk streetwear Laviade Studio, cart lokal, CRUD lokal, wishlist lokal, order simulation lokal, product note/review lokal, statistik lokal, dan preferensi user.

Project ini:
1. Bukan project baru dari nol.
2. Melanjutkan Assessment 2.
3. Menggunakan source code real sebagai ground truth.
4. Tetap local-first.
5. Tidak menggunakan Maps.
6. Tidak menggunakan backend/API production.
7. Tidak menggunakan payment gateway real.
8. Tidak menjadi marketplace production.

---

## 2. Assessment 2 Baseline Protection Rules

Fitur Assessment 2 berikut harus dipertahankan:

1. Product Catalog.
2. Product Detail.
3. Product CRUD.
4. Category CRUD.
5. Cart Item CRUD.
6. Settings/Preferences.
7. SQLite.
8. SharedPreferences.
9. Bottom Navigation: Home, Cart, Manage, Settings.
10. Reusable widgets.
11. Theme/design system.
12. Seed data.

AI Agent tidak boleh:

1. Menghapus fitur lama tanpa instruksi eksplisit.
2. Mengubah schema lama tanpa migration plan.
3. Menghapus tabel `categories`, `products`, atau `cart_items`.
4. Menghapus 6 key SharedPreferences.
5. Mengubah app menjadi online marketplace.
6. Menambahkan backend/payment/Maps.
7. Melakukan rewrite besar jika task hanya enhancement kecil.

Sebelum mengubah kode, Agent harus membaca file relevan dan menjelaskan rencana.

---

## 3. Source Code Baseline Awareness

Source code real Assessment 2 berdasarkan audit:

1. Struktur `lib/` sudah memiliki `core`, `data`, `models`, `screens`, `widgets`, dan `navigation`.
2. SQLite sudah tersedia melalui `sqflite`.
3. SharedPreferences sudah tersedia.
4. Tabel existing:
   - `categories`
   - `products`
   - `cart_items`
5. Model existing:
   - `CategoryModel`
   - `ProductModel`
   - `CartItemModel`
6. Screen existing:
   - Splash.
   - Home.
   - Product Detail.
   - Cart.
   - Manage.
   - Manage Product.
   - Product Form.
   - Manage Category.
   - Category Form.
   - Settings.
7. Banyak reusable widget sudah tersedia.
8. `SplashScreen` ada tetapi perlu verifikasi apakah sudah menjadi initial screen.
9. `dummy_data.dart` masih ada dan perlu verifikasi manual apakah masih dipakai.
10. Database version baseline adalah 1 dan perlu migration untuk Tugas Besar.

Jika kondisi kode berbeda dari audit, tulis “perlu verifikasi manual” dan jangan mengarang.

---

## 4. Tugas Besar Continuation Rules

Tugas Besar menambahkan:

1. Wishlist lokal.
2. Order simulation lokal.
3. Product note/review lokal.
4. Chart/statistik lokal.
5. Provider state management sederhana.
6. Custom widget per anggota.
7. Custom drawing atau gesture widget.
8. Minimal 6 CRUD.
9. Library non-SQLite:
   - shared_preferences.
   - provider.
   - fl_chart.
   - intl jika digunakan.

Semua fitur baru harus:

1. Local-first.
2. Berbasis SQLite untuk data utama.
3. Tidak merusak fitur A2.
4. Punya UI state.
5. Punya manual test.
6. Mudah dijelaskan saat presentasi.
7. Tidak over-engineered.

---

## 5. Flutter Coding Rules

1. Gunakan Dart/Flutter idiom yang sederhana.
2. Jangan membuat arsitektur enterprise.
3. Pisahkan screen, widget, model, database, preferences, provider.
4. Jangan membuat satu file sangat besar.
5. Jangan menaruh semua logic di UI.
6. Gunakan nama file snake_case.
7. Gunakan class PascalCase.
8. Gunakan variable/method camelCase.
9. Hindari duplikasi logic.
10. Gunakan comments hanya jika membantu.
11. Jangan menambah dependency tanpa izin/task.
12. Setelah coding, jelaskan file yang berubah.
13. Berikan manual testing steps.

---

## 6. SQLite Rules

SQLite adalah storage utama untuk:

1. `categories`
2. `products`
3. `cart_items`
4. `wishlist_items`
5. `orders`
6. `order_items`
7. `product_notes`

Rules:

1. Jangan menyimpan data utama di SharedPreferences.
2. Tambah tabel baru melalui migration.
3. Naikkan database version secara sadar.
4. Gunakan `onUpgrade`.
5. Jangan drop tabel lama tanpa backup.
6. Jangan mengubah nama kolom lama sembarangan.
7. Validasi input sebelum insert/update.
8. Cegah duplikasi data penting seperti wishlist product.
9. Cart quantity harus memperhatikan stok.
10. Order simulation harus menyimpan snapshot product name dan price.
11. Product notes harus terkait product.
12. Query chart/statistics harus lokal dan ringan.

---

## 7. SharedPreferences Rules

SharedPreferences hanya untuk preferensi sederhana.

Key wajib:

1. `user_name`
2. `is_dark_mode`
3. `last_selected_category_id`
4. `product_sort_type`
5. `preferred_view_mode`
6. `cart_last_opened`

Rules:

1. Jangan hapus key existing.
2. Jangan tambah key baru kecuali benar-benar perlu.
3. Jangan simpan product/cart/wishlist/order/note di SharedPreferences.
4. Gunakan default value aman.
5. Pastikan 6 key bisa didemokan.
6. Setiap anggota minimal bertanggung jawab 2 key:
   - Anggota 1: `last_selected_category_id`, `product_sort_type`
   - Anggota 2: `preferred_view_mode`, `cart_last_opened`
   - Anggota 3: `user_name`, `is_dark_mode`

---

## 8. Provider / State Management Rules

Provider boleh digunakan untuk state global sederhana.

Allowed provider:

1. `ThemeProvider`
2. `PreferenceProvider` jika perlu
3. `CartProvider`
4. `WishlistProvider`
5. `OrderProvider`
6. `StatisticsProvider`

Rules:

1. Jangan pindahkan semua state ke Provider.
2. Form lokal tetap boleh pakai `setState`.
3. Provider tidak boleh langsung mengganti semua existing logic tanpa alasan.
4. Provider harus mempermudah refresh antar screen/tab.
5. Provider harus tetap memanggil helper/storage layer, bukan membuat query liar.
6. Jangan memakai Bloc/Riverpod/GetX kecuali diminta.
7. Jangan over-engineer.

---

## 9. Chart Rules

Chart digunakan untuk statistik lokal dengan `fl_chart`.

Allowed chart data:

1. Produk per kategori.
2. Total wishlist.
3. Total order simulation.
4. Total product notes.
5. Ringkasan cart/order lokal.

Rules:

1. Data chart harus dari SQLite lokal.
2. Jangan membuat analytics online.
3. Jangan membuat dashboard enterprise.
4. Jangan pakai terlalu banyak warna.
5. Chart harus punya empty/error/loading state.
6. Chart harus mudah dijelaskan.
7. Jangan memakai Maps.

---

## 10. Custom Widget Rules

Requirement:

1. Minimal 1 custom widget per anggota.
2. Total minimal 3 custom widget.
3. Ada custom widget tambahan.
4. Widget harus reusable.
5. Widget harus punya props/data.
6. Widget harus dipakai di screen nyata.
7. Widget tidak boleh hanya wrapper `onTap`.

Mapping awal:

1. Anggota 1:
   - `ProductCard`
   - `CategoryChip`
   - `WishlistToggleButton`

2. Anggota 2:
   - `CartItemTile`
   - `QuantityControl`
   - `OrderStatusStepper`

3. Anggota 3:
   - `PreferenceSelect`
   - `SettingTile`
   - `StatCard`

---

## 11. Custom Drawing / Gesture Rules

Wajib ada minimal satu custom drawing atau gesture tambahan.

Rekomendasi utama:

`OrderStatusStepper` dengan `CustomPaint`.

Rules:

1. Gunakan `CustomPainter`.
2. Tampilkan status order simulation.
3. Jangan membuat animasi kompleks.
4. Jangan memakai dependency tambahan.
5. Jangan memakai Maps.
6. Widget harus dipakai di Order Detail.
7. Widget harus bisa dijelaskan saat presentasi.

Alternatif jika CustomPaint gagal:

1. Swipe action tile untuk cart/wishlist.
2. Long press quick action.

Namun pilihan utama tetap CustomPaint karena lebih jelas memenuhi requirement.

---

## 12. Library Rules

Allowed/expected libraries:

1. `sqflite` — SQLite.
2. `path` — path database.
3. `shared_preferences` — preferences.
4. `provider` — state management.
5. `fl_chart` — chart/statistics.
6. `intl` — date/currency formatting jika sudah ada/dipakai.

Rules:

1. Jangan menambah library selain daftar di atas tanpa izin.
2. Jangan memakai Maps library.
3. Jangan memakai payment SDK.
4. Jangan memakai backend/API client jika tidak diminta.
5. Jangan memakai state management kompleks lain.
6. Jika dependency belum ada, sebutkan perubahan `pubspec.yaml`.

Forbidden Maps libraries:

1. `google_maps_flutter`
2. `flutter_map`
3. `mapbox_maps_flutter`
4. library Maps lain.

---

## 13. Task Execution Rules

Sebelum coding, Agent harus:

1. Membaca file dokumen relevan.
2. Membaca file source code relevan.
3. Menjelaskan rencana implementasi.
4. Menyebut file yang akan dibaca.
5. Menyebut file yang akan dibuat/diubah.
6. Menyebut scope task.
7. Menyebut out of scope.
8. Menunggu instruksi jika task terlalu besar/ambigu.

Saat coding, Agent harus:

1. Kerjakan hanya scope task.
2. Jangan mengerjakan task berikutnya.
3. Jangan menambah fitur random.
4. Jangan rewrite besar.
5. Jangan menambah dependency tanpa izin.
6. Jangan mengubah schema tanpa migration plan.
7. Jangan merusak fitur A2.
8. Jangan menambah Maps/backend/payment.

Setelah coding, Agent harus:

1. Jelaskan perubahan file satu per satu.
2. Jelaskan manual test.
3. Sebutkan risiko/TODO.
4. Sarankan `flutter analyze`.
5. Jika ada bagian belum pasti, tulis “perlu verifikasi manual”.

---

## 14. Testing Rules

Setiap task harus punya manual test.

Testing final wajib mencakup:

1. Product Catalog.
2. Product Detail.
3. Product CRUD.
4. Category CRUD.
5. Cart CRUD.
6. Wishlist CRUD.
7. Order Simulation CRUD.
8. Product Note CRUD.
9. SharedPreferences 6 key.
10. SQLite persistence.
11. Provider state.
12. Chart/statistics.
13. Custom drawing/gesture.
14. Navigation.
15. UI states.
16. Regression fitur A2.
17. No Maps dependency.
18. No backend/payment production.

---

## 15. Forbidden Actions

Agent tidak boleh:

1. Membuat backend/API production.
2. Membuat payment gateway real.
3. Membuat checkout production.
4. Membuat shipping/address management.
5. Membuat login/register production.
6. Membuat Maps.
7. Menambah Maps dependency.
8. Membuat marketplace multi-seller.
9. Membuat upload image production.
10. Membuat push notification real.
11. Membuat chat/customer service.
12. Menghapus fitur A2.
13. Drop database lama tanpa backup.
14. Menyimpan data utama di SharedPreferences.
15. Menambah dependency random.
16. Membuat UI generic AI template.
17. Membuat dashboard enterprise.
18. Mengklaim fitur selesai jika belum ada di kode.
19. Mengarang file yang tidak ditemukan.
20. Mengabaikan source code real.

---

## 16. No Maps Rule

Project ini secara eksplisit **tidak menggunakan Maps**.

Rules:

1. Jangan menambah UI Maps.
2. Jangan menambah route/location picker.
3. Jangan menambah permission location.
4. Jangan menambah Maps dependency.
5. Jangan menyarankan Maps sebagai improvement.
6. Jika prompt lama menyebut Maps, abaikan dan prioritaskan no Maps rule.

---

## 17. Placeholder — UI Implementation Rules Final

Bagian ini akan diperbarui setelah:

1. UI high-fidelity Tugas Besar selesai dibuat di Google Stitch.
2. Desain diaudit.
3. `design_handoff.md` final dibuat.
4. `UI_IMPLEMENTATION_TASKS.md` final dibuat.

Sementara sebelum UI final:

1. Pertahankan design direction Assessment 2.
2. Jangan redesign total.
3. Gunakan komponen existing.
4. Screen baru harus clean, monochrome, streetwear-inspired.
5. Jangan membuat UI payment/backend/Maps.
6. Chart harus sederhana.
7. Order simulation harus terlihat sebagai simulasi lokal.
8. Wishlist dan notes harus local-only.
9. Gunakan state default/loading/empty/error/success.
10. Flutter-friendly, tidak over-engineered.

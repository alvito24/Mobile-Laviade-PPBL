# AGENTS.md
# AI Coding Agent Rules

## Laviade Studio Mobile — Local Commerce Simulation

### Final Scope Assessment 2 + Tugas Besar

---

## 1. Project Context

Project final adalah **Laviade Studio Mobile — Local Commerce Simulation**, Flutter mobile app local-first untuk katalog produk streetwear Laviade Studio, cart lokal, CRUD lokal, wishlist lokal, Simulasi Order Lokal, Product Review/Note lokal, Insight/Statistics lokal, dan preferences user.

Baseline Assessment 2: **Laviade Studio Mobile — Local Catalog & Cart**. Baseline ini sudah memiliki Product Catalog, Product Detail, Product CRUD, Category CRUD, Cart Item CRUD, Settings/Preferences, SQLite, SharedPreferences, bottom navigation 4 tab, reusable widgets, dan arsitektur local-first.

Tugas Besar adalah extension terkontrol, bukan project baru dari nol.

---

## 2. Assessment 2 Baseline Protection

1. Jangan merusak Home/Product Catalog.
2. Jangan merusak Product Detail dan Add to Cart.
3. Jangan merusak Product CRUD.
4. Jangan merusak Category CRUD.
5. Jangan merusak Cart Item CRUD.
6. Jangan merusak Settings/SharedPreferences 6 key.
7. Jangan mengubah bottom navigation 4 tab tanpa instruksi.
8. Jangan menghapus reusable widgets existing tanpa alasan.
9. Semua extension Tugas Besar harus kompatibel dengan baseline A2.

---

## 3. Source Code Ground Truth Rules

1. Source code real adalah ground truth teknis.
2. Jika dokumen menyebut file yang belum ada, verifikasi struktur project dulu.
3. Jika kode memiliki file berbeda dari dokumen, ikuti kode real dan dokumentasikan.
4. Jangan mengarang file.
5. Jangan rewrite project dari nol.
6. Jika ada hal tidak pasti, tulis **perlu verifikasi manual**.

---

## 4. Tugas Besar Extension Rules

Allowed dengan batasan:
- Wishlist lokal.
- Simulasi Order Lokal.
- Product Review/Note lokal.
- Insight/Statistics lokal.
- Provider terbatas untuk global state ringan.
- Chart lokal dengan `fl_chart`.
- CustomPaint atau gesture tambahan.
- SQLite migration aman.

Semua fitur baru harus local-first dan bisa dijelaskan sebagai requirement akademik PPBL.

---

## 5. Flutter Coding Rules

1. Gunakan Flutter/Dart sederhana dan readable.
2. Pisahkan screen, widgets, models, database helper, preferences helper, providers.
3. Gunakan reusable components.
4. Jangan membuat giant screen file jika bisa dipecah.
5. Jangan menambah dependency tanpa izin.
6. Jangan memakai pattern enterprise berat jika tidak dibutuhkan.
7. Form state boleh tetap lokal dengan `setState`.
8. Gunakan `FutureBuilder`/async loading dengan state UI yang jelas.

---

## 6. Architecture Rules

Layer final:
- UI/screen layer.
- Widget/component layer.
- Model layer.
- SQLite database layer.
- SharedPreferences layer.
- Provider/state layer ringan.
- Navigation layer.
- Utils/helper layer.

Jangan membuat Clean Architecture enterprise berlebihan.

---

## 7. SQLite Rules

1. SQLite adalah storage utama untuk data aplikasi.
2. Data utama tidak disimpan di SharedPreferences.
3. Tables final minimal: `categories`, `products`, `cart_items`, `wishlist_items`, `orders`, `order_items`, `product_notes`.
4. CRUD final minimal: Category, Product, Cart Item, Wishlist Item, Order Simulation, Product Note.
5. Gunakan parameterized query/helper method, bukan raw string acak di UI.
6. Join/lookup data dilakukan di database/helper layer.
7. Validasi stok cart harus dipertimbangkan.
8. Delete product harus menjaga konsistensi relation cart/wishlist/order/note sesuai keputusan TDD.

---

## 8. SQLite Migration Rules

1. Jangan mengubah schema tanpa migration plan.
2. Baseline database version A2 adalah version 1 jika sesuai kode.
3. Tugas Besar harus menaikkan version, misalnya version 2.
4. Tambahkan `onUpgrade`.
5. Jangan drop table lama tanpa backup/instruksi.
6. Tambah table baru dengan `CREATE TABLE IF NOT EXISTS`.
7. Untuk demo akademik, reset database boleh hanya jika disetujui dan setelah backup.
8. Dokumentasikan risiko migration.

---

## 9. SharedPreferences Rules

Gunakan 6 key existing:
- `user_name`
- `is_dark_mode`
- `last_selected_category_id`
- `product_sort_type`
- `preferred_view_mode`
- `cart_last_opened`

Rules:
1. Jangan tambah key baru kecuali benar-benar perlu dan didokumentasikan.
2. Jangan simpan produk/cart/wishlist/order/note di SharedPreferences.
3. Preferences harus punya default value.
4. Settings harus bisa save/load preference.
5. Theme preference harus tidak merusak UI.

---

## 10. Provider / State Management Rules

Provider boleh digunakan untuk:
- Theme/preference state.
- Cart count/summary refresh.
- Wishlist state.
- Order state.
- Statistics refresh.

Rules:
1. Gunakan Provider secara terbatas.
2. Jangan pindahkan semua local form state ke Provider.
3. Jangan memakai Bloc/Riverpod/GetX tanpa instruksi.
4. Provider harus mudah dijelaskan saat presentasi.
5. Provider tidak menggantikan SQLite sebagai storage.

---

## 11. Chart Rules

1. Gunakan `fl_chart` hanya untuk statistik lokal.
2. Chart membaca data agregasi dari SQLite.
3. Chart tidak boleh memakai analytics online/API.
4. Chart harus minimal dan mobile-friendly.
5. Chart harus punya empty/error/loading state.
6. Jangan gunakan chart terlalu kompleks.

---

## 12. Custom Widget Rules

Minimal 1 custom widget per anggota. Mapping final:
- Anggota 1: `ProductCard`, `CategoryChip`, `WishlistToggleButton`.
- Anggota 2: `CartItemCard`, `QuantityControl`, `OrderStatusStepper`.
- Anggota 3: `PreferenceSelect`, `SettingsTile`, `StatCard`.

Custom widget harus reusable, punya props, dan bukan sekadar `onTap`.

---

## 13. Custom Drawing / Gesture Rules

Final custom drawing utama: `OrderStatusStepper` dengan `CustomPaint`.

Rules:
1. Tampilkan di Order Detail Simulation.
2. Status: Dibuat → Diproses → Selesai.
3. Visual dot + line.
4. Jangan membuat animasi rumit.
5. Jangan menggunakan Maps.
6. Jika gesture tambahan dipakai, gunakan hanya gesture sederhana seperti swipe/long press dan jangan menggantikan CustomPaint requirement.

---

## 14. UI Implementation Rules

1. Ikuti `design_handoff.md`.
2. Visual: clean, monochrome, off-white, bold, streetwear-inspired.
3. Bottom navigation hanya untuk Home, Cart, Manage, Settings.
4. Sub-screen memakai AppBar back button tanpa bottom nav.
5. UI States Reference tidak diimplementasikan sebagai route app.
6. Hapus/abaikan artifact Stitch yang masih mengandung bottom nav pada sub-screen.
7. Jangan menampilkan size/variant/material/fit/care.
8. Order harus selalu disebut Simulasi Order Lokal.
9. Jangan memakai copy checkout, payment, shipping, delivery, address, Maps.
10. Chart harus local statistics.

---

## 15. Design Handoff Rules

1. Dynamic UI harus map ke SQLite, SharedPreferences, Provider/local state, atau calculated value.
2. Jangan menambah field database hanya karena visual dekoratif.
3. Jika high-fidelity UI bertentangan dengan PRD/TDD, ikuti PRD/TDD dan final handoff rule.
4. Design handoff final mengoverride file desain lama A2.

---

## 16. Task Execution Rules

1. Baca dokumen sebelum coding.
2. Jelaskan rencana implementasi sebelum mengubah kode.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat/diubah.
5. Kerjakan satu task kecil atau batch aman.
6. Setelah coding, jelaskan perubahan file.
7. Berikan manual test.
8. Jangan lanjut task berikutnya sebelum task sekarang aman.

---

## 17. Testing Rules

Minimal test:
- `flutter analyze`.
- Run app.
- Navigasi semua screen.
- Test Product CRUD.
- Test Category CRUD.
- Test Cart CRUD + stock validation.
- Test Wishlist CRUD.
- Test Order Simulation CRUD.
- Test Product Note CRUD.
- Test SharedPreferences persistence.
- Test Provider refresh state.
- Test Chart empty/default.
- Test CustomPaint OrderStatusStepper.
- Regression test fitur A2.

---

## 18. Git / Change Safety Rules

1. Backup/commit baseline A2 sebelum major change.
2. Commit per batch jika memungkinkan.
3. Jangan menghapus file baseline tanpa instruksi.
4. Untuk schema migration, buat commit terpisah.
5. Jika perubahan besar gagal, mudah rollback.

---

## 19. Forbidden Actions

- Jangan rewrite project dari nol.
- Jangan merusak fitur A2.
- Jangan menggunakan Maps/library Maps.
- Jangan membuat backend/API production.
- Jangan membuat payment gateway real.
- Jangan membuat login production.
- Jangan membuat marketplace multi-seller.
- Jangan menambah dependency tanpa izin.
- Jangan mengubah database schema tanpa migration plan.
- Jangan membuat UI generic.
- Jangan menghapus file baseline tanpa instruksi.
- Jangan membuat order simulation terlihat seperti checkout/payment real.
- Jangan membuat shipping/address/delivery flow.
- Jangan membuat product size/variant/material/fit/care.
- Jangan membuat upload image production.
- Jangan membuat analytics online.

---

## 20. Final Reminder for AI Agent

Project ini dinilai dari kesesuaian requirement akademik, stabilitas local-first, dan kemampuan menjelaskan implementasi. Prioritaskan fitur yang bisa didemokan: SQLite, SharedPreferences, 6 CRUD, Provider, Chart, custom widgets, custom drawing, dan regression safety A2. Jangan membuat aplikasi terlihat seperti marketplace production.

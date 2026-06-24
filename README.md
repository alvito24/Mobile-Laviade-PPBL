# Laviade Studio Mobile — Local Commerce Simulation

## 1. Project Overview

Laviade Studio Mobile adalah aplikasi Flutter local-first untuk simulasi katalog dan commerce lokal brand streetwear Laviade Studio. Aplikasi ini melanjutkan baseline Assessment 2 dan menambahkan fitur Tugas Besar tanpa mengubah project menjadi marketplace production.

Data utama disimpan di SQLite. Preferensi ringan disimpan di SharedPreferences. Semua fitur tambahan bersifat simulasi lokal dan dapat dijalankan tanpa backend.

## 2. Academic Scope

Scope final terdiri dari:

- Assessment 2 baseline: katalog, cart, CRUD produk/kategori, settings, SQLite, SharedPreferences.
- Tugas Besar extension: wishlist lokal, simulasi order lokal, catatan produk lokal, insight statistik lokal, Provider, chart, dan custom drawing.
- Local-first simulation: data tersimpan di perangkat.

Project ini tidak memakai backend production, payment, checkout real, Maps, atau shipping flow.

## 3. Tech Stack

- Flutter
- Dart
- SQLite melalui `sqflite`
- `path` untuk helper path database
- SharedPreferences
- Provider
- fl_chart
- intl

## 4. Features

### Assessment 2 Features

- Product Catalog.
- Product Detail.
- Cart Item CRUD.
- Product CRUD.
- Category CRUD.
- Settings/preferences.
- Bottom navigation 4 tab: Home, Cart, Manage, Settings.
- Sort/filter/view preference.
- Theme preference/dark mode.

### Tugas Besar Features

- Wishlist Item CRUD lokal.
- Order Simulation CRUD lokal.
- Product Note CRUD lokal.
- Insight Statistics lokal.
- Chart statistik lokal dengan `fl_chart`.
- Custom `OrderStatusStepper` dengan `CustomPainter` dan gesture tap status.
- Provider sederhana untuk wishlist, order, product note, dan insight.

## 5. Out of Scope

Project ini tidak mencakup:

- Maps.
- Backend/API production.
- Login/register production.
- Payment gateway.
- Checkout real.
- Shipping/address/courier.
- Product size/variant/material/fit/care.
- Analytics online.
- Cloud sync atau upload production.

## 6. Project Structure

- `lib/models` — model data SQLite.
- `lib/data` — database helper, seed data, preferences helper.
- `lib/providers` — Provider state ringan.
- `lib/screens` — screen utama dan sub-screen fitur.
- `lib/widgets` — reusable widgets.
- `lib/core` — constants, theme, utilities.
- `docs` — dokumen requirement, QA, demo, dan mapping.

## 7. Local Database

Database memakai version 2.

Tables final:

- `categories`
- `products`
- `cart_items`
- `wishlist_items`
- `orders`
- `order_items`
- `product_notes`

Migration dari version 1 ke version 2 menambahkan tabel Tugas Besar dengan `CREATE TABLE IF NOT EXISTS` tanpa drop table lama.

## 8. SharedPreferences

6 key existing:

| Key | Fungsi |
|---|---|
| `user_name` | Nama user lokal di Settings/Home |
| `is_dark_mode` | Preferensi theme |
| `last_selected_category_id` | Kategori terakhir di Home |
| `product_sort_type` | Sort produk |
| `preferred_view_mode` | Grid/list view mode |
| `cart_last_opened` | Waktu terakhir cart dibuka |

## 9. Dependencies

| Dependency | Purpose |
|---|---|
| `sqflite` | SQLite local database |
| `path` | Database path helper |
| `shared_preferences` | Local preferences |
| `intl` | Currency/date formatting |
| `provider` | State management sederhana |
| `fl_chart` | Chart statistik lokal |

## 10. How to Run

```powershell
flutter pub get
flutter analyze
flutter run
```

Catatan: `flutter analyze` saat ini masih menampilkan info-level lint lama yang tidak menghambat build.

## 11. Demo Flow

1. A2 baseline: Splash → Home → Product Detail → Add to Cart → Cart CRUD → Manage Product/Category CRUD → Settings.
2. Wishlist: Product Detail → Simpan ke Wishlist → Manage → Wishlist Lokal.
3. Product Note: Product Detail → Catatan Produk → create/edit/delete note.
4. Order Simulation: Cart → Buat Simulasi Order Lokal → Order List → Order Detail → update status stepper.
5. Insight Statistics: Manage → Insight Lokal → stat cards dan chart lokal.

## 12. Testing

Lihat [docs/test_plan.md](docs/test_plan.md).

## 13. Known Issues

- `flutter analyze` masih menampilkan existing info-level lint:
  - `avoid_print` di seed data.
  - `use_build_context_synchronously` di Manage Category.
- Full manual device validation perlu diselesaikan sebelum presentasi.
- `flutter run` terakhir berhasil build/install, tetapi koneksi device terputus setelah install sehingga flow manual belum bisa diklaim pass penuh.

## 14. Future Improvement

- Backend integration sebagai pengembangan future.
- Account system/login real sebagai future.
- Real checkout/payment sebagai future.
- Real shipping/courier sebagai future.
- Implementasi brand production dengan aset real sebagai future.

## 15. Academic Requirement Mapping

- SQLite: semua data utama disimpan lokal.
- SharedPreferences: 6 key preferences.
- 6 CRUD: Category, Product, Cart Item, Wishlist Item, Order Simulation, Product Note.
- Provider: wishlist, order, product note, insight.
- fl_chart: chart statistik lokal.
- Custom widgets: card/tile/form/stat/chart widgets.
- Custom drawing/gesture: `OrderStatusStepper`.
- No forbidden features: tidak ada Maps, backend, payment, shipping, atau analytics online.

# technical_design.md
# Technical Design Document
# Laviade Studio Mobile — Local Commerce Simulation
## Final Scope Assessment 2 + Tugas Besar

## Project Information

| Item | Keterangan |
|---|---|
| Project name | Laviade Studio Mobile — Local Commerce Simulation |
| Baseline | Laviade Studio Mobile — Local Catalog & Cart |
| Scope | Assessment 2 + Tugas Besar |
| Tech stack | Flutter, Dart, SQLite, SharedPreferences, Provider, fl_chart, intl |
| Target platform | Android mobile |
| Storage utama | SQLite melalui `sqflite` dan `path` |
| Preference storage | SharedPreferences |
| State management | `setState`/`FutureBuilder` existing + Provider sederhana |
| Design approach | Clean, monochrome, streetwear-inspired, mobile-first |
| Academic focus | SQLite, SharedPreferences, 6 CRUD, custom widget, custom drawing/gesture, 3–5 library non-SQLite |
| No Maps decision | Tidak menggunakan Maps/library Maps |
| Baseline source code status | A2 sudah memiliki SQLite, SharedPreferences, 3 entity CRUD, screen utama, reusable widgets |

---

## 1. Technical Overview

Aplikasi ini adalah Flutter local-first app. Data utama disimpan di SQLite. Data preferensi disimpan di SharedPreferences. Assessment 2 sudah memiliki `categories`, `products`, dan `cart_items`. Tugas Besar memperluas schema dengan `wishlist_items`, `orders`, `order_items`, dan `product_notes`.

Provider dipakai sebagai state management sederhana untuk state global seperti theme/preference, cart summary, wishlist, order, dan statistics. Form lokal tetap boleh memakai `setState`. Chart/statistik lokal menggunakan `fl_chart` dan membaca data dari SQLite. Aplikasi tidak memakai backend/API production, payment gateway real, login production, atau Maps.

---

## 2. Architecture

### 2.1 UI Layer

Berisi screen dan widget. Existing screen A2: Splash, Home, Product Detail, Cart, Manage, Manage Product, Product Form, Manage Category, Category Form, Settings. Screen baru: Wishlist, Orders, Order Detail, Product Notes, Statistics.

UI layer boleh memanggil Provider/helper, tetapi tidak boleh berisi logic SQLite kompleks yang sulit diuji.

### 2.2 Model Layer

Existing model:
1. `CategoryModel`
2. `ProductModel`
3. `CartItemModel`

New model:
1. `WishlistItemModel`
2. `OrderModel`
3. `OrderItemModel`
4. `ProductNoteModel`
5. Optional `StatisticsSummaryModel`

### 2.3 Local Database Layer

Menggunakan `DatabaseHelper` singleton. Tanggung jawab:
1. create/open database,
2. create table,
3. migration,
4. CRUD,
5. join query,
6. statistics query.

### 2.4 Preferences Layer

Menggunakan `PreferenceHelper` singleton. Hanya untuk 6 key SharedPreferences. Data utama seperti produk, cart, wishlist, order, dan notes tidak boleh masuk SharedPreferences.

### 2.5 Provider/State Layer

Provider dipakai terbatas:
1. ThemeProvider.
2. PreferenceProvider jika perlu.
3. CartProvider.
4. WishlistProvider.
5. OrderProvider.
6. StatisticsProvider.

Provider tidak menggantikan seluruh state lokal. Form add/edit tetap boleh `StatefulWidget`.

### 2.6 Helper/Service Layer

Helper ringan boleh dipakai untuk currency/date formatting, order code generation, statistics mapping, dan validation helper jika logic berulang.

### 2.7 Navigation Layer

Existing: bottom navigation dengan `MainNavigation` dan `AppBottomNav`, serta `MaterialPageRoute` untuk detail/form. Untuk Tugas Besar, boleh menambah route helper sederhana, tetapi jangan router kompleks jika tidak perlu.

---

## 3. Current Baseline Code Summary

Struktur source code real sudah memiliki `core`, `data`, `models`, `screens`, `widgets`, dan `navigation`. File penting existing:
- `lib/data/database/database_helper.dart`
- `lib/data/preferences/preference_helper.dart`
- `lib/data/seed/seed_data.dart`
- `lib/models/category_model.dart`
- `lib/models/product_model.dart`
- `lib/models/cart_item_model.dart`
- `lib/navigation/main_navigation.dart`
- `lib/widgets/app_bottom_nav.dart`
- `lib/core/theme/app_theme.dart`
- `lib/core/utils/currency_formatter.dart`
- `lib/core/utils/dummy_data.dart` — perlu verifikasi manual apakah masih dipakai.

Dependency existing:
- `sqflite`
- `path`
- `shared_preferences`
- `intl`

Dependency belum ada:
- `provider`
- `fl_chart`

Status penting:
1. Database version baseline: 1.
2. Belum ada `onUpgrade`.
3. `SplashScreen` ada, tetapi perlu verifikasi apakah sudah menjadi initial screen.
4. Product/Category/Cart CRUD sudah existing.
5. SharedPreferences 6 key sudah existing.
6. Maps dependency tidak ada dan tetap dilarang.

---

## 4. Folder Structure Final

```text
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── data/
│   ├── database/
│   ├── preferences/
│   └── seed/
├── models/
├── providers/
├── navigation/
├── painters/
├── screens/
│   ├── splash/
│   ├── home/
│   ├── cart/
│   ├── manage/
│   ├── settings/
│   ├── wishlist/
│   ├── orders/
│   ├── notes/
│   └── statistics/
└── widgets/
```

| Folder | Fungsi | Contoh file | Status | Aturan |
|---|---|---|---|---|
| `core/constants` | design constants | `app_colors.dart` | existing | no business logic |
| `core/theme` | app theme | `app_theme.dart` | existing | maintain design system |
| `core/utils` | formatter/helper ringan | `currency_formatter.dart` | existing | no database query |
| `data/database` | SQLite helper | `database_helper.dart` | existing enhanced | migration wajib |
| `data/preferences` | SharedPreferences helper | `preference_helper.dart` | existing | only preferences |
| `data/seed` | seed data | `seed_data.dart` | existing | avoid duplicate |
| `models` | entity model | `order_model.dart` | existing + new | fromMap/toMap |
| `providers` | state global | `cart_provider.dart` | new | no over-engineering |
| `navigation` | nav helper | `main_navigation.dart` | existing | avoid too many tabs |
| `painters` | CustomPainter | `order_status_painter.dart` | new | drawing only |
| `screens` | pages | wishlist/orders/statistics | existing + new | keep modular |
| `widgets` | reusable UI | `stat_card.dart` | existing + new | reusable props |

---

## 5. Database Design

### 5.1 Existing Tables

#### `categories`

| Column | Type | Constraint |
|---|---|---|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT |
| `name` | TEXT | NOT NULL |
| `created_at` | TEXT | NOT NULL |
| `updated_at` | TEXT | NOT NULL |

CRUD: insert/get/getById/update/delete.  
Screen: Manage Category, Category Form, Product Form, Home Filter.  
Status: existing.

#### `products`

| Column | Type | Constraint |
|---|---|---|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT |
| `category_id` | INTEGER | NOT NULL, FK categories |
| `name` | TEXT | NOT NULL |
| `price` | INTEGER | NOT NULL |
| `stock` | INTEGER | NOT NULL |
| `description` | TEXT | nullable |
| `image_name` | TEXT | nullable |
| `created_at` | TEXT | NOT NULL |
| `updated_at` | TEXT | NOT NULL |

CRUD: insert/get/getByCategory/getById/update/delete.  
Screen: Catalog, Detail, Manage Product, Product Form.  
Status: existing.

#### `cart_items`

| Column | Type | Constraint |
|---|---|---|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT |
| `product_id` | INTEGER | NOT NULL, FK products |
| `quantity` | INTEGER | NOT NULL |
| `created_at` | TEXT | NOT NULL |
| `updated_at` | TEXT | NOT NULL |

CRUD: add/get/updateQuantity/delete/clear.  
Screen: Product Detail, Cart.  
Status: existing enhanced.  
Risk: stok validation perlu fix.

### 5.2 New Tables

#### `wishlist_items`

| Column | Type | Constraint |
|---|---|---|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT |
| `product_id` | INTEGER | NOT NULL, FK products |
| `created_at` | TEXT | NOT NULL |
| `updated_at` | TEXT | NOT NULL |

Recommended unique logic: one wishlist row per product.  
CRUD: add/get/isWishlisted/remove/toggle.  
Screen: Wishlist, Home, Product Detail.  
Status: new.

#### `orders`

| Column | Type | Constraint |
|---|---|---|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT |
| `order_code` | TEXT | NOT NULL |
| `status` | TEXT | NOT NULL |
| `total_price` | INTEGER | NOT NULL |
| `total_items` | INTEGER | NOT NULL |
| `created_at` | TEXT | NOT NULL |
| `updated_at` | TEXT | NOT NULL |

Status values: `draft`, `confirmed`, `packed`, `completed`, `cancelled`.  
CRUD: create/get/getById/updateStatus/delete.  
Screen: Cart, Orders, Order Detail.  
Status: new.

#### `order_items`

| Column | Type | Constraint |
|---|---|---|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT |
| `order_id` | INTEGER | NOT NULL, FK orders |
| `product_id` | INTEGER | nullable/FK products |
| `product_name_snapshot` | TEXT | NOT NULL |
| `price_snapshot` | INTEGER | NOT NULL |
| `quantity` | INTEGER | NOT NULL |
| `subtotal` | INTEGER | NOT NULL |
| `created_at` | TEXT | NOT NULL |

CRUD direct tidak diperlukan untuk user, tetapi create/read terikat Order Simulation CRUD.  
Screen: Order Detail.  
Status: new.

#### `product_notes`

| Column | Type | Constraint |
|---|---|---|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT |
| `product_id` | INTEGER | NOT NULL, FK products |
| `note_text` | TEXT | NOT NULL |
| `created_at` | TEXT | NOT NULL |
| `updated_at` | TEXT | NOT NULL |

CRUD: insert/getByProduct/getById/update/delete.  
Screen: Product Detail/Notes.  
Status: new.

---

## 6. SQLite Versioning / Migration Strategy

Baseline A2 database version adalah 1. Tugas Besar harus menaikkan version ke 2 karena menambah tabel baru. `onUpgrade` wajib ditambahkan.

Strategi `onUpgrade`:
1. Jika oldVersion < 2, jalankan `CREATE TABLE IF NOT EXISTS` untuk `wishlist_items`, `orders`, `order_items`, dan `product_notes`.
2. Jangan drop tabel `categories`, `products`, atau `cart_items`.
3. Jangan reset data lama tanpa izin.
4. Jika development perlu reset database, lakukan setelah backup dan catat sebagai development reset, bukan migration final.
5. Gunakan timestamps ISO string konsisten.
6. Pertimbangkan `PRAGMA foreign_keys = ON`; perlu verifikasi manual apakah sudah aktif di koneksi SQLite.

Risiko:
- SQL migration salah.
- Data lama hilang.
- Foreign key tidak enforced.
- Seed data duplicate.

Mitigasi:
- Backup branch baseline.
- Migration incremental.
- Test app dari database version 1.
- Regression test semua fitur A2.

---

## 7. Relationship Design

| Relasi | Deskripsi |
|---|---|
| Category → Product | One category has many products |
| Product → CartItem | Product can be in cart item |
| Product → WishlistItem | Product can be in wishlist once |
| Order → OrderItem | One order has many order items |
| Product → ProductNote | Product can have many notes |
| Product → OrderItem | Order item keeps optional product reference and snapshot |

---

## 8. Local Data Operations

### Category operations

`insertCategory`, `getCategories`, `getCategoryById`, `updateCategory`, `deleteCategory`.

Validasi:
- name tidak kosong.
- category tidak boleh dihapus jika masih digunakan product.

### Product operations

`insertProduct`, `getProducts`, `getProductsByCategory`, `getProductById`, `updateProduct`, `deleteProduct`.

Validasi:
- name wajib.
- category wajib.
- price > 0.
- stock >= 0.

### Cart operations

`addToCart`, `getCartItems`, `updateCartQuantity`, `deleteCartItem`, `clearCart`, `getCartTotal`.

Validasi:
- product exists.
- quantity >= 1.
- quantity <= stock.

### Wishlist operations

`addWishlistItem`, `getWishlistItems`, `isProductWishlisted`, `removeWishlistItem`, `toggleWishlistItem`.

Validasi:
- product exists.
- no duplicate wishlist.

### Order operations

`createOrderFromCart`, `getOrders`, `getOrderById`, `getOrderItemsByOrderId`, `updateOrderStatus`, `deleteOrder`.

Validasi:
- cart not empty.
- all item stock valid.
- order status valid.
- no payment/shipping logic.

### Product Note operations

`insertProductNote`, `getProductNotes`, `getProductNoteById`, `updateProductNote`, `deleteProductNote`.

Validasi:
- note_text tidak kosong.
- product exists.

### Preference operations

Getter/setter 6 key wajib tetap berada di `PreferenceHelper`.

### Statistics operations

`getProductCountByCategory`, `getWishlistCount`, `getOrderCount`, `getNoteCount`, `getLocalDashboardSummary`.

Data source:
- SQLite local only.

---

## 9. SharedPreferences Design

| Key | Type | Default | Function | Screen | Owner | Status |
|---|---|---|---|---|---|---|
| `user_name` | String | Guest | greeting/profile | Home, Settings | Anggota 3 | existing |
| `is_dark_mode` | bool | false | theme | App, Settings | Anggota 3 | existing |
| `last_selected_category_id` | int? | null | last category | Home, Settings | Anggota 1 | existing |
| `product_sort_type` | String | default | product sort | Home, Settings | Anggota 1 | existing, enhance validation |
| `preferred_view_mode` | String | grid | grid/list | Home, Settings | Anggota 2 | existing |
| `cart_last_opened` | String? | null | last cart time | Cart, Settings | Anggota 2 | existing |

Rules:
- No product/cart/order/wishlist/note in SharedPreferences.
- Validate `preferred_view_mode` as `grid/list`.
- Validate sort type values consistently.

---

## 10. Provider / State Management Design

| Provider | State | Method | Screen | Risiko | Batasan |
|---|---|---|---|---|---|
| `ThemeProvider` | `isDarkMode`, `themeMode` | load/toggle | App, Settings | conflict with existing callback | integrate gradually |
| `PreferenceProvider` | user/category/sort/view/cart time | load/save | Home, Settings, Cart | overlap helper | helper remains storage |
| `CartProvider` | cartItems, total, count, loading | load/add/update/delete | Detail, Cart, Order | state stale | use helper |
| `WishlistProvider` | wishlistItems, wishlistedIds | load/toggle/remove | Home, Detail, Wishlist | duplicate state | sync after toggle |
| `OrderProvider` | orders, selectedOrder | create/load/update/delete | Cart, Orders, Detail | status invalid | use constants |
| `StatisticsProvider` | summary/chart data | loadStatistics | Statistics | query too complex | keep summary light |

Provider digunakan hanya jika membantu refresh global. Form lokal tetap `setState`.

---

## 11. Navigation Design

Bottom nav existing tetap:
1. Home
2. Cart
3. Manage
4. Settings

Screen baru tidak semuanya masuk bottom nav. Rekomendasi akses:
- Wishlist dari Home/Product Detail atau Manage.
- Orders dari Cart atau Manage.
- Order Detail dari Orders.
- Product Notes dari Product Detail.
- Statistics dari Manage.

Route helper optional:
- `navigation/app_routes.dart`
- `navigation/navigation_helper.dart`

Batasan:
- Jangan tambah banyak bottom nav.
- Jangan router kompleks kecuali dibutuhkan.
- Pastikan back behavior jelas.

---

## 12. Validation Rules

| Area | Positive case | Negative case | Message |
|---|---|---|---|
| Product Form | name/category/price/stock valid | name empty, category null, price <=0, stock <0 | “Data produk belum valid.” |
| Category Form | name not empty | name empty/duplicate | “Nama kategori wajib diisi.” |
| Cart | quantity 1..stock | quantity <1 or >stock | “Jumlah melebihi stok tersedia.” |
| Wishlist | product valid, not duplicate | duplicate/product invalid | “Produk sudah ada di wishlist.” |
| Order | cart not empty, stock valid | empty cart, invalid stock | “Cart masih kosong.” / “Stok tidak mencukupi.” |
| Note | note text not empty | empty note | “Catatan wajib diisi.” |
| Preferences | valid values | invalid view/sort | fallback default |

---

## 13. Error Handling

| Error | Handling |
|---|---|
| SQLite open/migration failed | error state + debug log |
| Empty products/cart/wishlist/orders/notes | EmptyState |
| Invalid productId/orderId/noteId | Not found state |
| Duplicate wishlist | info snackbar |
| Invalid form input | validation message near field |
| Failed preference load | default value + message |
| Chart no data | empty chart state |
| Silent load error | replace with explicit ErrorState |
| Image asset missing | placeholder/local asset name |

Raw technical error tidak ditampilkan langsung ke user.

---

## 14. Security Basic

1. Tidak ada password.
2. Tidak ada token/API key.
3. Tidak ada payment data.
4. Tidak ada data sensitif.
5. Tidak ada backend.
6. Tidak ada Maps/location permission.
7. Validasi input lokal.
8. Local storage hanya untuk demo akademik.

---

## 15. Custom Widget Plan

| Widget | Function | Props | Screen | Owner | Requirement | Status |
|---|---|---|---|---|---|---|
| `ProductCard` | product card | product fields, onTap | Home | Anggota 1 | custom widget/orang | existing |
| `CategoryChip` | category filter | label, selected, onTap | Home | Anggota 1 | custom widget | existing |
| `WishlistToggleButton` | wishlist toggle | productId, isActive, onToggle | Home/Detail | Anggota 1 | custom tambahan | new |
| `CartItemTile` | cart row | item, callbacks | Cart | Anggota 2 | custom widget/orang | existing |
| `QuantityControl` | quantity stepper | quantity, callbacks | Cart | Anggota 2 | custom widget | existing |
| `OrderStatusStepper` | custom status drawing | status, steps | Order Detail | Anggota 2 | custom drawing | new |
| `PreferenceSelect` | pref dropdown | label, value, options | Settings | Anggota 3 | custom widget/orang | existing |
| `SettingTile` | setting row | title, subtitle, trailing | Settings | Anggota 3 | custom widget | existing |
| `StatCard` | summary card | title, value, caption | Statistics | Anggota 3 | custom tambahan | new |

---

## 16. Custom Gesture/Drawing Widget Plan

Pilihan utama: `OrderStatusStepper` dengan `CustomPaint`.

Konsep:
- Menampilkan progres status order simulation.
- Gambar circle, line, active state, dan label.

Class Flutter:
- `CustomPaint`
- `CustomPainter`
- `Canvas.drawCircle`
- `Canvas.drawLine`
- optional `TextPainter`

Screen:
- Order Detail.

Requirement:
- Custom drawing.
- Custom widget tambahan.
- Relevan dengan Order Simulation.

Risiko:
- Terlalu kompleks.
Mitigasi:
- Buat stepper 4–5 step sederhana tanpa animasi kompleks.

---

## 17. Library Plan

| Library | Function | Feature | Reason | Risk | Alternative |
|---|---|---|---|---|---|
| `shared_preferences` | preferences | Settings/theme/home prefs | existing + required | misused for main data | none |
| `provider` | state management | cart/wishlist/order/statistics/theme | simple | overengineering | setState local |
| `fl_chart` | chart | Statistics | chart requirement | UI too complex | simple StatCard fallback |
| `intl` | formatting | currency/date | existing | version issue | manual formatter |

Maps tidak digunakan.

---

## 18. UI/UX Technical Notes

1. Desain A2 harus dipertahankan.
2. Screen baru harus mengikuti style clean, monochrome, streetwear.
3. Chart harus sederhana.
4. Wishlist/order/notes harus local-only.
5. Order simulation tidak boleh terlihat seperti payment/checkout real.
6. Manage bisa menjadi entry point fitur baru.
7. UI final bergantung hasil Google Stitch.
8. `design_handoff.md` final dibuat setelah UI high-fidelity final.

---

## 19. Testing Strategy

Testing final:
1. Manual testing semua flow.
2. CRUD testing untuk 6 entity.
3. SQLite persistence testing.
4. SharedPreferences testing untuk 6 key.
5. Provider state testing.
6. Chart testing.
7. Navigation testing.
8. UI state testing.
9. Regression testing Assessment 2.
10. Final demo testing tanpa internet.

Minimal manual test:
- Add/edit/delete category.
- Add/edit/delete product.
- Add/update/delete cart item.
- Add/remove wishlist.
- Create/update/delete order simulation.
- Add/edit/delete product note.
- Save/load preferences.
- Restart app and verify persistence.
- Open statistics and chart.
- Open Order Detail and see `OrderStatusStepper`.

---

## 20. Technical Risks & Mitigation

| Risiko | Dampak | Kemungkinan | Mitigasi |
|---|---|---:|---|
| Migration gagal | data lama hilang | Sedang | backup, `onUpgrade`, no drop |
| Fitur A2 rusak | demo gagal | Sedang | regression test |
| Provider over-engineering | kode sulit dijelaskan | Sedang | batasi provider |
| Chart kompleks | UI ramai/waktu habis | Sedang | chart sederhana |
| CustomPaint sulit | requirement tertunda | Sedang | stepper sederhana |
| Waktu mepet | fitur tidak selesai | Tinggi | Must Have dulu |
| Cart stok invalid | order tidak realistis | Sedang | validasi stok |
| Preference refresh IndexedStack | UI tidak update | Sedang | Provider/refresh callback |
| Maps masuk | melanggar constraint | Rendah | forbid dependency |
| Scope creep | project melebar | Sedang | no backend/payment/Maps |

---

## 21. Implementation Sequence

1. Backup baseline.
2. Verify current code.
3. Minor fix A2.
4. Extend database version 2.
5. Add new models.
6. Add database operations.
7. Add Provider dependency/classes.
8. Generate UI via Stitch.
9. Create final design handoff.
10. Implement Wishlist.
11. Implement Order Simulation.
12. Implement Product Notes.
13. Implement Statistics/Chart.
14. Implement `OrderStatusStepper`.
15. Regression test A2.
16. Final QA.
17. Documentation/presentation.

---

## 22. Final Technical Decision

1. Tetap Flutter local-first.
2. SQLite menjadi storage utama.
3. SharedPreferences hanya untuk preferences.
4. Database naik dari version 1 ke 2.
5. Tabel A2 dipertahankan.
6. Tabel baru ditambahkan melalui migration.
7. Provider dipakai terbatas.
8. `fl_chart` dipakai untuk statistik lokal.
9. `intl` dipakai untuk format tanggal/harga jika relevan.
10. `OrderStatusStepper` dengan CustomPaint menjadi custom drawing utama.
11. Maps, backend/API production, dan payment gateway real tidak digunakan.
12. Fitur Tugas Besar dibangun bertahap agar fitur A2 tidak rusak.

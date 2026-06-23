# PRD.md
# Product Requirement Document
# Laviade Studio Mobile — Local Commerce Simulation
## Final Scope Assessment 2 + Tugas Besar

## Dokumen Control

| Item | Keterangan |
|---|---|
| Nama project final | Laviade Studio Mobile — Local Commerce Simulation |
| Nama baseline Assessment 2 | Laviade Studio Mobile — Local Catalog & Cart |
| Brand | Laviade Studio, streetwear clothing brand |
| Platform | Flutter mobile app, target Android |
| Jenis aplikasi | Local-first mobile commerce simulation |
| Scope | Assessment 2 + Tugas Besar |
| Prinsip | Melanjutkan baseline Assessment 2, bukan rebuild dari nol |
| Ground truth teknis | Source code real + Reconciliation Report |
| Catatan | `design_handoff.md`, `UI_IMPLEMENTATION_TASKS.md`, `ANTIGRAVITY_TASK_PROMPTS.md`, dan `AGENTS.md final` dibuat setelah UI Stitch final |

---

## 1. Product Overview

**Laviade Studio Mobile — Local Commerce Simulation** adalah versi final gabungan dari baseline Assessment 2 **Laviade Studio Mobile — Local Catalog & Cart** dan scope Tugas Besar. Aplikasi ini adalah Flutter mobile app local-first untuk katalog produk streetwear Laviade, simulasi cart, CRUD lokal, preferensi user, wishlist lokal, order simulation lokal, product note/review lokal, statistik lokal, dan pemenuhan requirement akademik PPBL.

Assessment 2 menjadi baseline existing. Berdasarkan audit source code dan rekonsiliasi, baseline real yang harus dipertahankan adalah Product Catalog, Product Detail, Product CRUD, Category CRUD, Cart Item CRUD, Settings/Preferences, SQLite, SharedPreferences, Bottom Navigation Home/Cart/Manage/Settings, reusable widgets, local-first architecture, tanpa backend/API, tanpa login/register, tanpa checkout/payment real, dan tanpa Maps.

Tugas Besar adalah extension yang menambahkan minimal 6 CRUD, minimal 6 key SharedPreferences untuk 3 anggota, custom widget per anggota, custom drawing atau gesture widget, chart/statistik lokal, dan Provider sebagai state management sederhana. Project tetap bukan full online marketplace, bukan e-commerce production, tidak menggunakan backend/API production, tidak menggunakan payment gateway real, dan tidak menggunakan Maps.

---

## 2. Background / Latar Belakang

Laviade Studio adalah brand streetwear clothing yang menjadi konteks produk aplikasi. Pada Assessment 2, aplikasi dibuat sebagai katalog mobile local-first dengan SQLite untuk data utama dan SharedPreferences untuk preferensi. SQLite digunakan karena produk, kategori, dan cart memiliki struktur dan relasi. SharedPreferences digunakan untuk data kecil berbasis key-value seperti `user_name`, `is_dark_mode`, kategori terakhir, sorting, view mode, dan waktu terakhir cart dibuka.

Tugas Besar melanjutkan baseline existing karena source code real sudah cukup kuat: struktur Flutter rapi, SQLite helper tersedia, Preference helper tersedia, model utama tersedia, screen utama tersedia, dan fitur utama sudah menggunakan data lokal. Source code real dipakai sebagai ground truth karena ada beberapa hal yang belum sepenuhnya sama dengan dokumen lama, seperti `SplashScreen` belum menjadi initial screen, beberapa error state masih silent, validasi stok cart belum lengkap, `dummy_data.dart` masih tersisa, dan database version masih 1 tanpa `onUpgrade`.

Scope dijaga realistis untuk project mahasiswa. Fitur tambahan dipilih karena memenuhi requirement akademik tanpa mengubah aplikasi menjadi marketplace production: wishlist lokal, order simulation lokal, product note/review lokal, chart/statistik lokal, Provider sederhana, dan custom drawing/gesture.

Maps tidak digunakan karena tidak sesuai batasan project dan tidak dibutuhkan oleh local commerce simulation ini. Backend/payment production juga tidak digunakan agar fokus tetap pada local storage, CRUD, UI, state management, chart, dan demo akademik.

---

## 3. Goals

### 3.1 Goals dari sisi user

1. User dapat melihat katalog produk Laviade secara lokal.
2. User dapat melihat detail produk.
3. User dapat menambahkan produk ke cart dan mengatur quantity.
4. User dapat menyimpan produk ke wishlist lokal.
5. User dapat membuat simulasi order lokal dari cart.
6. User dapat menulis catatan/review lokal terhadap produk.
7. User dapat melihat statistik lokal sederhana.
8. User dapat menyimpan preferensi seperti nama, tema, sorting, dan view mode.

### 3.2 Goals dari sisi sistem

1. Menjaga data utama di SQLite.
2. Menjaga preferensi di SharedPreferences.
3. Menambahkan 3 entity CRUD baru tanpa merusak 3 CRUD Assessment 2.
4. Menyediakan migration database dari version 1 ke version 2.
5. Menggunakan Provider secara terbatas untuk state global sederhana.
6. Menampilkan chart dari data SQLite lokal.
7. Menyediakan reusable custom widgets dan custom drawing/gesture widget.

### 3.3 Goals dari sisi akademik

1. Memenuhi SQLite.
2. Memenuhi SharedPreferences minimal 2 key per orang.
3. Memenuhi minimal 6 CRUD.
4. Memenuhi minimal 1 custom widget per orang.
5. Memenuhi custom widget tambahan.
6. Memenuhi custom drawing atau gesture tambahan.
7. Memenuhi 3–5 library di luar SQLite.
8. Tidak menggunakan Maps.
9. Memudahkan presentasi dan demo.

### 3.4 Goals maintainability

1. Tidak rewrite besar fitur Assessment 2.
2. Tidak menghapus tabel lama.
3. Menambah fitur secara bertahap.
4. Menjaga screen/widget tetap modular.
5. Menjaga aplikasi tetap mudah dijelaskan oleh mahasiswa.

---

## 4. Non-Goals / Out of Scope

Scope final ini tidak membuat:

1. Backend online/API production.
2. Login/register production.
3. Authentication multi-role.
4. Payment gateway real.
5. Checkout production.
6. Marketplace multi-seller.
7. Push notification real.
8. Maps dan semua library Maps.
9. Admin dashboard enterprise.
10. Upload image production.
11. Shipping/address management.
12. Chat/customer service.
13. Cloud sync.
14. Real courier tracking.
15. Real financial transaction.
16. Recommendation engine.
17. Fitur kompleks yang mengarah ke aplikasi production.

Order simulation hanya simulasi lokal. Wishlist dan product note/review juga lokal, bukan fitur online marketplace.

---

## 5. User Roles

### 5.1 Customer

Customer menggunakan aplikasi untuk melihat katalog, membuka detail produk, menambahkan produk ke cart, mengelola cart, menyimpan wishlist, membuat simulasi order, melihat riwayat order lokal, membuat product note/review lokal, melihat statistik lokal, dan mengatur preferensi.

### 5.2 Pengelola Data Demo / Admin Lokal

Pengelola Data Demo memakai menu Manage untuk Product CRUD, Category CRUD, dan akses ke fitur lokal tambahan seperti statistics/order jika desain final menempatkannya di Manage.

Tidak ada login production. Role dibedakan berdasarkan menu/fungsi aplikasi karena project fokus pada local storage dan requirement akademik.

---

## 6. Baseline Assessment 2 yang Dipertahankan

| Fitur | Status | Data | Screen | File kode terkait | Catatan |
|---|---|---|---|---|---|
| Product Catalog | Existing real | `products`, `categories`, preferences | Home | `home_screen.dart`, `product_card.dart`, `category_chip.dart` | Error state load perlu diperkuat |
| Product Detail | Existing real | `products`, `categories`, `cart_items` | Product Detail | `product_detail_screen.dart` | Add to Cart perlu validasi stok |
| Product CRUD | Existing real | `products`, `categories` | Manage Product, Product Form | `manage_product_screen.dart`, `product_form_screen.dart`, `database_helper.dart` | Tidak boleh rusak |
| Category CRUD | Existing real | `categories`, `products` | Manage Category, Category Form | `manage_category_screen.dart`, `category_form_screen.dart` | Delete conflict sudah ada |
| Cart Item CRUD | Existing real | `cart_items`, `products` | Product Detail, Cart | `cart_screen.dart`, `database_helper.dart` | Stok validation perlu enhancement |
| Settings/Preferences | Existing real | 6 key SharedPreferences | Settings | `settings_screen.dart`, `preference_helper.dart`, `app.dart` | Refresh antar tab perlu verifikasi manual |
| SQLite | Existing real | `categories`, `products`, `cart_items` | Data layer | `database_helper.dart` | Version 1, belum ada `onUpgrade` |
| SharedPreferences | Existing real | 6 key | Settings/Home/Cart/App | `preference_helper.dart` | Sudah cukup untuk requirement 6 key |
| Navigation | Existing real | Tab state | Home/Cart/Manage/Settings | `main_navigation.dart`, `app_bottom_nav.dart` | Jangan tambah tab terlalu banyak |
| UI Components | Existing real | Props/widget | Multiple | `lib/widgets/*` | Bisa dipakai untuk custom widget requirement |
| Theme/design system | Existing real | Colors/theme | App | `app_theme.dart`, `app_colors.dart` | Pertahankan visual |
| Seed data | Existing real | categories/products | App startup | `seed_data.dart` | Jangan duplicate seed |

---

## 7. Minor Fix Assessment 2 Sebelum Tugas Besar

| Fix | Masalah | Dampak | Prioritas | File/screen | Wajib? |
|---|---|---|---|---|---|
| Aktifkan Splash initial | `SplashScreen` ada tapi app langsung ke `MainNavigation` | Demo tidak sesuai flow | Should Have | `app.dart`, `splash_screen.dart` | Disarankan |
| Error state Home/Cart | Load error masih silent | UX kurang jelas | Should Have | `home_screen.dart`, `cart_screen.dart` | Disarankan |
| Validasi stok cart | Quantity bisa melebihi stok | Order simulation tidak realistis | Must Have | `database_helper.dart`, `cart_screen.dart`, `product_detail_screen.dart` | Ya |
| Sort/view preference | Home belum auto-save sort/view | Preference tidak konsisten | Should Have | `home_screen.dart`, `preference_helper.dart` | Disarankan |
| Verifikasi `dummy_data.dart` | File dummy masih tersisa | Bisa membingungkan reviewer | Could Have | `lib/core/utils/dummy_data.dart` | Perlu verifikasi manual |
| Migration plan | Database version 1 belum `onUpgrade` | Schema baru berisiko | Must Have | `database_helper.dart` | Ya sebelum tambah tabel |

---

## 8. Final Feature Scope

| Fitur | Deskripsi | User | Data | Requirement | Prioritas | Status |
|---|---|---|---|---|---|---|
| Splash Screen | Branding awal | Semua | Static | UI flow | Should Have | Existing, perlu initial |
| Product Catalog | Katalog produk SQLite | Customer | `products`, `categories` | SQLite/UI | Must | Existing |
| Product Detail | Detail produk + action | Customer | `products`, `cart_items`, `wishlist_items`, `product_notes` | SQLite/CRUD | Must | Enhanced |
| Category CRUD | Kelola kategori | Admin Lokal | `categories` | CRUD 1 | Must | Existing |
| Product CRUD | Kelola produk | Admin Lokal | `products` | CRUD 2 | Must | Existing |
| Cart CRUD | Simulasi cart | Customer | `cart_items` | CRUD 3 | Must | Existing enhanced |
| Wishlist CRUD | Favorit lokal | Customer | `wishlist_items` | CRUD 4 | Must | New TB |
| Order Simulation CRUD | Simulasi order lokal | Customer | `orders`, `order_items` | CRUD 5 | Must | New TB |
| Product Review/Note CRUD | Catatan lokal produk | Customer | `product_notes` | CRUD 6 | Must | New TB |
| SharedPreferences Settings | Preferensi user | Customer | 6 key | SharedPreferences | Must | Existing |
| Filter/Search/Sort | Filter/sort lokal | Customer | products/preferences | UI preference | Should | Enhanced |
| Local Statistics/Chart | Statistik SQLite lokal | Customer/Admin | multiple tables | Chart library | Must | New TB |
| Provider | State management ringan | Developer | global state | Library state management | Must | New TB |
| Custom widgets | Widget reusable | Developer/User | widget props | Custom widget | Must | Existing + new |
| Custom drawing/gesture | `OrderStatusStepper` | Customer | order status | Drawing/gesture | Must | New TB |

---

## 9. User Flow

### 9.1 Customer browsing flow

User membuka aplikasi, melihat Splash, masuk Home, sistem membaca produk/kategori dari SQLite, user memilih kategori/sort/view, lalu membuka Product Detail. Data yang dibaca: `products`, `categories`, dan beberapa SharedPreferences. Status: existing enhanced.

### 9.2 Product detail flow

User membuka detail produk, melihat informasi produk, menekan Add to Cart, toggle Wishlist, atau membuka Product Note. Data: `products`, `cart_items`, `wishlist_items`, `product_notes`. Status: existing + new extension.

### 9.3 Cart flow

User menambahkan produk ke cart, sistem validasi stok, user membuka Cart, mengubah quantity, menghapus item, dan membuat simulasi order. Data: `cart_items`, `products`, `orders`, `order_items`. Status: existing enhanced.

### 9.4 Wishlist flow

User menekan wishlist toggle, sistem menyimpan ke `wishlist_items`, user membuka Wishlist, melihat produk favorit, membuka detail, atau menghapus wishlist item. Status: new.

### 9.5 Order simulation flow

User membuat order dari cart, sistem membuat `orders` dan `order_items`, user melihat Orders, membuka Order Detail, melihat `OrderStatusStepper`, update status, atau cancel/delete order. Status: new.

### 9.6 Review/note flow

User membuka Product Detail, membuka notes, menambah note lokal, membaca list note, edit, dan delete note. Status: new.

### 9.7 Local statistics flow

User membuka Statistics, sistem membaca summary SQLite, menampilkan stat card dan chart. Jika data kosong, tampil empty chart state. Status: new.

### 9.8 Manage product/category flow

User membuka Manage, memilih Manage Product/Category, melakukan CRUD, data tersimpan di SQLite. Status: existing.

### 9.9 Settings/preferences flow

User membuka Settings, sistem load SharedPreferences, user mengubah preference, menyimpan, dan value persist setelah restart. Status: existing.

---

## 10. Data Requirements

### 10.1 SQLite entities

| Entity | Tujuan | Field utama | Relasi | Fitur | Status | Source code |
|---|---|---|---|---|---|---|
| `categories` | Kategori produk | `id`, `name`, timestamps | one-to-many `products` | Category CRUD, filter | Existing | Sudah ada |
| `products` | Data produk | `id`, `category_id`, `name`, `price`, `stock`, `description`, `image_name`, timestamps | many-to-one `categories`; one-to-many cart/wishlist/order/note | Catalog, CRUD | Existing | Sudah ada |
| `cart_items` | Item cart lokal | `id`, `product_id`, `quantity`, timestamps | many-to-one `products` | Cart CRUD | Existing | Sudah ada |
| `wishlist_items` | Produk favorit | `id`, `product_id`, timestamps | many-to-one `products` | Wishlist CRUD | New | Perlu dibuat |
| `orders` | Simulasi order | `id`, `order_code`, `status`, `total_price`, `total_items`, timestamps | one-to-many `order_items` | Order CRUD | New | Perlu dibuat |
| `order_items` | Detail order | `id`, `order_id`, `product_id`, `product_name_snapshot`, `price_snapshot`, `quantity`, `subtotal`, `created_at` | many-to-one `orders` | Order Detail | New | Perlu dibuat |
| `product_notes` | Note/review lokal | `id`, `product_id`, `note_text`, timestamps | many-to-one `products` | Product Note CRUD | New | Perlu dibuat |

### 10.2 SharedPreferences data

Tetap 6 key existing: `user_name`, `is_dark_mode`, `last_selected_category_id`, `product_sort_type`, `preferred_view_mode`, `cart_last_opened`.

### 10.3 Seed data

Seed existing kategori/produk dipertahankan. Seed untuk wishlist/order/note tidak wajib; lebih baik data terbentuk dari demo user agar alurnya terlihat.

### 10.4 Temporary UI state

Temporary state mencakup selected tab, selected category UI, form controllers, loading flag, error message, chart filter, dan selected order status. State sementara tidak disimpan ke database kecuali menjadi data utama.

---

## 11. SharedPreferences Requirements

| Key | Fungsi | Tipe | Default | Screen | Penanggung jawab | Requirement | Status |
|---|---|---|---|---|---|---|---|
| `user_name` | Nama user | String | `Guest` | Settings, Home | Anggota 3 | 2 key/orang | Sudah ada |
| `is_dark_mode` | Tema gelap | bool | false | App, Settings | Anggota 3 | 2 key/orang | Sudah ada |
| `last_selected_category_id` | Kategori terakhir | int? | null/all | Home, Settings | Anggota 1 | 2 key/orang | Sudah ada |
| `product_sort_type` | Sort produk | String | `default` | Home, Settings | Anggota 1 | 2 key/orang | Sudah ada, validasi perlu enhancement |
| `preferred_view_mode` | Grid/list | String | `grid` | Home, Settings | Anggota 2 | 2 key/orang | Sudah ada |
| `cart_last_opened` | Waktu cart dibuka | String ISO? | null | Cart, Settings | Anggota 2 | 2 key/orang | Sudah ada |

Tidak perlu key baru kecuali ada alasan kuat. Data utama Tugas Besar tetap di SQLite.

---

## 12. CRUD Requirements

| CRUD | Entity | Create | Read | Update | Delete | Screen | Status | Risiko |
|---|---|---|---|---|---|---|---|---|
| Category CRUD | `categories` | Add category | List/category by id | Edit category | Delete category | Manage Category/Form | Existing | Duplicate belum divalidasi |
| Product CRUD | `products` | Add product | List/detail | Edit product | Delete product | Manage Product/Form | Existing | Delete berdampak ke cart |
| Cart Item CRUD | `cart_items` | Add to cart | View cart | Update quantity | Delete/clear cart | Detail/Cart | Existing enhanced | Stok max perlu fix |
| Wishlist CRUD | `wishlist_items` | Add wishlist | View wishlist | Toggle/refresh | Remove | Wishlist/Detail | New | Duplicate product |
| Order Simulation CRUD | `orders` | Create order | Order list/detail | Update status | Delete/cancel | Cart/Orders/Detail | New | Jangan jadi payment real |
| Product Note CRUD | `product_notes` | Add note | Read notes | Edit note | Delete note | Detail/Notes | New | Note kosong |

---

## 13. Functional Requirements

### Catalog

FR-001 Sistem harus dapat menampilkan produk dari SQLite.  
FR-002 Sistem harus dapat menampilkan kategori dari SQLite.  
FR-003 Sistem harus dapat memfilter produk berdasarkan kategori.  
FR-004 Sistem harus dapat mengurutkan produk.  
FR-005 Sistem harus dapat menampilkan grid/list sesuai preference.  
FR-006 Sistem harus menampilkan empty/error/loading state.

### Product Detail

FR-007 Sistem harus dapat menampilkan detail produk berdasarkan `productId`.  
FR-008 Sistem harus dapat menambahkan produk ke cart.  
FR-009 Sistem harus mencegah Add to Cart jika melebihi stok.  
FR-010 Sistem harus dapat toggle wishlist.  
FR-011 Sistem harus dapat membuka product notes.

### Cart

FR-012 Sistem harus dapat create/read/update/delete cart item.  
FR-013 Sistem harus menghitung subtotal dan total.  
FR-014 Sistem harus menyimpan `cart_last_opened`.  
FR-015 Sistem harus dapat membuat order simulation dari cart.  

### Wishlist

FR-016 Sistem harus dapat menambah produk ke wishlist.  
FR-017 Sistem harus dapat menampilkan wishlist.  
FR-018 Sistem harus mencegah duplikasi wishlist.  
FR-019 Sistem harus dapat menghapus wishlist item.

### Order Simulation

FR-020 Sistem harus dapat membuat order dari cart.  
FR-021 Sistem harus menyimpan snapshot nama/harga produk.  
FR-022 Sistem harus dapat menampilkan daftar order.  
FR-023 Sistem harus dapat menampilkan detail order.  
FR-024 Sistem harus dapat update status order lokal.  
FR-025 Sistem harus dapat cancel/delete order.

### Product Note/Review

FR-026 Sistem harus dapat menambah note lokal produk.  
FR-027 Sistem harus dapat membaca note per produk.  
FR-028 Sistem harus dapat mengedit note.  
FR-029 Sistem harus dapat menghapus note.  
FR-030 Sistem harus memvalidasi note tidak kosong.

### Product Management

FR-031 Sistem harus dapat Product CRUD.  
FR-032 Sistem harus memvalidasi nama, kategori, harga, dan stok.

### Category Management

FR-033 Sistem harus dapat Category CRUD.  
FR-034 Sistem harus menolak delete category jika masih digunakan produk.

### Statistics/Chart

FR-035 Sistem harus dapat menampilkan statistik lokal.  
FR-036 Sistem harus dapat menampilkan chart produk per kategori.  
FR-037 Sistem harus menampilkan empty chart jika data kosong.

### Preferences

FR-038 Sistem harus dapat save/load 6 key SharedPreferences.  
FR-039 Sistem harus menampilkan default value jika key belum ada.

### Custom Widget

FR-040 Sistem harus memiliki minimal 1 custom widget per anggota.  
FR-041 Custom widget harus reusable dan memiliki props.

### Custom Drawing/Gesture

FR-042 Sistem harus memiliki custom drawing atau gesture tambahan.  
FR-043 Widget custom drawing/gesture harus dipakai dalam flow nyata.

### Local Storage

FR-044 Data utama harus tersimpan di SQLite.  
FR-045 Preferensi harus tersimpan di SharedPreferences.  
FR-046 Produk/cart/order/wishlist/note tidak boleh disimpan di SharedPreferences.

### Provider

FR-047 Sistem harus memakai Provider untuk state global sederhana.  
FR-048 Provider tidak boleh menggantikan semua state lokal secara berlebihan.

### Regression Safety

FR-049 Fitur Assessment 2 tidak boleh rusak.  
FR-050 Sistem tidak boleh memakai Maps/backend/payment production.

---

## 14. Non-Functional Requirements

1. UI harus mudah dipakai dan dipresentasikan.
2. Query SQLite harus cukup ringan untuk data demo.
3. Data SQLite dan SharedPreferences harus persist setelah restart.
4. Kode harus modular: model, helper, provider, screen, widget.
5. Desain harus konsisten dengan A2.
6. Semua screen utama harus mobile responsive.
7. Button/tap target harus nyaman.
8. Provider digunakan secara sederhana.
9. Chart tidak boleh terlalu kompleks.
10. Demo harus berjalan tanpa internet.
11. Setiap fitur Must Have harus punya manual test.
12. Semua perubahan harus menjaga regression safety A2.

---

## 15. UI/UX Requirements

Design final mempertahankan style A2: clean, bold, minimal, monochrome, streetwear-inspired, mobile-first, product-focused, dan tidak generic. Screen baru harus mengikuti design system lama.

Screen existing dipertahankan: Splash, Home, Product Detail, Cart, Manage, Manage Product, Product Form, Manage Category, Category Form, Settings.

Screen baru: Wishlist, Orders/Order History, Order Detail, Product Notes, Statistics/Chart.

State wajib: default, loading, empty, error, success, validation, delete confirmation.

Dilarang: Maps UI, payment UI, shipping/address UI, login/register production, dashboard enterprise, chart terlalu ramai, marketplace copywriting.

`design_handoff.md` final dibuat setelah hasil UI Google Stitch final selesai.

---

## 16. Library Requirements

| Library | Tujuan | Fitur | Alasan | Risiko | Alternatif |
|---|---|---|---|---|---|
| `shared_preferences` | Key-value preference | Settings/theme/home prefs | Sudah ada dan wajib | Disalahgunakan untuk data utama | Tidak perlu alternatif |
| `provider` | State management | Theme/cart/wishlist/order/statistics | Sederhana dan mudah dijelaskan | Over-engineering | `setState` lokal |
| `fl_chart` | Chart lokal | Statistics | Memenuhi chart requirement | UI ramai/version conflict | Stat cards jika fallback |
| `intl` | Format tanggal/harga | Currency/date/order | Sudah ada di source code | Version conflict | Formatter manual |

Maps library dilarang: `google_maps_flutter`, `flutter_map`, `mapbox_maps_flutter`, dan library Maps lain.

---

## 17. Custom Widget Requirements

| Anggota | Widget | Tujuan | Props/data | Screen | Status |
|---|---|---|---|---|---|
| Anggota 1 | `ProductCard` | Card produk | name, category, price, stock, image, onTap | Home | Existing |
| Anggota 1 | `WishlistToggleButton` | Toggle wishlist | productId, isActive, callback | Home/Detail | New |
| Anggota 2 | `CartItemTile` | Item cart | product, price, quantity, callbacks | Cart | Existing |
| Anggota 2 | `QuantityControl` | Plus/minus | quantity, callbacks | Cart | Existing |
| Anggota 2 | `OrderStatusStepper` | Status order custom drawing | status, steps | Order Detail | New |
| Anggota 3 | `PreferenceSelect` | Dropdown preference | label, options, value | Settings | Existing |
| Anggota 3 | `SettingTile` | Row setting | title, subtitle, trailing | Settings | Existing |
| Anggota 3 | `StatCard` | Statistik summary | title, value, caption | Statistics | New |

---

## 18. Custom Drawing / Gesture Requirement

Pilihan utama: **CustomPaint `OrderStatusStepper`** untuk order simulation.

Konsep: stepper visual dengan lingkaran, garis penghubung, label status, dan active step.  
Screen: Order Detail.  
Alasan: relevan dengan order simulation, tidak butuh dependency, jelas memenuhi custom drawing, dan mudah dijelaskan saat presentasi.  
Risiko: jika terlalu kompleks, batasi ke 4 step sederhana.

Alternatif jika CustomPaint gagal: `SwipeActionTile` untuk cart/wishlist. Namun CustomPaint tetap rekomendasi utama.

---

## 19. Acceptance Criteria

### Project final

1. App berjalan di Android.
2. Fitur A2 tetap berjalan.
3. Wishlist, Order Simulation, Product Note, Statistics tersedia.
4. Tidak ada Maps/backend/payment.
5. SQLite dan SharedPreferences bisa didemokan.
6. Minimal 6 CRUD berjalan.
7. Provider dan chart digunakan.
8. Custom widget per anggota tersedia.
9. Custom drawing/gesture tersedia.

### SQLite

1. Tabel lama tetap ada.
2. Tabel baru dibuat via migration.
3. CRUD 6 entity berjalan.
4. Data persist setelah restart.

### SharedPreferences

1. 6 key bisa save/load.
2. Setiap anggota bisa menjelaskan 2 key.
3. Value persist setelah restart.

### UI/UX

1. Style A2 konsisten.
2. Screen baru punya state.
3. Tidak ada UI out of scope.
4. Chart sederhana dan jelas.

### Regression A2

1. Home tetap tampil.
2. Product Detail tetap tampil.
3. Cart tetap bekerja.
4. Product CRUD tetap bekerja.
5. Category CRUD tetap bekerja.
6. Settings tetap bekerja.

---

## 20. Assumptions

1. Source code audit terakhir adalah ground truth.
2. Database baseline version 1.
3. Provider dan fl_chart belum ada.
4. SharedPreferences 6 key sudah ada.
5. Maps tidak digunakan.
6. Tim terdiri dari 3 orang.
7. Tugas Besar menghitung 6 CRUD berdasarkan entity/module CRUD.
8. Ada hal yang masih perlu verifikasi manual: usage `dummy_data.dart`, refresh preference dengan IndexedStack, dan kondisi source code terbaru jika sudah berubah setelah audit.

---

## 21. Risks

| Risiko | Dampak | Mitigasi |
|---|---|---|
| Migration gagal | Data lama hilang | Backup, version 2, `onUpgrade`, no drop |
| Fitur A2 rusak | Demo gagal | Regression test |
| Provider berlebihan | Kode sulit dijelaskan | Batasi Provider |
| Chart terlalu kompleks | UI ramai | Chart sederhana |
| CustomPaint sulit | Requirement tertunda | Stepper sederhana |
| Stok cart invalid | Order tidak realistis | Validasi stok |
| Preference refresh lambat | UI tidak update | Provider/refresh callback |
| Maps masuk | Melanggar constraint | Forbidden di AGENTS |
| Scope creep | Project melebar | Tegaskan local-first |

---

## 22. MVP Final Scope

### Must Have

1. A2 baseline aman.
2. Migration database.
3. Wishlist CRUD.
4. Order Simulation CRUD.
5. Product Note CRUD.
6. Statistics/Chart.
7. Provider sederhana.
8. SharedPreferences 6 key.
9. Custom widget per anggota.
10. CustomPaint OrderStatusStepper.
11. No Maps.

### Should Have

1. Splash initial.
2. Error state Home/Cart.
3. Auto-save sort/view.
4. Route helper sederhana.
5. Duplicate validation.

### Could Have

1. Swipe action.
2. Local reset data.
3. Export summary.
4. Theme polish.

### Drop/Avoid

Maps, backend/API production, payment gateway, checkout real, shipping/address, push notification, upload image, marketplace multi-seller, dashboard enterprise.

---

## 23. Prioritas Pengerjaan

1. Backup baseline A2.
2. Stabilization fix A2.
3. Finalize PRD/TDD/task docs.
4. Migration database.
5. Model/helper baru.
6. Provider setup.
7. UI tambahan via Stitch.
8. Design handoff final.
9. Implement Wishlist.
10. Implement Order.
11. Implement Notes.
12. Implement Statistics.
13. Implement CustomPaint.
14. Regression test.
15. Final documentation/presentation.

---

## 24. Pembagian Kerja Tim

| Anggota | Fokus | CRUD | SharedPreferences | Custom Widget | File/screen |
|---|---|---|---|---|---|
| Anggota 1 | Product, Category, Catalog, Wishlist | Category, Product, Wishlist | `last_selected_category_id`, `product_sort_type` | `ProductCard`, `CategoryChip`, `WishlistToggleButton` | Home, Detail, Manage Product, Manage Category, Wishlist |
| Anggota 2 | Cart, Order Simulation, Chart | Cart, Order | `preferred_view_mode`, `cart_last_opened` | `CartItemTile`, `QuantityControl`, `OrderStatusStepper`, `StatCard` | Cart, Orders, Order Detail, Statistics |
| Anggota 3 | Settings, SharedPreferences, Review/Note, UI consistency | Product Note | `user_name`, `is_dark_mode` | `PreferenceSelect`, `SettingTile`, `NoteCard` | Settings, Notes, shared widgets |

---

## 25. Final Scope Statement

**Laviade Studio Mobile — Local Commerce Simulation** adalah aplikasi Flutter mobile local-first yang melanjutkan baseline Assessment 2 **Laviade Studio Mobile — Local Catalog & Cart**. Project final mempertahankan katalog produk, detail produk, cart lokal, product/category/cart CRUD, SQLite, SharedPreferences, bottom navigation, dan reusable UI dari Assessment 2. Untuk memenuhi Tugas Besar, aplikasi diperluas dengan wishlist lokal, order simulation lokal, product note/review lokal, chart/statistik lokal, Provider sederhana, custom widget per anggota, dan CustomPaint `OrderStatusStepper`.

Project tetap simulasi lokal akademik, tidak menggunakan Maps, tidak memakai backend/API production, tidak memakai payment gateway real, dan tidak menjadi marketplace production.

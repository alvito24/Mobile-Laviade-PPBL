# AGENTS.md

# AI Coding Agent Rules

## Laviade Studio Mobile — Local Catalog & Cart

---

## Project Context

### Nama Project

**Laviade Studio Mobile — Local Catalog & Cart**

### Tujuan Project

Project ini adalah aplikasi mobile Flutter sederhana untuk menampilkan katalog produk streetwear Laviade, mengelola data produk dan kategori, mengelola cart lokal, serta menyimpan preferensi pengguna.

Project ini dibuat untuk **Assessment 2 mata kuliah PPBL** dengan fokus utama pada penerapan:

1. SQLite untuk penyimpanan data lokal.
2. SharedPreferences untuk penyimpanan preferensi user.

Aplikasi ini bukan full e-commerce online. Project ini adalah local-first mobile catalog dan cart simulation app.

### Target User

1. **Customer**
   Pengguna yang melihat katalog produk, membuka detail produk, menambahkan produk ke cart, mengubah quantity cart, dan mengatur preferensi sederhana.

2. **Pengelola Data Demo**
   Pengguna yang mengelola data produk dan kategori untuk kebutuhan demo CRUD SQLite.

Catatan: Project ini tidak menggunakan login, register, atau role-based authentication. Perbedaan role hanya berdasarkan menu dan fungsi aplikasi.

### Tech Stack

* Mobile: Flutter
* Language: Dart
* State management: `setState`, `FutureBuilder`, dan state bawaan Flutter sederhana
* Local database: SQLite
* Local preferences: SharedPreferences
* Backend: Tidak ada backend
* API: Tidak ada API
* Authentication: Tidak ada login/register
* Styling/UI: Flutter Material Components dengan custom styling sederhana

### Level Project

Project ini adalah project akademik Assessment 2.
Prioritas utama adalah:

1. Correctness.
2. Simplicity.
3. Readability.
4. Maintainability.
5. Kemudahan presentasi dan tes coding.
6. Kesesuaian dengan PRD dan Technical Design.

Jangan membuat solusi terlalu kompleks seperti production-grade enterprise app.

### Batasan Utama

Agent harus menjaga scope project agar tetap sesuai Assessment 2.

Tidak boleh membuat:

1. Backend.
2. API online.
3. Login/register.
4. Payment gateway.
5. Checkout real.
6. Shipping.
7. Order history.
8. Address management.
9. Wishlist.
10. Maps.
11. Chart.
12. Push notification.
13. Upload gambar.
14. Product size selection.
15. Recently viewed.
16. Review/rating produk.
17. Fitur tambahan di luar PRD dan Technical Design.

---

## Core Principles

1. Jangan over-engineering.
2. Prioritaskan correctness, readability, dan maintainability.
3. Ikuti PRD, Technical Design Document, dan scope final Assessment 2.
4. Ikuti struktur project yang sudah ada.
5. Jangan rewrite besar-besaran tanpa alasan yang jelas.
6. Jangan menambah dependency baru tanpa izin.
7. Jangan menghapus fitur existing tanpa konfirmasi.
8. Jangan membuat fitur di luar scope.
9. Jangan mengubah database schema tanpa menjelaskan dampaknya.
10. Jangan membuat logic yang sulit dijelaskan saat presentasi atau tes coding.
11. Gunakan solusi yang realistis untuk mahasiswa dan project assessment.
12. Jika ada pilihan antara solusi sederhana dan solusi kompleks, pilih solusi sederhana selama memenuhi requirement.
13. Jangan membuat UI terlihat seperti template generic atau terlalu berlebihan.
14. Jangan membuat kode hanya “asal jalan”; pastikan mudah dipahami dan diuji.
15. Selalu jaga agar aplikasi tetap local-first dan tidak bergantung pada server.

---

## Workflow Rules

Saat menerima task, AI Agent harus mengikuti aturan kerja berikut:

1. Baca context project terlebih dahulu.
2. Pahami bahwa project ini adalah Flutter local-first app untuk Assessment 2.
3. Analisis struktur file yang relevan sebelum mengubah kode.
4. Jelaskan rencana singkat sebelum coding.
5. Implementasikan satu task kecil dalam satu waktu.
6. Jangan mengubah file yang tidak relevan.
7. Jangan mengubah struktur besar project tanpa alasan kuat.
8. Jangan membuat fitur tambahan di luar task.
9. Jangan menambahkan dependency baru tanpa izin.
10. Setelah selesai, jelaskan file apa saja yang dibuat atau diubah.
11. Jelaskan alasan perubahan.
12. Berikan cara testing manual.
13. Sebutkan risiko, batasan, atau TODO jika ada.
14. Jika task berisiko merusak fitur lain, sarankan membuat commit/checkpoint terlebih dahulu.
15. Jika menemukan requirement yang ambigu, jelaskan asumsi yang digunakan sebelum implementasi.
16. Jika fitur yang diminta berpotensi keluar scope, beri peringatan dan sarankan versi yang lebih sederhana.

---

## Coding Standards

### General Coding Rules

1. Gunakan naming yang jelas dan konsisten.
2. Hindari duplikasi kode.
3. Pisahkan logic sesuai tanggung jawab file.
4. Jangan menaruh logic database langsung di UI jika bisa dipisahkan.
5. Jangan menaruh logic berat di widget.
6. Gunakan validasi input pada form.
7. Gunakan error handling sederhana.
8. Jangan hardcode secret, token, API key, password, atau credential.
9. Gunakan komentar hanya jika membantu menjelaskan logic yang tidak langsung jelas.
10. Jangan membuat abstraction berlebihan.
11. Jangan membuat class/helper yang tidak digunakan.
12. Jangan membuat file baru jika file existing masih relevan.
13. Pastikan kode mudah dijelaskan saat presentasi.
14. Pastikan setiap fitur yang dibuat bisa diuji secara manual.

### Naming Rules

Gunakan nama yang deskriptif.

Contoh yang baik:

* `ProductModel`
* `CategoryModel`
* `CartItemModel`
* `DatabaseHelper`
* `PreferenceHelper`
* `ProductCard`
* `CartItemTile`
* `ManageProductScreen`
* `ProductFormScreen`

Hindari nama ambigu seperti:

* `Data`
* `Helper2`
* `Page1`
* `Temp`
* `TestWidget`
* `NewScreen`

### Validation Rules

Setiap form harus memiliki validasi sederhana.

Product Form:

1. Nama produk wajib diisi.
2. Kategori wajib dipilih.
3. Harga harus lebih dari 0.
4. Stok tidak boleh negatif.
5. Image name boleh kosong atau menggunakan placeholder default.
6. Deskripsi boleh kosong atau singkat.

Category Form:

1. Nama kategori wajib diisi.
2. Nama kategori tidak boleh hanya berisi spasi.

Cart:

1. Quantity minimal 1.
2. Quantity tidak boleh negatif.
3. Quantity tidak boleh melebihi stok produk jika validasi stok diterapkan.
4. Jika produk yang sama ditambahkan lagi, quantity bertambah, bukan membuat item duplikat.

SharedPreferences:

1. Jika key belum ada, gunakan default value.
2. Preferred view hanya boleh `grid` atau `list`.
3. Dark mode hanya boolean.
4. Sort type harus menggunakan value yang sudah ditentukan.

---

## Architecture Rules

### Architecture Type

Gunakan arsitektur sederhana:

**Flutter Local-First App dengan Layer Sederhana**

Layer utama:

1. Presentation Layer
2. Data Layer
3. Preference Layer
4. Simple State Layer

Jangan menggunakan clean architecture yang terlalu kompleks untuk Assessment 2.

### Folder Structure Rules

Ikuti struktur folder sederhana berikut jika project belum memiliki struktur yang lebih baik:

```text
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
│
├── data/
│   ├── database/
│   ├── preferences/
│   └── seed/
│
├── models/
│
├── screens/
│   ├── home/
│   ├── cart/
│   ├── manage/
│   └── settings/
│
├── widgets/
│
└── navigation/
```

### Flutter-Specific Rules

1. Pisahkan screen, widget, model, database helper, dan preference helper.
2. Gunakan `setState` atau `FutureBuilder` untuk state sederhana.
3. Jangan menggunakan Provider, Riverpod, Bloc, GetX, atau state management eksternal kecuali diminta.
4. Jangan membuat screen terlalu besar jika bisa dipecah menjadi widget sederhana.
5. Gunakan widget reusable untuk komponen yang dipakai berulang.
6. Gunakan `ListView` untuk list yang bisa scroll.
7. Gunakan `GridView` jika product catalog memakai mode grid.
8. Gunakan `TextField` atau `TextFormField` untuk form.
9. Gunakan `DropdownButtonFormField` untuk pilihan kategori.
10. Gunakan `SnackBar` untuk feedback sukses/error sederhana.
11. Gunakan `AlertDialog` untuk konfirmasi delete.
12. Gunakan `BottomNavigationBar` atau `NavigationBar` untuk navigasi utama.

### SQLite Rules

SQLite hanya digunakan untuk data utama berikut:

1. `categories`
2. `products`
3. `cart_items`

Jangan menambahkan tabel baru tanpa izin.

Schema utama:

`categories`:

* id
* name
* created_at
* updated_at

`products`:

* id
* category_id
* name
* price
* stock
* description
* image_name
* created_at
* updated_at

`cart_items`:

* id
* product_id
* quantity
* created_at
* updated_at

Rules SQLite:

1. Logic SQLite harus berada di database helper atau data layer.
2. Jangan menaruh query langsung di widget.
3. Gunakan method yang jelas seperti:

   * `insertCategory`
   * `getCategories`
   * `updateCategory`
   * `deleteCategory`
   * `insertProduct`
   * `getProducts`
   * `getProductById`
   * `updateProduct`
   * `deleteProduct`
   * `addToCart`
   * `getCartItems`
   * `updateCartQuantity`
   * `deleteCartItem`
4. Saat menghapus kategori, cek apakah kategori masih digunakan produk.
5. Jika kategori masih digunakan produk, jangan hapus kategori.
6. Saat menambahkan produk ke cart, cek apakah produk sudah ada.
7. Jika produk sudah ada di cart, update quantity.
8. Jika produk belum ada di cart, insert item baru.

### SharedPreferences Rules

SharedPreferences hanya digunakan untuk preferensi sederhana.

Gunakan 6 key berikut:

1. `user_name`
2. `is_dark_mode`
3. `last_selected_category_id`
4. `product_sort_type`
5. `preferred_view_mode`
6. `cart_last_opened`

Rules:

1. Jangan simpan produk, kategori, atau cart di SharedPreferences.
2. Jangan simpan data sensitif di SharedPreferences.
3. Gunakan default value jika key belum ada.
4. Buat preference helper agar logic tidak tercecer di screen.
5. Pastikan setiap key bisa didemokan saat presentasi.
6. Jangan menambahkan key baru tanpa alasan dan izin.

---

## UI Rules

### General UI Rules

1. Ikuti design direction Laviade Studio.
2. UI harus simple, clean, mobile-first, dan tidak over-engineering.
3. Gunakan visual monochrome, off-white, hitam, putih, dan abu-abu.
4. Hindari tampilan template generic.
5. Hindari gradient random.
6. Hindari icon/dekorasi random tanpa fungsi jelas.
7. Hindari animasi kompleks.
8. Gunakan spacing yang konsisten.
9. Gunakan typography yang jelas.
10. Pastikan visual hierarchy mudah dipahami.
11. Pastikan tap target cukup besar untuk mobile.
12. Pastikan layout tidak overflow.
13. Pastikan screen bisa di-scroll jika konten panjang.
14. Jangan membuat desain yang membutuhkan custom painter atau animasi kompleks.
15. Jangan membuat UI yang membutuhkan backend/API.

## UI Implementation Rules

Bagian ini mengatur bagaimana AI Agent harus mengimplementasikan UI berdasarkan Design Handoff Specification final untuk project **Laviade Studio Mobile — Local Catalog & Cart**.

Project ini adalah Flutter mobile app local-first untuk Assessment 2 PPBL. Fokus UI adalah katalog produk lokal, product/category CRUD, cart lokal sederhana, dan settings SharedPreferences. Jangan membuat UI yang mengarah ke full e-commerce online.

---

### 1. Design Direction

AI Agent harus mempertahankan arah desain berikut:

1. Desain harus terasa seperti **mobile catalog streetwear lokal**.
2. Visual harus **clean, bold, minimal, monochrome, dan streetwear-inspired**.
3. UI harus mobile-first dan nyaman digunakan pada layar Android.
4. Fokus visual utama ada pada:

   * produk,
   * kategori,
   * harga,
   * stok,
   * cart,
   * form CRUD,
   * preferences.
5. Jangan membuat UI terlalu fancy, terlalu ramai, atau terlalu mirip template AI generic.
6. Jangan membuat tampilan marketplace penuh seperti Shopee/Tokopedia.
7. Jangan membuat tampilan SaaS dashboard.
8. Jangan menggunakan gradient random, icon dekoratif berlebihan, shadow berat, atau animasi kompleks.
9. UI harus realistis untuk dibuat dengan Flutter Material Components.
10. Prioritas utama adalah clarity, usability, dan implementability, bukan visual yang terlalu “wah”.

---

### 2. Color Tokens

Gunakan color token berikut secara konsisten.

```dart
colorPrimary = #111111
colorOnPrimary = #FFFFFF
colorBackground = #F9F9F6
colorSurface = #FFFFFF
colorSurfaceMuted = #F1F1EE
colorTextPrimary = #111111
colorTextSecondary = #666666
colorBorder = #DADAD7
colorAccent = #D8CBB8
colorError = #BA1A1A
colorSuccess = #12B76A
colorWarning = #F79009
```

Rules:

1. Background utama gunakan off-white, bukan pure white jika memungkinkan.
2. Primary button gunakan black background dan white text.
3. Card gunakan white/surface background dengan border tipis.
4. Error dan success boleh memakai warna, tetapi tetap harus memiliki text yang jelas.
5. Jangan menambahkan warna baru tanpa alasan kuat.
6. Jangan memakai gradient.
7. Jangan memakai warna neon atau warna marketplace yang tidak sesuai brand Laviade.
8. Jangan membuat semua elemen hitam pekat; gunakan gray/muted text untuk hierarchy.

---

### 3. Typography Rules

Gunakan typography yang sederhana, jelas, dan konsisten.

Jika font custom tersedia:

1. Heading: Archivo Narrow atau font bold/condensed sejenis.
2. Body: Inter atau font sans-serif readable.

Jika font custom tidak tersedia:

1. Gunakan default Flutter font.
2. Gunakan font weight dan size untuk membentuk hierarchy.

Rekomendasi type scale:

```text
Display: 40–48, weight 700
Headline Large: 28–32, weight 700
Headline Medium: 22–24, weight 600/700
Body Large: 16, weight 400/500
Body Medium: 14, weight 400/500
Label: 12, weight 600/700
Caption: 11–12, weight 400/500
```

Rules:

1. Screen title harus jelas dan mudah dibaca.
2. Product name harus lebih menonjol dari category/caption.
3. Harga produk harus jelas.
4. Caption/helper text tidak boleh terlalu kecil.
5. Jangan menggunakan terlalu banyak variasi ukuran font.
6. Jangan menggunakan uppercase untuk semua teks.
7. Gunakan uppercase hanya untuk label kecil seperti badge/chip jika diperlukan.
8. Validation message harus terbaca dan dekat dengan input.

---

### 4. Spacing Rules

Gunakan spacing berbasis kelipatan 4.

```text
spaceXs = 4
spaceSm = 8
spaceMd = 16
spaceLg = 24
spaceXl = 32
space2Xl = 48
```

Rules:

1. Padding horizontal screen utama: 16px.
2. Jarak antar section: 24px.
3. Jarak antar card/list item: 12–16px.
4. Padding internal card: 12–16px.
5. Tinggi button utama: 48–52px.
6. Input field harus memiliki padding vertical yang nyaman.
7. Jangan membuat elemen terlalu mepet.
8. Jangan membuat whitespace berlebihan sampai screen terasa kosong.
9. Semua form screen harus scrollable jika konten panjang.
10. Pastikan bottom navigation tidak menutupi konten.

---

### 5. Border Radius, Border, and Elevation Rules

Gunakan radius sederhana:

```text
radiusSm = 4
radiusMd = 8
radiusLg = 12
radiusFull = 999
```

Rules:

1. Button menggunakan radius 8px.
2. Card menggunakan radius 12px.
3. Chip/badge boleh menggunakan radius full.
4. Gunakan border tipis untuk card/input.
5. Hindari shadow berat.
6. Elevation boleh sangat subtle hanya jika diperlukan.
7. Jangan membuat radius terlalu besar seperti app playful/social media.

---

### 6. Component Naming Convention

Gunakan nama komponen yang jelas dan sesuai fungsi.

Recommended components:

```text
AppBottomNav
AppTopBar
PrimaryButton
SecondaryButton
CustomTextField
CustomDropdown
ProductCard
ProductListTile
ProductManageTile
CategoryManageTile
CartItemTile
QuantityControl
CategoryChip
StockBadge
SettingTile
PreferenceSelect
ProfileNameInput
SessionInfoCard
EmptyState
LoadingState
ErrorState
DeleteConfirmationDialog
SuccessSnackbar
```

Rules:

1. Nama komponen harus PascalCase.
2. Nama file menggunakan snake_case.
3. Jangan menggunakan nama ambigu seperti `CardWidget`, `Item`, `Box`, `Page1`, `Helper2`, atau `ComponentNew`.
4. Komponen yang dipakai lebih dari sekali harus dipisah ke folder `widgets/`.
5. Jangan membuat satu screen berisi semua UI tanpa reusable component.
6. Jangan membuat komponen terlalu abstrak jika hanya dipakai sekali.
7. Props/data komponen harus sesuai model dan Design Handoff.
8. Jangan membuat komponen yang membutuhkan data di luar PRD/TDD.

---

### 7. Screen Implementation Rules

Screen final yang boleh dibuat:

1. `SplashScreen`
2. `HomeScreen`
3. `ProductDetailScreen`
4. `CartScreen`
5. `ManageScreen`
6. `ManageProductScreen`
7. `ProductFormScreen`
8. `ManageCategoryScreen`
9. `CategoryFormScreen`
10. `SettingsScreen`

Rules:

1. Main tab screen menggunakan bottom navigation:

   * Home
   * Cart
   * Manage
   * Settings
2. Detail dan form screen menggunakan back button.
3. Main tab screen tidak perlu back button.
4. Jangan tampilkan cart/bag icon di top bar karena Cart sudah ada di bottom navigation.
5. Jangan membuat screen tambahan tanpa requirement.
6. Jangan membuat login/register/onboarding panjang.
7. Jangan membuat checkout/payment/shipping/order/address/wishlist screen.
8. Jangan membuat admin dashboard kompleks.
9. Jangan membuat chart/maps/notification screen.

---

### 8. Responsive Behavior

Aplikasi ditargetkan untuk Android mobile.

Rules:

1. Semua screen harus berada di dalam `SafeArea` jika diperlukan.
2. Semua screen panjang harus scrollable.
3. Form screen harus tetap usable saat keyboard muncul.
4. Bottom navigation tidak boleh menutupi konten.
5. Button, input, dan icon action harus mudah ditekan.
6. Tap target minimal sekitar 44–48px.
7. Text tidak boleh overflow.
8. Product grid harus adaptif pada lebar mobile umum.
9. Gunakan `ListView`, `SingleChildScrollView`, `GridView`, `Expanded`, atau `Flexible` dengan tepat.
10. Jangan menggunakan fixed width/height yang membuat layout mudah overflow.
11. Jangan pixel-perfect secara kaku dari desain Stitch; prioritaskan responsive Flutter layout.
12. Test minimal di satu emulator kecil dan satu emulator ukuran normal.

---

### 9. Required UI States

AI Agent wajib mempertimbangkan state berikut saat membuat screen.

#### Product Catalog

1. Default: daftar produk tampil.
2. Loading: “Memuat produk...”
3. Empty: “Belum ada produk.”
4. Error: “Data produk gagal dimuat.”

#### Product Detail

1. Default: detail produk tampil.
2. Loading: “Memuat detail produk...”
3. Error/not found: “Produk tidak ditemukan.”
4. Success: snackbar “Produk berhasil ditambahkan ke cart.”

#### Cart

1. Default: cart item dan total tampil.
2. Loading: “Memuat cart...”
3. Empty: “Cart masih kosong.”
4. Error: “Cart gagal dimuat.”
5. Success: snackbar “Cart berhasil diperbarui.”
6. Delete confirmation: “Hapus item?”

#### Manage Product

1. Default: list produk tampil.
2. Loading: “Memuat produk...”
3. Empty: “Belum ada produk.”
4. Error: “Data produk gagal dimuat.”
5. Success: snackbar “Produk berhasil disimpan.”
6. Delete confirmation: “Hapus produk?”

#### Product Form

1. Default: form kosong atau form edit terisi.
2. Loading save: “Menyimpan produk...”
3. Validation error:

   * “Nama produk wajib diisi.”
   * “Kategori wajib dipilih.”
   * “Harga harus lebih dari 0.”
   * “Stok tidak boleh negatif.”
4. Error: snackbar “Produk gagal disimpan.”
5. Success: snackbar “Produk berhasil disimpan.”

#### Manage Category

1. Default: list kategori tampil.
2. Loading: “Memuat kategori...”
3. Empty: “Belum ada kategori.”
4. Error: “Data kategori gagal dimuat.”
5. Success: snackbar “Kategori berhasil disimpan.”
6. Delete confirmation: “Hapus kategori?”
7. Delete conflict error: “Kategori tidak bisa dihapus karena masih digunakan produk.”

#### Category Form

1. Default: form kosong atau form edit terisi.
2. Loading save: “Menyimpan kategori...”
3. Validation error: “Nama kategori wajib diisi.”
4. Error: snackbar “Kategori gagal disimpan.”
5. Success: snackbar “Kategori berhasil disimpan.”

#### Settings

1. Default: preferences tampil.
2. Loading: “Memuat preferensi...”
3. Empty default: user name tampil sebagai “Guest.”
4. Error: snackbar “Preferensi gagal disimpan.”
5. Success: snackbar “Preferensi berhasil disimpan.”

---

### 10. Data Binding UI Rules

UI harus mengikuti data dari Technical Design.

SQLite tables:

1. `categories`
2. `products`
3. `cart_items`

SharedPreferences keys:

1. `user_name`
2. `is_dark_mode`
3. `last_selected_category_id`
4. `product_sort_type`
5. `preferred_view_mode`
6. `cart_last_opened`

Rules:

1. Product UI hanya boleh membutuhkan field:

   * `id`
   * `category_id`
   * `name`
   * `price`
   * `stock`
   * `description`
   * `image_name`
   * category name hasil join/lookup
2. Cart UI hanya boleh membutuhkan:

   * `cart_item_id`
   * `product_id`
   * `product_name`
   * `price`
   * `quantity`
   * `subtotal`
   * `total`
3. Settings UI hanya boleh memakai 6 key SharedPreferences yang sudah ditentukan.
4. Jangan membuat UI yang membutuhkan field database baru.
5. Jangan membuat UI untuk material, fit, care, size, color, rating, review, address, order, payment, shipping, atau wishlist.
6. Jangan membuat UI upload image. `image_name` hanya nama asset lokal.
7. Jika desain masih menampilkan detail tambahan, sederhanakan menjadi `description`.

---

### 11. Anti-Generic / Anti-AI Template Rules

Agar UI tidak terlihat seperti template AI generic, ikuti aturan berikut:

1. Jangan menggunakan gradient ungu/biru atau gradient acak.
2. Jangan menggunakan banyak shadow/glow.
3. Jangan menggunakan ilustrasi random yang tidak relevan dengan Laviade.
4. Jangan membuat card terlalu banyak dalam satu screen.
5. Jangan membuat marketplace UI yang ramai.
6. Jangan membuat dashboard statistik untuk Manage.
7. Jangan memakai icon terlalu banyak.
8. Jangan membuat CTA terlalu banyak dalam satu screen.
9. Jangan membuat text marketing berlebihan.
10. Gunakan copy yang pendek, jelas, dan fungsional.
11. Pertahankan karakter streetwear yang simple dan bold.
12. Gunakan whitespace yang cukup.
13. Fokuskan visual pada produk dan fungsi utama.
14. Gunakan placeholder image yang konsisten, bukan image random berlebihan.
15. Jangan membuat UI terlihat seperti app template SaaS.

---

### 12. Developer-Friendly Implementation Rules

UI harus mudah diimplementasikan di Flutter.

Rules:

1. Gunakan widget standar Flutter jika cukup:

   * `Scaffold`
   * `AppBar`
   * `BottomNavigationBar` / `NavigationBar`
   * `ListView`
   * `GridView`
   * `SingleChildScrollView`
   * `Column`
   * `Row`
   * `Container`
   * `Card`
   * `TextFormField`
   * `DropdownButtonFormField`
   * `Switch`
   * `SnackBar`
   * `AlertDialog`
2. Jangan membuat komponen yang membutuhkan custom painter.
3. Jangan membuat animasi kompleks.
4. Jangan membuat layout yang butuh package tambahan.
5. Jangan membuat image picker/upload.
6. Jangan membuat UI yang bergantung pada koneksi internet.
7. Jangan membuat UI yang membutuhkan backend/API.
8. Jangan membuat state management kompleks.
9. Pisahkan screen dan reusable widget.
10. Jangan menaruh semua UI dalam satu file besar.
11. Jangan menaruh query SQLite langsung di widget UI jika bisa dipisahkan.
12. Jangan membuat UI yang sulit dites secara manual.
13. Setiap action penting harus punya feedback:

* snackbar,
* validation message,
* dialog,
* empty/error state.

14. Jika implementasi desain terlalu sulit, sederhanakan tanpa mengubah fungsi utama.
15. Prioritaskan working UI yang rapi dibanding pixel-perfect yang rapuh.

---

### 13. Forbidden UI Actions

AI Agent tidak boleh melakukan hal berikut saat implementasi UI:

1. Jangan membuat login/register.
2. Jangan membuat checkout.
3. Jangan membuat payment.
4. Jangan membuat shipping.
5. Jangan membuat address.
6. Jangan membuat order history.
7. Jangan membuat wishlist.
8. Jangan membuat maps.
9. Jangan membuat chart.
10. Jangan membuat notification.
11. Jangan membuat recently viewed.
12. Jangan membuat product size selection.
13. Jangan membuat product rating/review.
14. Jangan membuat image upload.
15. Jangan membuat backend/API screen.
16. Jangan membuat admin dashboard kompleks.
17. Jangan membuat material/fit/care sebagai field terpisah.
18. Jangan membuat color/size variant selector.
19. Jangan membuat preferred view selain Grid/List.
20. Jangan membuat UI yang membutuhkan tabel database baru.
21. Jangan membuat UI yang membutuhkan SharedPreferences key baru tanpa izin.
22. Jangan menggunakan copy “cloud bucket”.
23. Jangan menggunakan copy yang mengarah ke transaksi real seperti “Proceed to Checkout”.
24. Jangan menampilkan shipping/payment/order wording.
25. Jangan membuat UI yang keluar dari scope Assessment 2.

---

### 14. Final UI Reminder

Saat mengimplementasikan UI, AI Agent harus selalu mengecek:

1. Apakah screen ini ada di PRD?
2. Apakah data yang ditampilkan ada di Technical Design?
3. Apakah UI ini bisa dibuat dengan Flutter sederhana?
4. Apakah UI ini menambah fitur baru?
5. Apakah state default/loading/empty/error/success sudah dipikirkan?
6. Apakah action user punya feedback?
7. Apakah desain masih clean, monochrome, dan streetwear-inspired?
8. Apakah implementasi ini bisa dijelaskan saat presentasi Assessment 2?

Jika jawabannya meragukan, pilih solusi yang lebih sederhana dan sesuai scope.


### Screen Rules

Screen final yang boleh dibuat:

1. Splash Screen.
2. Home / Product Catalog Screen.
3. Product Detail Screen.
4. Cart Screen.
5. Manage Screen.
6. Manage Product Screen.
7. Product Form Screen.
8. Manage Category Screen.
9. Category Form Screen.
10. Settings / Profile Screen.

Jangan membuat screen berikut:

1. Login.
2. Register.
3. Checkout.
4. Payment.
5. Shipping.
6. Address.
7. Order History.
8. Wishlist.
9. Notification.
10. Maps.
11. Chart.
12. Admin Dashboard kompleks.

### Component Rules

Gunakan komponen reusable sederhana:

1. `AppBottomNav`
2. `AppTopBar`
3. `PrimaryButton`
4. `SecondaryButton`
5. `ProductCard`
6. `ProductManageTile`
7. `CategoryManageTile`
8. `CartItemTile`
9. `QuantityControl`
10. `CategoryChip`
11. `StockBadge`
12. `CustomTextField`
13. `CustomDropdown`
14. `SettingTile`
15. `EmptyState`
16. `LoadingState`
17. `ErrorState`

### State UI Rules

Jika relevan, setiap fitur harus memiliki:

1. Default state.
2. Loading state.
3. Empty state.
4. Error state.
5. Success state.
6. Validation state.

Contoh state yang wajib dipertimbangkan:

Product Catalog:

* Empty: “Belum ada produk.”
* Loading: “Memuat produk...”
* Error: “Data produk gagal dimuat.”

Cart:

* Empty: “Cart masih kosong.”
* Error: “Cart gagal dimuat.”
* Success: “Cart berhasil diperbarui.”

Product Form:

* Validation: “Nama produk wajib diisi.”
* Validation: “Kategori wajib dipilih.”
* Validation: “Harga harus lebih dari 0.”
* Validation: “Stok tidak boleh negatif.”

Category Form:

* Validation: “Nama kategori wajib diisi.”

Settings:

* Success: “Preferensi berhasil disimpan.”
* Error: “Preferensi gagal disimpan.”

### Top Bar Rules

1. Screen utama bottom navigation tidak perlu back button.
2. Back button hanya digunakan pada detail dan form.
3. Jangan tampilkan cart/bag icon di top bar karena Cart sudah ada di bottom navigation.
4. Top bar harus sederhana dan konsisten.

---

## Testing Rules

Setiap fitur harus punya cara test manual.

### General Testing Rules

1. Minimal cek positive case dan negative case.
2. Pastikan fitur baru tidak merusak fitur existing.
3. Pastikan data SQLite tetap tersimpan setelah aplikasi ditutup dan dibuka kembali.
4. Pastikan SharedPreferences tetap tersimpan setelah aplikasi ditutup dan dibuka kembali.
5. Pastikan empty state muncul saat data kosong.
6. Pastikan validation message muncul saat input tidak valid.
7. Pastikan success feedback muncul saat aksi berhasil.
8. Jika ada command test/lint/build, sebutkan.

### Manual Test: Product CRUD

Positive case:

1. Tambah produk valid.
2. Produk muncul di Manage Product.
3. Produk muncul di Home Catalog.
4. Edit produk.
5. Data produk berubah.
6. Delete produk.
7. Produk hilang dari list.

Negative case:

1. Nama produk kosong.
2. Kategori belum dipilih.
3. Harga 0.
4. Harga negatif.
5. Stok negatif.

### Manual Test: Category CRUD

Positive case:

1. Tambah kategori valid.
2. Kategori muncul di list.
3. Edit kategori.
4. Delete kategori yang belum dipakai produk.

Negative case:

1. Nama kategori kosong.
2. Nama kategori hanya spasi.
3. Delete kategori yang masih digunakan produk.

### Manual Test: Cart

Positive case:

1. Tambah produk ke cart.
2. Produk muncul di cart.
3. Tambah produk yang sama lagi.
4. Quantity bertambah.
5. Update quantity.
6. Total berubah.
7. Delete item cart.

Negative case:

1. Quantity 0.
2. Quantity negatif.
3. Produk tidak ditemukan.
4. Quantity melebihi stok jika validasi stok diterapkan.

### Manual Test: SharedPreferences

Positive case:

1. Simpan user name.
2. Ubah dark mode.
3. Pilih sort type.
4. Pilih view mode.
5. Buka cart untuk menyimpan cart last opened.
6. Tutup aplikasi.
7. Buka kembali aplikasi.
8. Preferences tetap tersimpan.

Negative case:

1. Key belum pernah disimpan.
2. Preferred view value tidak dikenal.
3. Last selected category mengarah ke kategori yang sudah dihapus.

### Build / Run Check

Jika Flutter project sudah tersedia, gunakan command berikut saat relevan:

```bash
flutter pub get
flutter analyze
flutter run
flutter build apk
```

Agent harus menjelaskan hasil command jika menjalankannya.

---

## Git / Change Management Rules

1. Satu task = satu perubahan kecil.
2. Jangan menggabungkan banyak fitur dalam satu implementasi.
3. Jelaskan perubahan sebelum coding.
4. Jelaskan perubahan setelah coding.
5. Jika perubahan berisiko, sarankan commit/checkpoint dulu.
6. Jangan menghapus file penting tanpa konfirmasi.
7. Jangan mengubah struktur folder besar tanpa alasan.
8. Jangan mengubah database schema tanpa menjelaskan dampaknya.
9. Jika perubahan gagal, jelaskan rollback atau cara memperbaikinya.
10. Jika ada bug di luar task, catat sebagai TODO, jangan langsung mengubah banyak hal.

Contoh task yang baik:

* Implement Product Model.
* Implement Category CRUD.
* Implement Product Form validation.
* Implement Add to Cart.
* Implement SharedPreferences helper.
* Add empty state for cart.

Contoh task yang buruk:

* Build entire app.
* Create full e-commerce.
* Add checkout and payment.
* Redesign all screens.
* Rewrite all database logic.

---

## Forbidden Actions

AI Agent tidak boleh melakukan hal berikut:

1. Jangan rewrite seluruh project.
2. Jangan mengubah stack tanpa izin.
3. Jangan menghapus file penting tanpa konfirmasi.
4. Jangan membuat dependency baru tanpa alasan kuat dan izin.
5. Jangan menyimpan secret, token, password, atau API key di kode.
6. Jangan membuat fitur tambahan yang tidak diminta.
7. Jangan mengubah database schema tanpa menjelaskan dampaknya.
8. Jangan membuat backend/API.
9. Jangan membuat login/register.
10. Jangan membuat payment gateway.
11. Jangan membuat checkout real.
12. Jangan membuat shipping atau address management.
13. Jangan membuat order history.
14. Jangan membuat wishlist.
15. Jangan membuat maps.
16. Jangan membuat chart.
17. Jangan membuat push notification.
18. Jangan membuat upload gambar.
19. Jangan membuat product size selection.
20. Jangan membuat recently viewed.
21. Jangan membuat review/rating.
22. Jangan menambahkan Provider/Riverpod/Bloc/GetX tanpa izin.
23. Jangan menaruh query SQLite langsung di UI widget.
24. Jangan menyimpan data produk/kategori/cart di SharedPreferences.
25. Jangan membuat UI yang membutuhkan data atau field yang tidak ada di Technical Design.
26. Jangan membuat fitur yang sulit dijelaskan saat presentasi Assessment 2.
27. Jangan membuat solusi enterprise/production-grade yang terlalu berat untuk scope project ini.

---

## Final Reminder for AI Agent

Project ini harus tetap sederhana, jelas, dan sesuai Assessment 2.

Prioritas utama:

1. SQLite berjalan untuk categories, products, dan cart_items.
2. SharedPreferences berjalan untuk 6 key yang sudah ditentukan.
3. Product CRUD lengkap.
4. Category CRUD lengkap.
5. Cart management sederhana berjalan.
6. UI sesuai desain final dan realistis untuk Flutter.
7. Setiap fitur bisa dijelaskan dan dites manual.

Jika ada konflik antara keinginan membuat fitur menarik dan scope project, pilih scope project.

Jangan mengejar aplikasi yang terlihat besar.
Bangun aplikasi kecil yang benar, stabil, mudah dipahami, dan sesuai requirement.

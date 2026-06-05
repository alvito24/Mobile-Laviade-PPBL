# TECHNICAL_DESIGN.md

# Technical Design Document

## Laviade Studio Mobile — Local Catalog & Cart

---

## Project Information

### Project Name

**Laviade Studio Mobile — Local Catalog & Cart**

### Tech Stack

* **Frontend / Mobile:** Flutter
* **Backend:** Tidak menggunakan backend. Semua proses berjalan secara lokal di aplikasi.
* **Database:** SQLite untuk data utama aplikasi.
* **Local Preferences:** SharedPreferences untuk penyimpanan preferensi user.
* **Styling / UI:** Flutter Material Components dengan custom styling sederhana.
* **Target Platform:** Android emulator / Android device.
* **Scope:** Assessment 2 PPBL.
* **Main Focus:** SQLite + SharedPreferences.

---

## 1. Technical Overview

Laviade Studio Mobile — Local Catalog & Cart adalah aplikasi mobile Flutter yang berjalan secara lokal tanpa backend. Aplikasi ini digunakan untuk menampilkan katalog produk streetwear Laviade, mengelola data produk dan kategori, mengelola cart sederhana, serta menyimpan preferensi user.

Data utama seperti kategori, produk, dan cart disimpan menggunakan SQLite. Data preferensi seperti nama user, tema aplikasi, kategori terakhir yang dipilih, jenis sorting produk, mode tampilan katalog, dan waktu terakhir membuka cart disimpan menggunakan SharedPreferences.

Pendekatan teknis yang digunakan dibuat sederhana dan realistis untuk Assessment 2. Project tidak menggunakan arsitektur enterprise, tidak menggunakan backend API, tidak menggunakan authentication, dan tidak menggunakan state management eksternal yang kompleks. Struktur aplikasi dibuat modular secukupnya agar mudah dipahami, mudah diuji, dan mudah dijelaskan saat presentasi.

### Fokus Teknis

1. Menyimpan dan membaca data dari SQLite.
2. Melakukan CRUD produk.
3. Melakukan CRUD kategori.
4. Mengelola cart sederhana.
5. Menyimpan minimal 6 key SharedPreferences.
6. Menampilkan UI sederhana yang clean dan tidak over-engineering.
7. Menyediakan struktur folder yang cukup rapi untuk dikembangkan ke tugas besar.

---

## 2. Architecture

### Jenis Arsitektur

Project ini menggunakan pendekatan:

**Flutter Local-First App dengan Layer Sederhana**

Aplikasi tidak menggunakan client-server architecture karena tidak ada backend. Semua data disimpan dan dikelola langsung di perangkat menggunakan SQLite dan SharedPreferences.

### Layer Aplikasi

Secara sederhana, aplikasi dibagi menjadi beberapa layer:

1. **Presentation Layer**
   Berisi screen/page dan widget UI.

2. **Data Layer**
   Berisi database helper, model, dan fungsi CRUD SQLite.

3. **Preference Layer**
   Berisi helper untuk menyimpan dan membaca data SharedPreferences.

4. **State Layer Sederhana**
   Menggunakan state bawaan Flutter seperti `setState`, `FutureBuilder`, atau pendekatan sederhana lain tanpa library state management eksternal.

### Alasan Arsitektur Ini Dipilih

Arsitektur ini dipilih karena:

1. Scope Assessment 2 hanya berfokus pada SQLite dan SharedPreferences.
2. Tidak ada kebutuhan integrasi backend.
3. Project dikerjakan oleh tim kecil berisi 3 orang.
4. Aplikasi harus mudah dipahami dan dijelaskan saat presentasi.
5. Struktur tetap cukup rapi tanpa membuat project terlalu kompleks.
6. Aplikasi dapat dikembangkan lagi pada tugas besar jika dibutuhkan.

### Hal yang Tidak Digunakan pada Assessment 2

1. REST API.
2. Backend Laravel.
3. Login/register.
4. Role-based authentication.
5. Payment gateway.
6. State management kompleks seperti Riverpod/Bloc.
7. Clean Architecture berlapis-lapis yang terlalu berat.
8. Repository pattern kompleks.
9. Dependency injection kompleks.

---

## 3. Folder Structure

Struktur folder direkomendasikan tetap sederhana dan mudah dipahami.

```text
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       └── currency_formatter.dart
│
├── data/
│   ├── database/
│   │   └── database_helper.dart
│   ├── preferences/
│   │   └── preference_helper.dart
│   └── seed/
│       └── seed_data.dart
│
├── models/
│   ├── category_model.dart
│   ├── product_model.dart
│   └── cart_item_model.dart
│
├── screens/
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── product_detail_screen.dart
│   ├── manage/
│   │   ├── manage_screen.dart
│   │   ├── manage_product_screen.dart
│   │   ├── product_form_screen.dart
│   │   ├── manage_category_screen.dart
│   │   └── category_form_screen.dart
│   ├── cart/
│   │   └── cart_screen.dart
│   └── settings/
│       └── settings_screen.dart
│
├── widgets/
│   ├── product_card.dart
│   ├── category_chip.dart
│   ├── cart_item_tile.dart
│   ├── empty_state.dart
│   └── primary_button.dart
│
└── navigation/
    └── main_navigation.dart
```

### Penjelasan Folder Utama

#### `core/`

Berisi file pendukung umum seperti constant, theme sederhana, dan utility function.

#### `data/database/`

Berisi file untuk mengatur SQLite, termasuk membuat database, membuat tabel, dan menjalankan operasi CRUD.

#### `data/preferences/`

Berisi helper untuk menyimpan dan membaca SharedPreferences.

#### `data/seed/`

Berisi data awal seperti kategori dan produk default. Seed data bersifat opsional, tetapi disarankan agar aplikasi tidak kosong saat pertama kali dijalankan.

#### `models/`

Berisi model data untuk Category, Product, dan CartItem.

#### `screens/`

Berisi halaman utama aplikasi. Setiap fitur besar ditempatkan di subfolder masing-masing.

#### `widgets/`

Berisi reusable widget sederhana agar UI tidak terlalu berulang.

#### `navigation/`

Berisi navigasi utama aplikasi, misalnya bottom navigation sederhana.

---

## 4. Database Design

Database menggunakan SQLite dan terdiri dari 3 tabel utama:

1. `categories`
2. `products`
3. `cart_items`

---

### 4.1 Table: categories

### Tujuan Tabel

Menyimpan data kategori produk Laviade.

### Kolom Utama

| Kolom      | Tipe Data Umum | Keterangan                  |
| ---------- | -------------- | --------------------------- |
| id         | INTEGER        | Primary key, auto increment |
| name       | TEXT           | Nama kategori               |
| created_at | TEXT           | Waktu data dibuat           |
| updated_at | TEXT           | Waktu data terakhir diubah  |

### Primary Key

* `id`

### Foreign Key

* Tidak ada.

### Relasi

* Satu kategori dapat memiliki banyak produk.

---

### 4.2 Table: products

### Tujuan Tabel

Menyimpan data produk Laviade yang akan ditampilkan pada katalog.

### Kolom Utama

| Kolom       | Tipe Data Umum | Keterangan                         |
| ----------- | -------------- | ---------------------------------- |
| id          | INTEGER        | Primary key, auto increment        |
| category_id | INTEGER        | Foreign key ke tabel categories    |
| name        | TEXT           | Nama produk                        |
| price       | INTEGER        | Harga produk                       |
| stock       | INTEGER        | Jumlah stok produk                 |
| description | TEXT           | Deskripsi produk                   |
| image_name  | TEXT           | Nama asset gambar atau placeholder |
| created_at  | TEXT           | Waktu data dibuat                  |
| updated_at  | TEXT           | Waktu data terakhir diubah         |

### Primary Key

* `id`

### Foreign Key

* `category_id` mengacu ke `categories.id`

### Relasi

* Satu produk hanya memiliki satu kategori.
* Satu produk dapat muncul di banyak item cart.

---

### 4.3 Table: cart_items

### Tujuan Tabel

Menyimpan data produk yang ditambahkan user ke cart.

### Kolom Utama

| Kolom      | Tipe Data Umum | Keterangan                    |
| ---------- | -------------- | ----------------------------- |
| id         | INTEGER        | Primary key, auto increment   |
| product_id | INTEGER        | Foreign key ke tabel products |
| quantity   | INTEGER        | Jumlah produk di cart         |
| created_at | TEXT           | Waktu item ditambahkan        |
| updated_at | TEXT           | Waktu item terakhir diubah    |

### Primary Key

* `id`

### Foreign Key

* `product_id` mengacu ke `products.id`

### Relasi

* Satu cart item berisi satu produk.
* Satu produk dapat muncul sebagai satu cart item aktif.
* Jika produk yang sama ditambahkan lagi, quantity bertambah, bukan membuat row baru.

---

## 5. Relationship Design

### 5.1 Category to Product

Jenis relasi:

**One-to-Many**

Penjelasan:

Satu kategori dapat memiliki banyak produk. Contohnya kategori “T-Shirt” dapat memiliki beberapa produk Laviade. Namun, satu produk hanya memiliki satu kategori.

Relasi:

```text
categories.id → products.category_id
```

Alasan:

Relasi ini sederhana, sesuai kebutuhan katalog, dan memudahkan filter produk berdasarkan kategori.

---

### 5.2 Product to Cart Item

Jenis relasi:

**One-to-Many secara historis, tetapi dibatasi menjadi satu cart item aktif per produk**

Penjelasan:

Satu produk dapat ditambahkan ke cart. Untuk Assessment 2, jika produk yang sama ditambahkan lagi, sistem tidak membuat data cart baru, tetapi menambah quantity pada cart item yang sudah ada.

Relasi:

```text
products.id → cart_items.product_id
```

Alasan:

Relasi ini menjaga cart tetap sederhana dan menghindari data duplikat yang membingungkan saat presentasi.

---

## 6. API / Routes Design

Project ini tidak menggunakan backend API atau web route. Semua proses dilakukan secara lokal di aplikasi Flutter.

Sebagai pengganti API/routes, aplikasi menggunakan screen navigation.

---

### 6.1 App Navigation / Screen Routes

| Route / Screen       | Fungsi                                     | User                | Keterangan                                 |
| -------------------- | ------------------------------------------ | ------------------- | ------------------------------------------ |
| HomeScreen           | Menampilkan katalog produk                 | Customer            | Halaman utama aplikasi                     |
| ProductDetailScreen  | Menampilkan detail produk                  | Customer            | Dibuka dari ProductCard                    |
| CartScreen           | Menampilkan dan mengelola cart             | Customer            | Berisi list item cart dan total harga      |
| ManageScreen         | Menu pengelolaan data demo                 | Pengelola Data Demo | Berisi akses ke produk dan kategori        |
| ManageProductScreen  | Menampilkan daftar produk untuk dikelola   | Pengelola Data Demo | CRUD produk                                |
| ProductFormScreen    | Form tambah/edit produk                    | Pengelola Data Demo | Digunakan untuk create dan update produk   |
| ManageCategoryScreen | Menampilkan daftar kategori untuk dikelola | Pengelola Data Demo | CRUD kategori                              |
| CategoryFormScreen   | Form tambah/edit kategori                  | Pengelola Data Demo | Digunakan untuk create dan update kategori |
| SettingsScreen       | Mengelola preferensi user                  | Customer            | SharedPreferences                          |

---

### 6.2 Local Data Operations

Karena tidak ada API, operasi data dilakukan melalui helper SQLite dan SharedPreferences.

#### Category Operations

| Operation      | Deskripsi                                      |
| -------------- | ---------------------------------------------- |
| insertCategory | Menambah kategori                              |
| getCategories  | Mengambil semua kategori                       |
| updateCategory | Mengubah kategori                              |
| deleteCategory | Menghapus kategori jika belum digunakan produk |

#### Product Operations

| Operation             | Deskripsi                             |
| --------------------- | ------------------------------------- |
| insertProduct         | Menambah produk                       |
| getProducts           | Mengambil semua produk                |
| getProductsByCategory | Mengambil produk berdasarkan kategori |
| getProductById        | Mengambil detail produk               |
| updateProduct         | Mengubah produk                       |
| deleteProduct         | Menghapus produk                      |

#### Cart Operations

| Operation          | Deskripsi                                         |
| ------------------ | ------------------------------------------------- |
| addToCart          | Menambahkan produk ke cart atau menambah quantity |
| getCartItems       | Mengambil isi cart                                |
| updateCartQuantity | Mengubah quantity item                            |
| deleteCartItem     | Menghapus item cart                               |
| getCartTotal       | Menghitung total harga sementara                  |
| clearCart          | Menghapus semua cart jika dibutuhkan              |

#### Preference Operations

| Operation                  | Deskripsi                             |
| -------------------------- | ------------------------------------- |
| saveUserName               | Menyimpan nama user                   |
| getUserName                | Mengambil nama user                   |
| saveDarkMode               | Menyimpan status dark mode            |
| getDarkMode                | Mengambil status dark mode            |
| saveLastSelectedCategoryId | Menyimpan kategori terakhir           |
| getLastSelectedCategoryId  | Mengambil kategori terakhir           |
| saveProductSortType        | Menyimpan jenis sorting               |
| getProductSortType         | Mengambil jenis sorting               |
| savePreferredViewMode      | Menyimpan mode tampilan katalog       |
| getPreferredViewMode       | Mengambil mode tampilan katalog       |
| saveCartLastOpened         | Menyimpan waktu terakhir membuka cart |
| getCartLastOpened          | Mengambil waktu terakhir membuka cart |

---

## 7. Authentication & Authorization

### Authentication

Pada Assessment 2, aplikasi tidak menggunakan login dan register.

Alasan:

1. Fokus utama assessment adalah SQLite dan SharedPreferences.
2. Tidak ada backend.
3. Tidak ada data sensitif.
4. Tidak perlu password atau token.
5. Menghindari over-engineering.

### Authorization

Pada Assessment 2, tidak ada authorization berbasis role.

Role Customer dan Pengelola Data Demo hanya dibedakan berdasarkan menu atau halaman yang digunakan.

Contoh:

* Customer menggunakan Home, Product Detail, Cart, dan Settings.
* Pengelola Data Demo menggunakan Manage Product dan Manage Category.

### Halaman yang Butuh Proteksi

Tidak ada halaman yang membutuhkan proteksi login pada Assessment 2.

### Catatan Teknis

Jangan membuat:

1. Login screen.
2. Register screen.
3. User table.
4. Password hashing.
5. Session token.
6. Middleware.
7. Role-based routing.

---

## 8. State Management

### Pendekatan State Management

Untuk Assessment 2, gunakan state management sederhana bawaan Flutter.

Pendekatan yang diperbolehkan:

1. `setState`
2. `FutureBuilder`
3. Passing data antar screen menggunakan constructor
4. Refresh data setelah operasi CRUD

Tidak perlu menggunakan Provider, Riverpod, Bloc, atau state management kompleks pada Assessment 2.

### State yang Perlu Dikelola

#### 1. Product State

Data yang dikelola:

* daftar produk
* produk berdasarkan kategori
* detail produk
* status loading sederhana
* empty state

Sumber data:

* SQLite

#### 2. Category State

Data yang dikelola:

* daftar kategori
* kategori terpilih

Sumber data:

* SQLite dan SharedPreferences untuk kategori terakhir.

#### 3. Cart State

Data yang dikelola:

* daftar item cart
* quantity cart
* total harga sementara

Sumber data:

* SQLite

#### 4. Preference State

Data yang dikelola:

* user name
* dark mode
* kategori terakhir
* jenis sorting produk
* mode tampilan katalog
* waktu terakhir membuka cart

Sumber data:

* SharedPreferences

### Refresh Strategy

1. Setelah tambah, edit, atau hapus produk, reload data produk dari SQLite.
2. Setelah tambah, edit, atau hapus kategori, reload data kategori dari SQLite.
3. Setelah add to cart atau update quantity, reload data cart dari SQLite.
4. Setelah preferensi diubah, simpan ke SharedPreferences lalu update UI jika diperlukan.

---

## 9. Validation Rules

### 9.1 Category Validation

#### Input

* name

#### Positive Case

1. Nama kategori tidak kosong.
2. Nama kategori memiliki panjang wajar.
3. Nama kategori tidak hanya berisi spasi.

#### Negative Case

1. Nama kategori kosong.
2. Nama kategori hanya berisi spasi.
3. Nama kategori terlalu panjang.
4. Kategori yang masih digunakan produk ingin dihapus.

#### Rule

1. Sistem harus menolak nama kategori kosong.
2. Sistem harus melakukan trim pada input nama kategori.
3. Sistem harus menolak penghapusan kategori jika masih digunakan produk.

---

### 9.2 Product Validation

#### Input

* category_id
* name
* price
* stock
* description
* image_name

#### Positive Case

1. Nama produk tidak kosong.
2. Produk memiliki kategori.
3. Harga berupa angka dan lebih dari 0.
4. Stok berupa angka dan tidak negatif.
5. Deskripsi boleh kosong atau singkat.
6. Image dapat menggunakan placeholder jika tidak diisi.

#### Negative Case

1. Nama produk kosong.
2. Kategori belum dipilih.
3. Harga kosong.
4. Harga bernilai 0 atau negatif.
5. Stok kosong.
6. Stok bernilai negatif.
7. Input harga atau stok bukan angka.

#### Rule

1. Sistem harus menolak nama produk kosong.
2. Sistem harus menolak produk tanpa kategori.
3. Sistem harus menolak harga kurang dari atau sama dengan 0.
4. Sistem harus menolak stok negatif.
5. Sistem harus menggunakan image default jika image tidak tersedia.

---

### 9.3 Cart Validation

#### Input

* product_id
* quantity

#### Positive Case

1. Produk tersedia di SQLite.
2. Quantity minimal 1.
3. Produk belum ada di cart, lalu ditambahkan sebagai item baru.
4. Produk sudah ada di cart, lalu quantity bertambah.

#### Negative Case

1. Produk tidak ditemukan.
2. Quantity kurang dari 1.
3. Quantity melebihi stok produk.
4. User mencoba menurunkan quantity sampai 0 tanpa menghapus item.

#### Rule

1. Sistem harus menolak quantity kurang dari 1.
2. Sistem harus mencegah quantity melebihi stok.
3. Sistem harus menambah quantity jika produk yang sama sudah ada di cart.
4. Sistem harus menghapus item jika user memilih tombol delete, bukan melalui quantity negatif.

---

### 9.4 SharedPreferences Validation

#### Input

* user_name
* is_dark_mode
* last_selected_category_id
* product_sort_type
* preferred_view_mode
* cart_last_opened

#### Positive Case

1. Nama user boleh kosong atau diisi.
2. Dark mode bernilai true atau false.
3. Last selected category mengarah ke kategori yang tersedia.
4. Product sort type menggunakan value yang sudah ditentukan.
5. Preferred view mode menggunakan value `list` atau `grid`.
6. Cart last opened disimpan sebagai string waktu.

#### Negative Case

1. Product sort type memiliki value tidak dikenal.
2. Preferred view mode bukan `list` atau `grid`.
3. Last selected category mengarah ke kategori yang sudah tidak ada.

#### Rule

1. Sistem harus memberikan default value jika key belum pernah disimpan.
2. Sistem harus menggunakan fallback jika kategori terakhir sudah tidak tersedia.
3. Sistem harus membatasi value sorting dan view mode pada pilihan yang telah ditentukan.

---

## 10. Error Handling

### 10.1 Error SQLite

Kemungkinan error:

1. Database gagal dibuat.
2. Tabel belum tersedia.
3. Insert data gagal.
4. Update data gagal.
5. Delete data gagal.
6. Data yang dicari tidak ditemukan.

Respons sistem:

1. Tampilkan pesan error sederhana.
2. Jangan membuat aplikasi crash.
3. Tetap tampilkan halaman dengan empty state jika data tidak tersedia.
4. Log error untuk debugging selama development.

Contoh pesan:

* “Data gagal disimpan.”
* “Data gagal diperbarui.”
* “Data gagal dihapus.”
* “Produk tidak ditemukan.”
* “Kategori tidak dapat dihapus karena masih digunakan.”

---

### 10.2 Error Input Form

Kemungkinan error:

1. Field wajib kosong.
2. Harga bukan angka.
3. Harga kurang dari atau sama dengan 0.
4. Stok negatif.
5. Quantity tidak valid.

Respons sistem:

1. Tampilkan pesan validasi dekat field atau melalui snackbar.
2. Jangan menyimpan data jika validasi gagal.
3. Arahkan user untuk memperbaiki input.

Contoh pesan:

* “Nama produk wajib diisi.”
* “Kategori wajib dipilih.”
* “Harga harus lebih dari 0.”
* “Stok tidak boleh negatif.”
* “Quantity tidak valid.”

---

### 10.3 Error Cart

Kemungkinan error:

1. Produk sudah tidak tersedia.
2. Quantity melebihi stok.
3. Cart kosong.
4. Produk gagal ditambahkan ke cart.

Respons sistem:

1. Tampilkan empty state jika cart kosong.
2. Tampilkan pesan jika quantity melebihi stok.
3. Jangan menambahkan item cart jika produk tidak ditemukan.

Contoh pesan:

* “Cart masih kosong.”
* “Stok produk tidak mencukupi.”
* “Produk gagal ditambahkan ke cart.”

---

### 10.4 Error SharedPreferences

Kemungkinan error:

1. Key belum pernah disimpan.
2. Value tidak sesuai format.
3. Preferensi tidak berhasil dibaca.

Respons sistem:

1. Gunakan default value.
2. Jangan membuat aplikasi crash.
3. Update UI dengan fallback value.

Contoh default value:

| Key                       | Default             |
| ------------------------- | ------------------- |
| user_name                 | Guest               |
| is_dark_mode              | false               |
| last_selected_category_id | null / all category |
| product_sort_type         | default             |
| preferred_view_mode       | grid                |
| cart_last_opened          | empty string        |

---

## 11. Security Basic

Karena aplikasi tidak menggunakan backend, login, payment, atau data sensitif, security dibuat sederhana dan realistis.

### 11.1 Validasi Input

Sistem harus melakukan validasi pada:

1. Nama kategori.
2. Nama produk.
3. Harga produk.
4. Stok produk.
5. Quantity cart.
6. Value SharedPreferences tertentu seperti sort type dan view mode.

### 11.2 Authorization

Tidak ada authorization berbasis role pada Assessment 2.

Halaman Manage dapat diakses tanpa login karena hanya digunakan untuk demo CRUD lokal.

### 11.3 Password Hashing

Tidak digunakan karena aplikasi tidak memiliki login/register.

### 11.4 CSRF

Tidak digunakan karena project bukan web app dan tidak menggunakan form request ke server.

### 11.5 File Upload Validation

Tidak digunakan karena Assessment 2 tidak memiliki fitur upload gambar.

Gambar produk menggunakan asset lokal atau placeholder.

### 11.6 Secret / API Key

Aplikasi tidak boleh menyimpan secret, token, API key, password, atau credential lain di source code.

### 11.7 Data Sensitif

SharedPreferences tidak boleh digunakan untuk menyimpan:

1. Password.
2. Token.
3. Data pembayaran.
4. Informasi pribadi sensitif.

SharedPreferences hanya digunakan untuk preferensi sederhana.

---

## 12. UI/UX Technical Notes

### 12.1 Layout Utama

Aplikasi menggunakan layout mobile sederhana dengan navigasi utama.

Rekomendasi navigasi:

```text
Home | Cart | Manage | Settings
```

Halaman utama:

1. Home / Product Catalog.
2. Product Detail.
3. Cart.
4. Manage Product.
5. Manage Category.
6. Settings.

### 12.2 Design Direction

UI menggunakan pendekatan sederhana sesuai brand Laviade.

Arah visual:

1. Minimal.
2. Streetwear-inspired.
3. Warna netral seperti hitam, putih, abu-abu.
4. Tidak menggunakan gradient berlebihan.
5. Tidak menggunakan animasi kompleks.
6. Tidak menggunakan tampilan yang terlalu mirip template AI.

### 12.3 Product Catalog UI

Komponen utama:

1. Header sederhana.
2. Category filter.
3. Product card.
4. List/grid view.
5. Empty state.

Product card menampilkan:

1. Nama produk.
2. Harga produk.
3. Kategori.
4. Stok.
5. Gambar placeholder atau asset lokal.

### 12.4 Cart UI

Komponen utama:

1. List cart item.
2. Quantity control sederhana.
3. Tombol delete item.
4. Total harga sementara.
5. Empty state jika cart kosong.

### 12.5 Manage UI

Komponen utama:

1. List data produk/kategori.
2. Tombol tambah.
3. Tombol edit.
4. Tombol delete.
5. Form input sederhana.

### 12.6 Settings UI

Komponen utama:

1. Input nama user.
2. Toggle dark mode.
3. Pilihan sorting produk.
4. Pilihan mode tampilan katalog.
5. Informasi waktu terakhir membuka cart jika ingin ditampilkan.

### 12.7 Responsive Behavior

1. Layout harus nyaman pada layar Android umum.
2. Button harus cukup besar untuk ditekan.
3. Card tidak boleh overflow.
4. Form harus dapat discroll jika layar kecil.
5. Text panjang seperti deskripsi produk harus dibatasi atau dibuat wrap.

### 12.8 Empty State

Empty state wajib tersedia untuk:

1. Produk kosong.
2. Kategori kosong.
3. Cart kosong.

Contoh empty state:

* “Belum ada produk.”
* “Belum ada kategori.”
* “Cart masih kosong.”

### 12.9 Loading State

Karena data lokal biasanya cepat, loading state cukup sederhana.

Contoh:

1. Circular progress kecil saat mengambil data.
2. Skeleton tidak wajib.
3. Jangan membuat loading UI kompleks.

### 12.10 Error State

Error state dapat menggunakan:

1. Text sederhana.
2. Snackbar.
3. Dialog konfirmasi untuk delete.

Contoh:

* “Data gagal dimuat.”
* “Data gagal disimpan.”
* “Kategori masih digunakan produk.”

---

## 13. Testing Strategy

Testing difokuskan pada manual test karena Assessment 2 lebih menekankan penerapan fitur dan kemampuan menjelaskan saat presentasi.

### 13.1 Manual Testing

Manual test wajib dilakukan untuk:

1. Product CRUD.
2. Category CRUD.
3. Cart Management.
4. SharedPreferences.
5. Persistence SQLite.
6. Persistence SharedPreferences.
7. Empty state.
8. Validasi input.

---

### 13.2 Product CRUD Test Case

#### Positive Test Case

1. Tambah produk dengan data valid.
2. Produk muncul di daftar produk.
3. Edit nama produk.
4. Produk tampil dengan data terbaru.
5. Hapus produk.
6. Produk tidak muncul lagi.

#### Negative Test Case

1. Tambah produk dengan nama kosong.
2. Tambah produk tanpa kategori.
3. Tambah produk dengan harga 0.
4. Tambah produk dengan harga negatif.
5. Tambah produk dengan stok negatif.
6. Hapus produk yang ada di cart.

---

### 13.3 Category CRUD Test Case

#### Positive Test Case

1. Tambah kategori dengan nama valid.
2. Kategori muncul di daftar kategori.
3. Edit nama kategori.
4. Kategori tampil dengan nama terbaru.
5. Hapus kategori yang belum digunakan produk.

#### Negative Test Case

1. Tambah kategori dengan nama kosong.
2. Tambah kategori hanya berisi spasi.
3. Hapus kategori yang masih digunakan oleh produk.

---

### 13.4 Cart Test Case

#### Positive Test Case

1. Tambahkan produk ke cart.
2. Produk muncul di halaman cart.
3. Tambahkan produk yang sama lagi.
4. Quantity produk bertambah.
5. Ubah quantity produk.
6. Total harga berubah sesuai quantity.
7. Hapus item dari cart.
8. Cart menampilkan empty state jika kosong.

#### Negative Test Case

1. Ubah quantity menjadi 0.
2. Ubah quantity menjadi negatif.
3. Tambahkan produk dengan stok 0.
4. Tambahkan quantity melebihi stok produk.

---

### 13.5 SharedPreferences Test Case

#### Positive Test Case

1. Simpan nama user.
2. Ubah dark mode.
3. Pilih kategori terakhir.
4. Ubah sorting produk.
5. Ubah view mode katalog.
6. Buka halaman cart untuk menyimpan waktu terakhir.
7. Tutup aplikasi.
8. Buka aplikasi kembali.
9. Semua preferensi masih tersimpan.

#### Negative Test Case

1. Key belum pernah disimpan.
2. Last selected category mengarah ke kategori yang sudah dihapus.
3. Preferred view mode memiliki value tidak dikenal.
4. Product sort type memiliki value tidak dikenal.

---

### 13.6 Unit Test

Unit test tidak wajib untuk Assessment 2, tetapi dapat dibuat jika waktu memungkinkan.

Prioritas unit test:

1. Validasi input produk.
2. Validasi input kategori.
3. Perhitungan total cart.
4. Mapping model dari Map SQLite ke object.

### 13.7 Integration Test

Integration test tidak wajib untuk Assessment 2.

Jika ingin dilakukan secara sederhana, cukup lakukan manual integration test:

1. Tambah kategori.
2. Tambah produk dengan kategori tersebut.
3. Produk muncul di katalog.
4. Produk ditambahkan ke cart.
5. Cart menghitung total.
6. Preferences tetap tersimpan setelah aplikasi dibuka ulang.

---

## 14. Deployment Notes

Project ini tidak menggunakan deployment backend. Output utama adalah aplikasi Flutter yang dapat dijalankan di emulator atau perangkat Android.

### 14.1 Environment Variable

Tidak diperlukan environment variable karena:

1. Tidak ada backend.
2. Tidak ada API key.
3. Tidak ada payment.
4. Tidak ada service eksternal.

### 14.2 Build Command

Build Android dapat dilakukan menggunakan command Flutter standar.

Contoh kebutuhan umum:

```text
flutter pub get
flutter run
flutter build apk
```

Catatan: command di atas digunakan saat implementasi, bukan bagian dari kode aplikasi.

### 14.3 Migration / Database Versioning

SQLite harus memiliki database version.

Untuk Assessment 2:

1. Gunakan versi awal database, misalnya version 1.
2. Buat tabel saat database pertama kali dibuat.
3. Jika schema berubah, pertimbangkan menaikkan versi database atau melakukan reset database saat development.

### 14.4 Seeding Data

Seed data disarankan agar aplikasi tidak kosong saat pertama kali dibuka.

Contoh data awal:

Kategori:

1. T-Shirt.
2. Hoodie.
3. Pants.
4. Accessories.

Produk:

1. Laviade Boxy Shirt.
2. Laviade Graphic Tee.
3. Laviade Basic Hoodie.

Seed data tidak boleh terlalu banyak agar aplikasi tetap sederhana.

### 14.5 Checklist Sebelum Presentasi

1. Aplikasi bisa dijalankan di emulator atau device.
2. Product CRUD berjalan.
3. Category CRUD berjalan.
4. Cart berjalan.
5. SharedPreferences berjalan.
6. Data tetap tersimpan setelah aplikasi ditutup dan dibuka ulang.
7. Empty state muncul jika data kosong.
8. Tidak ada crash pada flow utama.
9. Setiap anggota paham fitur dan 2 key SharedPreferences masing-masing.
10. UI tidak overflow pada layar device yang digunakan.

---

## 15. Technical Risks

### 15.1 Risiko: Struktur SQLite Tidak Rapi

#### Dampak

Fitur CRUD dan cart dapat menjadi sulit dikembangkan atau sulit dijelaskan.

#### Mitigasi

1. Lock schema database sejak awal.
2. Gunakan 3 tabel utama saja untuk Assessment 2.
3. Jangan menambahkan tabel baru tanpa alasan kuat.
4. Pisahkan logic database di `database_helper.dart`.

---

### 15.2 Risiko: SharedPreferences Disalahgunakan

#### Dampak

Data utama seperti produk atau cart bisa salah disimpan di SharedPreferences.

#### Mitigasi

1. Data utama wajib disimpan di SQLite.
2. SharedPreferences hanya digunakan untuk data kecil berbasis preferensi.
3. Gunakan daftar key yang sudah disepakati.

---

### 15.3 Risiko: Scope Melebar ke Full E-Commerce

#### Dampak

Project menjadi terlalu besar dan tidak selesai tepat waktu.

#### Mitigasi

1. Jangan membuat backend.
2. Jangan membuat login/register.
3. Jangan membuat payment.
4. Jangan membuat checkout real.
5. Fokus pada catalog, CRUD, cart, dan preferences.

---

### 15.4 Risiko: UI Terlalu Kompleks

#### Dampak

Waktu habis untuk tampilan, sementara SQLite dan SharedPreferences belum matang.

#### Mitigasi

1. Gunakan UI sederhana.
2. Pakai komponen Flutter standar.
3. Hindari animasi kompleks.
4. Fokus pada flow yang jelas dan bisa didemokan.

---

### 15.5 Risiko: Pembagian Kerja Tidak Sinkron

#### Dampak

Fitur antar anggota tidak menyatu dengan baik.

#### Mitigasi

1. Tentukan schema database bersama.
2. Tentukan nama model dan helper sejak awal.
3. Setiap anggota bertanggung jawab pada fitur dan key SharedPreferences tertentu.
4. Lakukan integrasi bertahap, bukan di akhir.

---

### 15.6 Risiko: Data Tidak Persist Setelah App Ditutup

#### Dampak

Requirement utama SQLite dan SharedPreferences tidak terbukti.

#### Mitigasi

1. Test aplikasi setelah restart.
2. Pastikan data benar-benar disimpan ke SQLite.
3. Pastikan SharedPreferences di-load ulang saat aplikasi dibuka.
4. Jangan hanya menyimpan data di variable runtime.

---

### 15.7 Risiko: Kategori Dihapus Saat Masih Digunakan Produk

#### Dampak

Produk bisa kehilangan kategori dan data menjadi tidak konsisten.

#### Mitigasi

1. Sebelum delete kategori, cek apakah masih ada produk dengan `category_id` tersebut.
2. Jika masih ada, tampilkan pesan error.
3. Jangan hapus kategori yang masih digunakan.

---

### 15.8 Risiko: Cart Membuat Data Duplikat

#### Dampak

Produk yang sama bisa muncul berkali-kali dan total harga membingungkan.

#### Mitigasi

1. Saat add to cart, cek apakah product_id sudah ada di cart.
2. Jika sudah ada, update quantity.
3. Jika belum ada, insert item baru.

---

## 16. Implementation Guardrails for AI Agent

Bagian ini wajib diperhatikan jika project dikerjakan menggunakan AI Agent di IDE.

### 16.1 General Rules

1. Jangan membuat backend.
2. Jangan membuat login/register.
3. Jangan membuat payment gateway.
4. Jangan membuat fitur di luar PRD dan TDD.
5. Jangan menambahkan library baru selain SQLite dan SharedPreferences untuk Assessment 2.
6. Jangan membuat arsitektur terlalu kompleks.
7. Jangan rewrite seluruh project tanpa alasan.
8. Jangan menghapus file existing tanpa penjelasan.

### 16.2 Coding Rules

1. Buat implementasi secara bertahap.
2. Satu task fokus pada satu fitur.
3. Pisahkan model, screen, widget, database helper, dan preference helper.
4. Gunakan nama file dan class yang jelas.
5. Tambahkan validasi input sederhana.
6. Tambahkan empty state untuk data kosong.
7. Pastikan setiap operasi SQLite dapat diuji.
8. Pastikan setiap key SharedPreferences dapat didemokan.

### 16.3 UI Rules

1. UI harus sederhana dan clean.
2. Gunakan warna netral sesuai Laviade.
3. Hindari tampilan template AI yang terlalu heboh.
4. Hindari gradient berlebihan.
5. Hindari animasi kompleks.
6. Pastikan layout tidak overflow.

### 16.4 Testing Rules

Setelah implementasi fitur, AI Agent harus menjelaskan:

1. File apa saja yang dibuat atau diubah.
2. Fungsi utama dari perubahan tersebut.
3. Cara melakukan manual test.
4. Risiko yang masih mungkin terjadi.
5. Apakah fitur sesuai dengan PRD dan TDD.

---

## 17. Final Technical Scope

Technical scope Assessment 2 adalah:

1. Flutter mobile app.
2. Local SQLite database.
3. SharedPreferences.
4. 3 tabel SQLite:

   * categories
   * products
   * cart_items
5. 6 key SharedPreferences:

   * user_name
   * is_dark_mode
   * last_selected_category_id
   * product_sort_type
   * preferred_view_mode
   * cart_last_opened
6. Screen utama:

   * HomeScreen
   * ProductDetailScreen
   * CartScreen
   * ManageScreen
   * ManageProductScreen
   * ProductFormScreen
   * ManageCategoryScreen
   * CategoryFormScreen
   * SettingsScreen
7. Tidak ada backend.
8. Tidak ada login/register.
9. Tidak ada payment.
10. Tidak ada checkout real.
11. Tidak ada fitur yang berpotensi over-engineering untuk Assessment 2.

---

## 18. Closing Notes

Technical Design Document ini menjadi acuan utama implementasi Assessment 2. Semua fitur yang dibuat harus mengacu pada scope final, yaitu local catalog, product/category CRUD, cart management, dan SharedPreferences settings.

Project harus tetap sederhana, dapat diuji, dan mudah dijelaskan oleh setiap anggota kelompok. Prioritas utama bukan membuat aplikasi e-commerce yang lengkap, tetapi membuktikan implementasi SQLite dan SharedPreferences dengan flow aplikasi yang jelas dan relevan dengan konsep Laviade Studio.

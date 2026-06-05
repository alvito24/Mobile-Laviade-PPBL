# DESIGN_HANDOFF.md

# Design Handoff Specification

## Laviade Studio Mobile — Local Catalog & Cart

---

## 1. Design Overview

### Project

**Laviade Studio Mobile — Local Catalog & Cart**

### Platform

Flutter Mobile App, fokus Android.

### Frontend Tech Stack

* Flutter
* Dart
* State sederhana: `setState`, `FutureBuilder`, refresh manual setelah CRUD
* Local database: SQLite
* Local preferences: SharedPreferences

### Styling

* Flutter Theme
* Material Components
* Custom reusable widgets
* Monochrome visual style

---

### Konsep Desain Utama

Desain aplikasi menggunakan pendekatan **local catalog mobile app** dengan karakter visual streetwear yang clean, bold, dan minimal. Aplikasi tidak dibuat seperti marketplace penuh, melainkan sebagai katalog lokal dan simulasi cart yang ringan untuk Assessment 2.

Fokus desain adalah membuat alur penggunaan yang jelas untuk:

1. Melihat katalog produk.
2. Melihat detail produk.
3. Mengelola produk dan kategori lokal.
4. Mengelola cart lokal.
5. Mengatur preferensi user menggunakan SharedPreferences.

Desain tidak boleh mengarah ke full e-commerce online seperti checkout, payment, shipping, order history, address, wishlist, atau backend integration.

---

### Target User

1. **Customer**
   User yang melihat katalog, membuka detail produk, menambahkan produk ke cart, mengatur quantity, dan menyimpan preferensi sederhana.

2. **Pengelola Data Demo**
   User yang mengelola data produk dan kategori untuk kebutuhan demo CRUD SQLite.

Catatan: tidak ada login/register dan tidak ada role-based authentication. Pemisahan role hanya berdasarkan fungsi/menu.

---

### Tujuan UX Utama

1. User cepat memahami fungsi aplikasi.
2. User bisa melihat produk dengan jelas.
3. User bisa melakukan simulasi cart tanpa kebingungan dengan checkout real.
4. Pengelola data bisa memahami flow CRUD produk dan kategori.
5. Setiap data lokal yang ditampilkan mudah dipetakan ke SQLite atau SharedPreferences.
6. UI cukup sederhana untuk diimplementasikan oleh developer Flutter.

---

### Karakter Visual

* Monochrome
* Clean
* Bold
* Minimal
* Streetwear-inspired
* Editorial catalog feel
* Tidak terlalu dekoratif
* Tidak generic template
* Tidak terlalu ramai

---

### Prinsip Desain yang Harus Dipertahankan

1. Gunakan visual high-contrast antara teks hitam dan background off-white.
2. Fokus pada informasi produk: nama, kategori, harga, stok.
3. Gunakan CTA yang jelas dan tidak ambigu.
4. Jangan menambahkan fitur visual yang memicu scope baru.
5. Semua screen harus mobile-first.
6. Komponen harus mudah dipecah menjadi Flutter widget.
7. Setiap screen harus punya state default, loading, empty, error, dan success jika relevan.
8. Hindari gradient, shadow berlebihan, animasi kompleks, dan layout sulit.

---

## 2. Screen List

---

## 2.1 Splash Screen

### User Role

Customer dan Pengelola Data Demo.

### Tujuan Screen

Menampilkan identitas aplikasi sebelum masuk ke Home.

### Komponen Utama

1. Brand title: **Laviade Studio**
2. Subtitle: **Local Catalog & Cart**
3. Minimal monochrome visual
4. Background off-white atau black

### Data yang Ditampilkan

Tidak ada data dinamis.

### Primary Action

Tidak ada action manual. Setelah durasi singkat, aplikasi masuk ke Home.

### Secondary Action

Tidak ada.

### Navigasi

Splash → Home / Product Catalog.

### State

* Default: brand name dan subtitle.
* Loading: optional, tidak wajib.
* Empty: tidak relevan.
* Error: tidak relevan.
* Success: masuk ke Home.

---

## 2.2 Home / Product Catalog Screen

### User Role

Customer.

### Tujuan Screen

Menampilkan katalog produk dari SQLite dan menjadi halaman utama aplikasi.

### Komponen Utama

1. App top area/title
2. Greeting menggunakan `user_name`
3. Category chips/filter
4. Product sort control
5. View mode toggle: Grid/List
6. Product card
7. Bottom navigation

### Data yang Ditampilkan

Dari SQLite:

* `products.id`
* `products.name`
* `products.price`
* `products.stock`
* `products.image_name`
* `categories.name`

Dari SharedPreferences:

* `user_name`
* `last_selected_category_id`
* `product_sort_type`
* `preferred_view_mode`

### Primary Action

Tap ProductCard → Product Detail.

### Secondary Action

1. Pilih kategori.
2. Ubah sorting.
3. Ubah view mode Grid/List.
4. Navigasi ke Cart, Manage, Settings melalui bottom navigation.

### Navigasi

* Home → Product Detail
* Home → Cart
* Home → Manage
* Home → Settings

### State

#### Default

Menampilkan daftar produk.

#### Loading

Tampilkan loading sederhana dengan copy:

> Memuat produk...

#### Empty

Title:

> Belum ada produk

Description:

> Tambahkan produk lewat menu Manage untuk mulai katalog lokal.

CTA:

> Tambah Produk

Navigasi CTA:

Home Empty → Manage Product / Product Form.

#### Error

Title:

> Data produk gagal dimuat

CTA:

> Coba Lagi

#### Success

Snackbar setelah add to cart dari product detail:

> Produk berhasil ditambahkan ke cart.

---

## 2.3 Product Detail Screen

### User Role

Customer.

### Tujuan Screen

Menampilkan detail produk sederhana dan memberi aksi Add to Cart.

### Komponen Utama

1. App bar dengan back button
2. Product image placeholder/local asset
3. Product name
4. Category chip
5. Stock badge
6. Price
7. Description
8. Add to Cart button

### Data yang Ditampilkan

Dari SQLite:

* `products.id`
* `products.name`
* `products.price`
* `products.stock`
* `products.description`
* `products.image_name`
* `categories.name`

### Primary Action

Add to Cart.

### Secondary Action

Back to Home.

### Navigasi

* Product Detail → Home
* Product Detail → Cart, melalui snackbar action optional atau bottom navigation jika tersedia

### State

#### Default

Menampilkan detail produk.

#### Loading

> Memuat detail produk...

#### Empty / Not Found

Title:

> Produk tidak ditemukan

Description:

> Data produk mungkin sudah dihapus dari database lokal.

CTA:

> Kembali ke Katalog

#### Error

> Detail produk gagal dimuat.

#### Success

Snackbar:

> Produk berhasil ditambahkan ke cart.

### Handoff Note

Jangan tampilkan data yang tidak ada di database seperti:

* material
* fit
* care
* size
* review
* rating

Semua detail tambahan harus masuk ke `description`, bukan field baru.

---

## 2.4 Cart Screen

### User Role

Customer.

### Tujuan Screen

Menampilkan item cart lokal dan memberi user kontrol untuk mengubah quantity atau menghapus item.

### Komponen Utama

1. Screen title: Cart
2. Cart item list
3. Quantity control
4. Delete item button
5. Subtotal per item
6. Total price
7. Local simulation note
8. Continue Browsing CTA
9. Bottom navigation

### Data yang Ditampilkan

Dari SQLite:

* `cart_items.id`
* `cart_items.product_id`
* `cart_items.quantity`
* `products.name`
* `products.price`
* `products.image_name`
* calculated `subtotal`
* calculated `total`

Dari SharedPreferences:

* `cart_last_opened`

### Primary Action

Update quantity.

### Secondary Action

1. Delete item.
2. Continue Browsing.
3. Navigate via bottom navigation.

### Navigasi

* Cart → Home melalui Continue Browsing
* Cart → Home / Manage / Settings via bottom nav

### State

#### Default

Menampilkan cart item dan total harga.

#### Loading

> Memuat cart...

#### Empty

Title:

> Cart masih kosong

Description:

> Tambahkan produk dari katalog untuk melihat simulasi cart lokal.

CTA:

> Lihat Produk

#### Error

Title:

> Cart gagal dimuat

CTA:

> Coba Lagi

#### Success

Snackbar:

> Cart berhasil diperbarui.

#### Delete Confirmation

Title:

> Hapus item?

Description:

> Produk ini akan dihapus dari cart lokal.

Actions:

* Batal
* Hapus

### Handoff Note

Jangan tampilkan:

* checkout
* payment
* shipping
* order
* address
* size
* recently viewed

Cart hanya simulasi lokal, bukan transaksi real.

---

## 2.5 Manage Screen

### User Role

Pengelola Data Demo.

### Tujuan Screen

Menjadi pintu masuk ke fitur pengelolaan data lokal.

### Komponen Utama

1. Screen title: Manage Data
2. Description: “Kelola data lokal untuk demo SQLite.”
3. Manage Product card
4. Manage Category card
5. Bottom navigation

### Data yang Ditampilkan

Tidak wajib data dinamis. Optional:

* jumlah produk
* jumlah kategori

Jika product/category count membuat development lebih berat, boleh dihilangkan.

### Primary Action

Tap Manage Product.

### Secondary Action

Tap Manage Category.

### Navigasi

* Manage → Manage Product
* Manage → Manage Category
* Manage → Home / Cart / Settings via bottom nav

### State

#### Default

Menampilkan dua menu card.

#### Loading

Tidak wajib.

#### Empty

Tidak relevan.

#### Error

Tidak wajib.

#### Success

Tidak relevan.

### Handoff Note

Jangan membuat admin dashboard kompleks, chart, report, analytics, atau login admin.

---

## 2.6 Manage Product Screen

### User Role

Pengelola Data Demo.

### Tujuan Screen

Menampilkan daftar produk dan memberi akses ke CRUD produk.

### Komponen Utama

1. App bar dengan back button
2. Title: Manage Product
3. Product manage list
4. Add Product button/FAB
5. Edit action
6. Delete action

### Data yang Ditampilkan

Dari SQLite:

* `products.id`
* `products.name`
* `products.price`
* `products.stock`
* `products.image_name`
* `categories.name`

### Primary Action

Add Product.

### Secondary Action

1. Edit product.
2. Delete product.
3. Back to Manage.

### Navigasi

* Manage Product → Product Form Add
* Manage Product → Product Form Edit
* Manage Product → Delete Confirmation
* Manage Product → Manage

### State

#### Default

Menampilkan list produk.

#### Loading

> Memuat produk...

#### Empty

Title:

> Belum ada produk

Description:

> Tambahkan produk pertama untuk mengisi katalog lokal.

CTA:

> Tambah Produk

#### Error

Title:

> Data produk gagal dimuat

CTA:

> Coba Lagi

#### Success

Snackbar:

> Produk berhasil disimpan.

atau:

> Produk berhasil dihapus.

#### Delete Confirmation

Title:

> Hapus produk?

Description:

> Produk ini akan dihapus dari database lokal.

Actions:

* Batal
* Hapus

### Handoff Note

Search/filter icon boleh dianggap optional. Jangan jadikan requirement utama jika waktu development terbatas.

---

## 2.7 Product Form Screen

### User Role

Pengelola Data Demo.

### Tujuan Screen

Menambah atau mengedit produk lokal.

### Mode

1. Add Product
2. Edit Product

### Komponen Utama

1. App bar dengan back button
2. Product Name field
3. Category dropdown
4. Price field
5. Stock field
6. Description field
7. Image Asset Name field
8. Save Product button
9. Cancel button

### Data yang Ditampilkan

Untuk Add:

* category list dari SQLite

Untuk Edit:

* `products.name`
* `products.category_id`
* `products.price`
* `products.stock`
* `products.description`
* `products.image_name`

### Primary Action

Save Product.

### Secondary Action

Cancel / Back.

### Navigasi

* Product Form → Manage Product after save
* Product Form → Manage Product after cancel/back

### State

#### Default

Form kosong untuk Add Product atau form berisi data untuk Edit Product.

#### Loading

> Menyimpan produk...

#### Empty

Tidak relevan.

#### Validation Error

* Nama produk wajib diisi.
* Kategori wajib dipilih.
* Harga harus lebih dari 0.
* Stok tidak boleh negatif.

#### Error

Snackbar:

> Produk gagal disimpan.

#### Success

Snackbar:

> Produk berhasil disimpan.

### Handoff Note

Image field hanya untuk nama asset lokal, bukan upload.

Gunakan copy:

> Gunakan nama asset lokal, contoh: hoodie_black.png

Jangan gunakan copy:

> cloud bucket

Jangan tambahkan field:

* material
* fit
* care
* size
* color
* upload image

---

## 2.8 Manage Category Screen

### User Role

Pengelola Data Demo.

### Tujuan Screen

Menampilkan daftar kategori dan memberi akses ke CRUD kategori.

### Komponen Utama

1. App bar dengan back button
2. Title: Manage Category
3. Category list
4. Add Category button/FAB
5. Edit action
6. Delete action

### Data yang Ditampilkan

Dari SQLite:

* `categories.id`
* `categories.name`

Optional:

* product count per category

### Primary Action

Add Category.

### Secondary Action

1. Edit category.
2. Delete category.
3. Back to Manage.

### Navigasi

* Manage Category → Category Form Add
* Manage Category → Category Form Edit
* Manage Category → Delete Confirmation
* Manage Category → Category Deletion Error
* Manage Category → Manage

### State

#### Default

Menampilkan daftar kategori.

#### Loading

> Memuat kategori...

#### Empty

Title:

> Belum ada kategori

Description:

> Tambahkan kategori agar produk bisa dikelompokkan.

CTA:

> Tambah Kategori

#### Error

Title:

> Data kategori gagal dimuat

CTA:

> Coba Lagi

#### Success

Snackbar:

> Kategori berhasil disimpan.

atau:

> Kategori berhasil dihapus.

#### Delete Confirmation

Title:

> Hapus kategori?

Description:

> Kategori akan dihapus jika belum digunakan oleh produk.

Actions:

* Batal
* Hapus

#### Delete Conflict Error

Title:

> Kategori tidak bisa dihapus

Description:

> Kategori ini masih digunakan oleh produk.

CTA:

> Mengerti

---

## 2.9 Category Form Screen

### User Role

Pengelola Data Demo.

### Tujuan Screen

Menambah atau mengedit kategori.

### Mode

1. Add Category
2. Edit Category

### Komponen Utama

1. App bar dengan back button
2. Category Name field
3. Save Category button
4. Cancel button

### Data yang Ditampilkan

Untuk Edit:

* `categories.name`

### Primary Action

Save Category.

### Secondary Action

Cancel / Back.

### Navigasi

* Category Form → Manage Category after save
* Category Form → Manage Category after cancel/back

### State

#### Default

Form kosong atau form terisi saat edit.

#### Loading

> Menyimpan kategori...

#### Validation Error

> Nama kategori wajib diisi.

#### Error

Snackbar:

> Kategori gagal disimpan.

#### Success

Snackbar:

> Kategori berhasil disimpan.

---

## 2.10 Settings / Profile Screen

### User Role

Customer.

### Tujuan Screen

Mengelola preferensi user yang disimpan dengan SharedPreferences.

### Komponen Utama

1. Screen title: Settings
2. User name input
3. Dark mode toggle
4. Product sort type select
5. Preferred view mode select
6. Last selected category info
7. Cart last opened info
8. Save Preferences button
9. Bottom navigation

### Data yang Ditampilkan

Dari SharedPreferences:

* `user_name`
* `is_dark_mode`
* `last_selected_category_id`
* `product_sort_type`
* `preferred_view_mode`
* `cart_last_opened`

### Primary Action

Save Preferences.

### Secondary Action

Navigate via bottom nav.

### Navigasi

* Settings → Home
* Settings → Cart
* Settings → Manage

### State

#### Default

Menampilkan preferensi yang tersimpan.

#### Loading

> Memuat preferensi...

#### Empty Default

Jika `user_name` kosong, tampilkan:

> Guest

#### Error

Snackbar:

> Preferensi gagal disimpan.

#### Success

Snackbar:

> Preferensi berhasil disimpan.

### Handoff Note

Preferred view hanya boleh:

* Grid
* List

Jangan gunakan:

* Bento Layout
* Editorial List
* Structured Grid

---

## 3. User Flow Mapping

---

## 3.1 Flow: Browse Product

### Alur Screen

Splash → Home → Product Detail

### Trigger Navigasi

1. Splash selesai → Home.
2. User tap product card → Product Detail.
3. User tap back → Home.

### Aksi User

1. Melihat produk.
2. Memilih kategori.
3. Mengubah sort/view mode.
4. Membuka detail produk.

### Output Sistem

1. Produk tampil dari SQLite.
2. Kategori terakhir dapat disimpan ke SharedPreferences.
3. View mode dan sort type mengikuti SharedPreferences.

### Kondisi Gagal/Error

1. Produk kosong → Empty Product State.
2. Produk gagal dimuat → Error State.
3. Produk tidak ditemukan → Product Not Found State.

---

## 3.2 Flow: Add to Cart

### Alur Screen

Home → Product Detail → Cart

### Trigger Navigasi

1. User tap product card.
2. User tap Add to Cart.
3. User buka Cart dari bottom navigation.

### Aksi User

1. Buka produk.
2. Tambahkan ke cart.
3. Lihat cart.

### Output Sistem

1. Item masuk ke `cart_items`.
2. Jika produk sudah ada di cart, quantity bertambah.
3. Snackbar sukses muncul.

### Kondisi Gagal/Error

1. Produk tidak ditemukan.
2. Quantity invalid.
3. Stok tidak cukup jika validasi stok diterapkan.
4. Add to cart gagal → snackbar error.

---

## 3.3 Flow: Manage Cart

### Alur Screen

Cart → Cart Item Update/Delete → Cart Empty jika tidak ada item

### Trigger Navigasi

1. User buka Cart.
2. User tap plus/minus.
3. User tap delete.
4. User konfirmasi delete.

### Aksi User

1. Mengubah quantity.
2. Menghapus item.
3. Melihat total harga.
4. Kembali ke katalog.

### Output Sistem

1. Quantity terupdate di SQLite.
2. Total berubah.
3. Item terhapus jika user konfirmasi.
4. Empty state muncul jika cart kosong.

### Kondisi Gagal/Error

1. Quantity kurang dari 1.
2. Cart gagal dimuat.
3. Delete gagal.
4. Product relation tidak ditemukan.

---

## 3.4 Flow: Product CRUD

### Alur Screen

Manage → Manage Product → Product Form → Manage Product → Home

### Trigger Navigasi

1. Tap Manage Product.
2. Tap Add Product.
3. Tap Edit Product.
4. Tap Save Product.
5. Tap Delete Product.

### Aksi User

1. Tambah produk.
2. Edit produk.
3. Hapus produk.
4. Lihat hasil produk di katalog.

### Output Sistem

1. Produk tersimpan di SQLite.
2. Produk muncul di Manage Product.
3. Produk muncul di Home.
4. Snackbar sukses muncul.

### Kondisi Gagal/Error

1. Nama produk kosong.
2. Kategori belum dipilih.
3. Harga tidak valid.
4. Stok tidak valid.
5. Save gagal.
6. Delete gagal.

---

## 3.5 Flow: Category CRUD

### Alur Screen

Manage → Manage Category → Category Form → Manage Category

### Trigger Navigasi

1. Tap Manage Category.
2. Tap Add Category.
3. Tap Edit Category.
4. Tap Delete Category.
5. Tap Save Category.

### Aksi User

1. Tambah kategori.
2. Edit kategori.
3. Hapus kategori.

### Output Sistem

1. Kategori tersimpan di SQLite.
2. Kategori tersedia di Product Form dropdown.
3. Kategori tersedia sebagai filter di Home.

### Kondisi Gagal/Error

1. Nama kategori kosong.
2. Kategori masih digunakan produk.
3. Save gagal.
4. Delete gagal.

---

## 3.6 Flow: Settings / SharedPreferences

### Alur Screen

Settings → Save Preferences → Settings

### Trigger Navigasi

1. User buka Settings.
2. User isi/ubah preferensi.
3. User tap Save Preferences.

### Aksi User

1. Mengubah user name.
2. Mengubah dark mode.
3. Memilih product sort type.
4. Memilih preferred view mode.

### Output Sistem

1. Preference tersimpan di SharedPreferences.
2. Snackbar sukses muncul.
3. Saat aplikasi dibuka kembali, preference tetap digunakan.

### Kondisi Gagal/Error

1. Preference gagal disimpan.
2. Key belum ada → gunakan default value.
3. Preferred view invalid → fallback ke Grid.

---

## 4. Design System

---

## 4.1 Color Tokens

Gunakan token warna utama berikut.

### Core Colors

| Token                | Value     | Usage                                     |
| -------------------- | --------- | ----------------------------------------- |
| `colorPrimary`       | `#111111` | Primary text, primary button, active icon |
| `colorOnPrimary`     | `#FFFFFF` | Text di atas primary button               |
| `colorBackground`    | `#F9F9F6` | App background                            |
| `colorSurface`       | `#FFFFFF` | Card, input, elevated surface             |
| `colorSurfaceMuted`  | `#F1F1EE` | Secondary surface                         |
| `colorTextPrimary`   | `#111111` | Heading/body utama                        |
| `colorTextSecondary` | `#666666` | Caption, helper text                      |
| `colorBorder`        | `#DADAD7` | Border card/input                         |
| `colorAccent`        | `#D8CBB8` | Chip selected / subtle highlight          |
| `colorError`         | `#BA1A1A` | Error text/action                         |
| `colorSuccess`       | `#12B76A` | Success state                             |
| `colorWarning`       | `#F79009` | Warning state                             |

### Usage Notes

1. Background utama gunakan off-white, bukan pure white.
2. Primary button selalu hitam dengan text putih.
3. Jangan menggunakan gradient.
4. Jangan menggunakan warna aksen terlalu banyak.
5. Status error/success boleh memakai warna, tetapi tetap sertakan text.

---

## 4.2 Typography

### Font Recommendation

Jika font custom tersedia:

* Heading: Archivo Narrow
* Body: Inter

Jika font custom tidak mau dipakai di Flutter:

* Heading: default sans-serif bold / condensed-like fallback
* Body: default Flutter font

Font custom boleh optional agar tidak menambah beban implementasi.

### Type Scale

| Style           |  Size |  Weight | Usage                        |
| --------------- | ----: | ------: | ---------------------------- |
| Display         | 40–48 |     700 | Splash / hero title          |
| Headline Large  | 28–32 |     700 | Screen title                 |
| Headline Medium | 22–24 | 600/700 | Section title                |
| Body Large      |    16 | 400/500 | Main body                    |
| Body Medium     |    14 | 400/500 | Supporting text              |
| Label           |    12 | 600/700 | Badge, chip, uppercase label |
| Caption         | 11–12 | 400/500 | Helper text                  |

### Typography Notes

1. Jangan gunakan font terlalu kecil untuk informasi penting.
2. Harga produk harus jelas dan mudah dibaca.
3. Gunakan uppercase secukupnya untuk label/chip, bukan semua text.
4. Jangan terlalu banyak variasi font weight.

---

## 4.3 Spacing Scale

Gunakan skala 4px.

| Token      | Value |
| ---------- | ----: |
| `spaceXs`  |     4 |
| `spaceSm`  |     8 |
| `spaceMd`  |    16 |
| `spaceLg`  |    24 |
| `spaceXl`  |    32 |
| `space2Xl` |    48 |

### Usage

1. Screen horizontal padding: 16px.
2. Gap antar card: 12–16px.
3. Gap section: 24px.
4. Button padding vertical: 12–16px.
5. Input vertical padding: 12–14px.

---

## 4.4 Border Radius

| Token        | Value | Usage            |
| ------------ | ----: | ---------------- |
| `radiusSm`   |     4 | Small badge/chip |
| `radiusMd`   |     8 | Input/button     |
| `radiusLg`   |    12 | Card             |
| `radiusFull` |   999 | Chip/circle      |

### Notes

1. Gunakan radius kecil-sedang agar tetap terasa bold/streetwear.
2. Hindari radius terlalu besar yang membuat visual terlalu playful.

---

## 4.5 Shadow / Elevation

Desain utama menggunakan flat card dengan border, bukan shadow besar.

Rules:

1. Card default gunakan border tipis.
2. Shadow boleh sangat subtle jika perlu.
3. Hindari floating/elevation berlebihan.
4. Dialog boleh memiliki overlay dan shadow.

---

## 4.6 Icon Style

1. Gunakan line icons / outline icons.
2. Icon harus sederhana dan jelas.
3. Gunakan icon dengan label jika aksi penting/destruktif.
4. Delete action harus disertai confirmation.
5. Hindari icon dekoratif tanpa fungsi.

---

## 4.7 Button Style

### Primary Button

* Background: black
* Text: white
* Radius: 8px
* Height: 48–52px
* Font weight: 600/700

Usage:

* Add to Cart
* Save Product
* Save Category
* Save Preferences

### Secondary Button

* Background: transparent/white
* Border: black or gray
* Text: black

Usage:

* Cancel
* Continue Browsing
* Back to Catalog

### Destructive Button

* Text/background menggunakan error color
* Harus muncul dalam confirmation dialog

Usage:

* Delete Product
* Delete Category
* Delete Cart Item

---

## 4.8 Input Style

1. Gunakan label jelas.
2. Gunakan border tipis.
3. Gunakan helper text jika perlu.
4. Validation error muncul di bawah field.
5. Numeric keyboard untuk price dan stock.
6. Dropdown untuk category.
7. Switch untuk dark mode.

---

## 4.9 Card Style

Card harus:

1. Menggunakan background white atau muted surface.
2. Memiliki border tipis.
3. Tidak menggunakan shadow berat.
4. Memiliki spacing internal 12–16px.
5. Menggunakan hierarchy yang jelas.

Jenis card:

* ProductCard
* ProductManageTile
* CartItemTile
* ManageMenuCard
* SettingTile
* EmptyStateCard

---

## 4.10 Badge / Status Style

### CategoryChip

* Selected: black text/filled or accent background
* Unselected: border gray / surface

### StockBadge

* In stock: neutral/black text
* Sold out: muted/error text if needed

### Status Rules

Jangan hanya mengandalkan warna. Sertakan text seperti:

* In Stock
* Sold Out
* Cart kosong
* Data gagal dimuat

---

## 5. Component Breakdown

---

## 5.1 AppBottomNav

### Fungsi

Navigasi utama aplikasi.

### Props/Data

* currentIndex
* onTap
* items: Home, Cart, Manage, Settings

### Variants

* Active item
* Inactive item

### States

* selected
* unselected

### Lokasi Penggunaan

* Home
* Cart
* Manage
* Settings

### Reusability Notes

Gunakan di screen utama saja. Jangan tampilkan di form jika layout terasa sempit.

---

## 5.2 AppTopBar

### Fungsi

Header screen.

### Props/Data

* title
* showBackButton
* onBack

### Variants

* Main tab top bar tanpa back
* Detail/form top bar dengan back

### States

Tidak ada state khusus.

### Lokasi Penggunaan

* Product Detail
* Manage Product
* Product Form
* Manage Category
* Category Form

### Reusability Notes

Jangan tambahkan cart icon di top bar.

---

## 5.3 ProductCard

### Fungsi

Menampilkan ringkasan produk di katalog.

### Props/Data

* productId
* name
* categoryName
* price
* stock
* imageName
* onTap

### Variants

* Grid card
* List item card

### States

* Default
* Sold out / stock low optional

### Lokasi Penggunaan

* Home / Product Catalog

### Reusability Notes

Klik card membuka Product Detail.

---

## 5.4 ProductManageTile

### Fungsi

Menampilkan produk untuk keperluan CRUD.

### Props/Data

* productId
* name
* categoryName
* price
* stock
* imageName
* onEdit
* onDelete

### Variants

* Default
* Low stock optional

### States

* Default
* Delete pending optional

### Lokasi Penggunaan

* Manage Product

---

## 5.5 ProductForm

### Fungsi

Form untuk tambah/edit produk.

### Props/Data

* initialName
* initialCategoryId
* initialPrice
* initialStock
* initialDescription
* initialImageName
* categoryOptions
* onSave
* onCancel

### Variants

* Add mode
* Edit mode

### States

* Default
* Loading save
* Validation error
* Save success
* Save error

### Lokasi Penggunaan

* Product Form Screen

---

## 5.6 CategoryChip

### Fungsi

Filter kategori di Home.

### Props/Data

* categoryId
* label
* isSelected
* onTap

### Variants

* Selected
* Unselected
* All category

### States

* Active
* Inactive

### Lokasi Penggunaan

* Home

---

## 5.7 CategoryManageTile

### Fungsi

Menampilkan kategori untuk CRUD.

### Props/Data

* categoryId
* name
* productCount optional
* onEdit
* onDelete

### Variants

* Default
* With product count

### States

* Default
* Delete disabled optional jika masih digunakan produk

### Lokasi Penggunaan

* Manage Category

---

## 5.8 CartItemTile

### Fungsi

Menampilkan item cart.

### Props/Data

* cartItemId
* productId
* productName
* price
* quantity
* subtotal
* imageName
* onIncrease
* onDecrease
* onDelete

### Variants

* Default
* Quantity disabled optional

### States

* Default
* Updating
* Delete pending

### Lokasi Penggunaan

* Cart

---

## 5.9 QuantityControl

### Fungsi

Mengubah jumlah item cart.

### Props/Data

* quantity
* onIncrease
* onDecrease

### Variants

* Enabled
* Disabled decrement ketika quantity = 1

### States

* Active
* Disabled

### Lokasi Penggunaan

* CartItemTile

---

## 5.10 EmptyState

### Fungsi

Menampilkan kondisi data kosong.

### Props/Data

* title
* description
* ctaLabel
* onCtaTap

### Variants

* Product empty
* Cart empty
* Category empty

### States

Tidak ada state khusus.

### Lokasi Penggunaan

* Home
* Cart
* Manage Product
* Manage Category

---

## 5.11 LoadingState

### Fungsi

Menampilkan proses loading sederhana.

### Props/Data

* message

### Variants

* Full screen
* Inline

### States

Tidak ada.

### Lokasi Penggunaan

* Product list
* Cart
* Settings
* Manage list

---

## 5.12 ErrorState

### Fungsi

Menampilkan error data gagal dimuat.

### Props/Data

* title
* description optional
* ctaLabel
* onRetry

### Variants

* Product error
* Cart error
* Category error
* Product not found

### States

Tidak ada.

### Lokasi Penggunaan

* Home
* Cart
* Product Detail
* Manage Product
* Manage Category

---

## 5.13 DeleteConfirmationDialog

### Fungsi

Konfirmasi sebelum delete.

### Props/Data

* title
* description
* cancelLabel
* confirmLabel
* onCancel
* onConfirm

### Variants

* Delete product
* Delete category
* Delete cart item

### States

* Default
* Loading delete optional

### Lokasi Penggunaan

* Manage Product
* Manage Category
* Cart

---

## 5.14 SuccessSnackbar

### Fungsi

Memberikan feedback aksi berhasil.

### Props/Data

* message

### Variants

* Product saved
* Product added to cart
* Cart updated
* Category saved
* Preferences saved

### States

Tidak ada.

### Lokasi Penggunaan

* Semua screen aksi.

---

## 5.15 SettingTile

### Fungsi

Menampilkan satu item setting/preference.

### Props/Data

* label
* value/control
* helperText optional

### Variants

* Text input
* Toggle
* Select
* Read-only info

### States

* Default
* Error optional
* Disabled optional

### Lokasi Penggunaan

* Settings

---

## 6. Layout & Responsive Rules

Karena project ini adalah mobile app Flutter, fokus responsive adalah layar Android mobile.

---

## 6.1 Safe Area

1. Semua screen harus berada dalam SafeArea.
2. Konten tidak boleh mepet status bar.
3. Bottom navigation tidak boleh menutup konten.
4. Jika ada tombol sticky, pastikan tidak tertutup navigation bar.

---

## 6.2 Scroll Behavior

1. Home menggunakan scroll untuk product list/grid.
2. Product Detail harus scrollable jika deskripsi panjang.
3. Cart harus scrollable jika item banyak.
4. Form screen harus scrollable agar keyboard tidak menutup input.
5. Settings harus scrollable jika konten melebihi tinggi layar.

---

## 6.3 Bottom Navigation Behavior

1. Bottom navigation hanya muncul di screen utama:

   * Home
   * Cart
   * Manage
   * Settings

2. Detail dan form boleh tidak memakai bottom nav agar fokus.

3. Active tab harus jelas.

4. Label harus selalu tampil agar mudah dipahami.

---

## 6.4 App Bar Behavior

1. Main tab screen tidak perlu back button.
2. Detail/form screen wajib punya back button.
3. Jangan tampilkan cart icon di AppBar.
4. Title harus menjelaskan posisi user.

---

## 6.5 One-Handed Usability

1. Primary action sebaiknya berada di area bawah atau mudah dijangkau.
2. Tap target minimal sekitar 44–48px.
3. Quantity control harus mudah ditekan.
4. Delete action jangan terlalu kecil.
5. Form field harus memiliki tinggi yang nyaman.

---

## 6.6 Frame Recommendation

Untuk handoff, gunakan satu baseline ukuran frame:

* 390 × 844
* atau 360 × 800

Developer tidak wajib mengikuti pixel-perfect, tetapi spacing dan hierarchy harus konsisten.

---

## 7. Data Binding Notes

---

## 7.1 Data dari SQLite

### categories

Field yang digunakan UI:

* `id`
* `name`
* optional product count via query

Muncul di:

* Home category chips
* Product Form category dropdown
* Manage Category
* Category Form edit state

### products

Field yang digunakan UI:

* `id`
* `category_id`
* `name`
* `price`
* `stock`
* `description`
* `image_name`

Muncul di:

* Home ProductCard
* Product Detail
* Manage Product
* Product Form
* Cart melalui relation product_id

### cart_items

Field yang digunakan UI:

* `id`
* `product_id`
* `quantity`

Data join/derived:

* product name
* price
* subtotal
* imageName
* total

Muncul di:

* Cart

---

## 7.2 Data dari SharedPreferences

Field/key yang digunakan UI:

* `user_name`
* `is_dark_mode`
* `last_selected_category_id`
* `product_sort_type`
* `preferred_view_mode`
* `cart_last_opened`

Muncul di:

* Home greeting
* Home selected category
* Home sort/view mode
* Cart last opened update
* Settings

---

## 7.3 Data Dummy yang Harus Diganti dengan Data Real

1. Product name dummy → `products.name`
2. Product price dummy → `products.price`
3. Product stock dummy → `products.stock`
4. Category dummy → `categories.name`
5. Cart dummy → `cart_items` + `products`
6. User name dummy → SharedPreferences `user_name`
7. View mode dummy → SharedPreferences `preferred_view_mode`
8. Sort type dummy → SharedPreferences `product_sort_type`

---

## 7.4 Komponen yang Butuh Data Dinamis

1. ProductCard
2. ProductDetailHeader
3. ProductManageTile
4. CategoryChip
5. CategoryManageTile
6. ProductForm category dropdown
7. CartItemTile
8. CartSummary
9. SettingTile
10. EmptyState conditional rendering

---

## 8. Interaction Notes

---

## 8.1 Tap Behavior

1. Tap ProductCard → Product Detail.
2. Tap Add to Cart → insert/update cart item.
3. Tap bottom nav item → switch screen.
4. Tap Add Product → Product Form Add.
5. Tap Edit Product → Product Form Edit.
6. Tap Delete Product → Delete Confirmation.
7. Tap Add Category → Category Form Add.
8. Tap Edit Category → Category Form Edit.
9. Tap Delete Category → Delete Confirmation or Conflict Error.
10. Tap Save Preferences → save to SharedPreferences.

---

## 8.2 Form Behavior

### Product Form

1. Validate before save.
2. Show validation message under field.
3. Disable Save button optional while saving.
4. After success, show snackbar and return to Manage Product.
5. On error, show snackbar/error message.

### Category Form

1. Validate category name.
2. Trim whitespace.
3. Show validation if empty.
4. After success, return to Manage Category.

### Settings

1. User can edit name.
2. User can toggle dark mode.
3. User can choose sort type.
4. User can choose view mode Grid/List.
5. Save writes to SharedPreferences.
6. Success snackbar after save.

---

## 8.3 Modal / Dialog Behavior

### Delete Confirmation

Used for:

1. Product delete.
2. Category delete.
3. Cart item delete.

Behavior:

1. Show dialog.
2. Cancel closes dialog.
3. Confirm runs delete.
4. On success, close dialog and show snackbar.
5. On failure, show error.

### Category Conflict Error

Shown when category is still used by products.

Behavior:

1. Show alert dialog.
2. User taps “Mengerti”.
3. Dialog closes.
4. Category remains unchanged.

---

## 8.4 Toast / Snackbar Behavior

Use snackbar for quick feedback:

* Produk berhasil disimpan.
* Produk berhasil ditambahkan ke cart.
* Produk berhasil dihapus.
* Cart berhasil diperbarui.
* Kategori berhasil disimpan.
* Kategori berhasil dihapus.
* Preferensi berhasil disimpan.
* Data gagal disimpan.
* Data gagal dimuat.

Snackbar should be short and not block navigation.

---

## 8.5 Loading Behavior

Use simple loading indicator or inline loading text.

Avoid:

* complex skeleton
* long animation
* shimmer if not necessary

---

## 8.6 Error Behavior

Error messages must be human-readable.

Do not show raw database error to user.

Examples:

* Data produk gagal dimuat.
* Produk gagal disimpan.
* Kategori tidak bisa dihapus karena masih digunakan produk.
* Cart gagal dimuat.
* Preferensi gagal disimpan.

---

## 8.7 Success Behavior

After successful action:

1. Show snackbar.
2. Refresh related list.
3. Return to previous list screen if form save.
4. Keep user on screen if action is small, such as cart quantity update.

---

## 9. Accessibility Notes

### Kontras Warna

1. Black text on off-white background is acceptable.
2. White text on black button is acceptable.
3. Error/success colors must still include text labels.

### Ukuran Font

1. Body text minimal 14px equivalent.
2. Main CTA text minimal 14–16px.
3. Caption/helper text minimal 12px.
4. Jangan gunakan text terlalu kecil untuk informasi penting.

### Tap Target

1. Buttons minimal 44–48px height.
2. Icon buttons must have enough padding.
3. Quantity control buttons must be easy to tap.
4. Delete icon must not be too small.

### Label Input

1. Every input must have visible label.
2. Placeholder is not enough.
3. Validation message must be close to field.

### Focus State

In Flutter, ensure input focus is visible through border or cursor state.

### Status Not Only Based on Color

Do not rely only on red/green. Always include text like:

* Error
* Berhasil
* In Stock
* Cart kosong
* Data gagal dimuat

---

## 10. Developer Implementation Notes

---

## 10.1 Recommended Frontend Structure

Recommended Flutter structure:

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
├── screens/
│   ├── home/
│   ├── cart/
│   ├── manage/
│   └── settings/
├── widgets/
└── navigation/
```

---

## 10.2 Suggested Screen Files

```text
screens/home/home_screen.dart
screens/home/product_detail_screen.dart
screens/cart/cart_screen.dart
screens/manage/manage_screen.dart
screens/manage/manage_product_screen.dart
screens/manage/product_form_screen.dart
screens/manage/manage_category_screen.dart
screens/manage/category_form_screen.dart
screens/settings/settings_screen.dart
```

Splash can be:

```text
screens/splash/splash_screen.dart
```

---

## 10.3 Suggested Reusable Widgets

```text
widgets/app_bottom_nav.dart
widgets/app_top_bar.dart
widgets/primary_button.dart
widgets/secondary_button.dart
widgets/product_card.dart
widgets/product_manage_tile.dart
widgets/category_manage_tile.dart
widgets/cart_item_tile.dart
widgets/quantity_control.dart
widgets/category_chip.dart
widgets/stock_badge.dart
widgets/empty_state.dart
widgets/loading_state.dart
widgets/error_state.dart
widgets/custom_text_field.dart
widgets/custom_dropdown.dart
widgets/setting_tile.dart
```

---

## 10.4 Components That Should Be Split

1. ProductCard
2. CartItemTile
3. QuantityControl
4. ProductManageTile
5. CategoryManageTile
6. ProductForm fields
7. SettingTile
8. EmptyState
9. DeleteConfirmationDialog
10. AppBottomNav

Do not build all UI inside one giant screen file.

---

## 10.5 Things Not Needed for Assessment 2

Do not implement:

1. Backend.
2. API.
3. Login/register.
4. Payment gateway.
5. Checkout.
6. Shipping.
7. Address.
8. Order history.
9. Wishlist.
10. Maps.
11. Chart.
12. Upload image.
13. Product size.
14. Recently viewed.
15. Product rating/review.
16. Complex state management.
17. Complex animations.

---

## 10.6 Slicing Risks

### Risk 1: Product Detail Showing Extra Fields

If design still shows material/fit/care, ignore/remove those fields during slicing.

### Risk 2: Image Asset Name Misunderstood as Upload

Image is local asset only. Do not implement picker/upload.

### Risk 3: Product Count in Category

Product count is optional. If implementation is tight, omit or calculate simply.

### Risk 4: Frame Size Inconsistency

Use responsive Flutter layout, not pixel-perfect fixed width.

### Risk 5: State Handling Forgotten

Implement at least basic empty/loading/error state for major screens.

---

## 10.7 Recommended Implementation Order

### Phase 1 — Foundation

1. Project structure.
2. Theme setup.
3. Models:

   * CategoryModel
   * ProductModel
   * CartItemModel
4. SQLite DatabaseHelper.
5. SharedPreferences PreferenceHelper.

### Phase 2 — Category

1. Manage Category.
2. Category Form.
3. Add/Edit/Delete category.
4. Delete conflict check.

### Phase 3 — Product

1. Manage Product.
2. Product Form.
3. Add/Edit/Delete product.
4. Product list load.

### Phase 4 — Catalog

1. Home screen.
2. ProductCard.
3. Category filter.
4. Product detail.
5. Empty/error/loading states.

### Phase 5 — Cart

1. Add to cart.
2. Cart list.
3. Quantity update.
4. Delete item.
5. Total calculation.
6. Empty cart state.

### Phase 6 — SharedPreferences

1. Settings screen.
2. Save/load user_name.
3. Save/load dark mode.
4. Save/load sort type.
5. Save/load view mode.
6. Save/load last selected category.
7. Save/load cart last opened.

### Phase 7 — UI Polish & QA

1. Spacing cleanup.
2. Typography consistency.
3. Snackbar feedback.
4. Dialog confirmation.
5. Manual test.
6. Flutter analyze/build check.

---

## 10.8 Final Handoff Rules

1. Keep scope aligned with PRD and Technical Design.
2. Do not invent extra screens.
3. Do not add database fields because of visual decoration.
4. Do not implement dummy UI that cannot connect to SQLite/SharedPreferences.
5. Every visible dynamic value must map to SQLite, SharedPreferences, or simple calculated value.
6. Prioritize working local storage over visual perfection.
7. Build simple and explainable UI for Assessment 2.

---

## Final Developer Reminder

This design is ready to guide Flutter implementation as a local-first mobile app. The main proof of success is not how fancy the UI looks, but whether the developer can clearly demonstrate:

1. SQLite CRUD for products and categories.
2. SQLite cart management.
3. SharedPreferences persistence for 6 keys.
4. Clean mobile flow.
5. Simple, maintainable Flutter implementation.
6. Scope discipline: no backend, no auth, no payment, no checkout.

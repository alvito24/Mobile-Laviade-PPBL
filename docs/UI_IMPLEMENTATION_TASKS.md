# UI_IMPLEMENTATION_TASK_BREAKDOWN.md

# Laviade Studio Mobile — Local Catalog & Cart

## Assessment 2 PPBL

---

## Project Information

### Project

**Laviade Studio Mobile — Local Catalog & Cart**

### Platform

Mobile App

### Tech Stack Frontend

* Flutter
* Dart
* Flutter Material Components
* State sederhana: `setState`, `FutureBuilder`
* Local database: SQLite
* Local preferences: SharedPreferences

### Dokumen Referensi

* PRD Assessment 2
* Technical Design Assessment 2
* DESIGN_HANDOFF.md
* AGENTS.md

### Tujuan Breakdown

Membagi implementasi UI menjadi task kecil, aman, dan realistis agar AI Agent di IDE tidak membangun fitur terlalu besar sekaligus. Task disusun dari fondasi desain, layout, komponen reusable, screen static, UI state, sampai integrasi data lokal.

### Catatan Scope

Project ini tidak menggunakan:

* backend,
* API,
* login/register,
* payment,
* checkout real,
* shipping,
* order history,
* address,
* wishlist,
* maps,
* chart,
* upload gambar,
* product size selection,
* recently viewed.

---

# Phase 1 — Setup Design Foundation

---

## Task 1: Setup Design Tokens dan Theme Dasar

### Tujuan

Membuat fondasi visual aplikasi agar warna, typography, spacing, button, input, dan card konsisten sejak awal.

### Scope

* Membuat file theme aplikasi.
* Mendefinisikan warna utama.
* Mendefinisikan text style dasar.
* Mendefinisikan radius, spacing, dan style button dasar.
* Menyiapkan light theme.
* Menyiapkan dark theme sederhana jika dibutuhkan untuk `is_dark_mode`.

### Out of scope

* Belum membuat screen.
* Belum membuat SQLite.
* Belum membuat SharedPreferences logic.
* Belum membuat animasi kompleks.
* Belum menambahkan font custom wajib.

### Screen/component terkait

* Semua screen.
* Semua reusable component.

### File yang kemungkinan dibuat

* `lib/core/theme/app_theme.dart`
* `lib/core/constants/app_colors.dart`
* `lib/core/constants/app_spacing.dart`
* `lib/core/constants/app_radius.dart`

### File yang kemungkinan diubah

* `lib/main.dart`
* `lib/app.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Design System**
* DESIGN_HANDOFF.md bagian **Color Tokens**
* DESIGN_HANDOFF.md bagian **Typography**
* DESIGN_HANDOFF.md bagian **Spacing Scale**

### Acceptance criteria

* Aplikasi memiliki theme dasar.
* Warna utama mengikuti style Laviade: black, off-white, white, gray.
* Primary button default berwarna hitam dengan teks putih.
* Input dan card memiliki border/radius konsisten.
* Tidak ada gradient random atau style berlebihan.

### Manual test

* Jalankan aplikasi.
* Pastikan app tidak error.
* Pastikan theme berhasil dipakai di screen kosong/default.
* Ganti sementara warna background untuk memastikan theme terbaca.

### Risiko

* Style terlalu kompleks dari awal.
* Font custom menambah beban implementasi.
* Dark mode dibuat terlalu detail sebelum kebutuhan utama selesai.

---

## Task 2: Setup Struktur Folder UI

### Tujuan

Membuat struktur folder awal agar project rapi dan sesuai Technical Design serta AGENTS.md.

### Scope

* Membuat folder screen.
* Membuat folder widget.
* Membuat folder navigation.
* Membuat folder core.
* Membuat file placeholder bila diperlukan.

### Out of scope

* Belum implementasi UI detail.
* Belum membuat database/helper.
* Belum membuat logic CRUD.

### Screen/component terkait

* Semua screen dan widget.

### File yang kemungkinan dibuat

* `lib/screens/splash/`
* `lib/screens/home/`
* `lib/screens/cart/`
* `lib/screens/manage/`
* `lib/screens/settings/`
* `lib/widgets/`
* `lib/navigation/`
* `lib/core/`

### File yang kemungkinan diubah

* `lib/main.dart`
* `lib/app.dart`

### Design reference

* Technical Design bagian **Folder Structure**
* DESIGN_HANDOFF.md bagian **Developer Implementation Notes**

### Acceptance criteria

* Struktur folder sesuai rencana.
* Tidak ada folder yang terlalu berlebihan.
* File screen/widget terpisah dengan jelas.
* Project tetap bisa dijalankan.

### Manual test

* Jalankan `flutter analyze`.
* Pastikan tidak ada import error.
* Pastikan folder mudah dibaca.

### Risiko

* Terlalu banyak folder kosong.
* Struktur terlalu kompleks untuk Assessment 2.
* Agent membuat folder arsitektur yang tidak diminta.

---

# Phase 2 — Setup Main Layout & Navigation

---

## Task 3: Implement App Entry, App Scaffold, dan Main Navigation

### Tujuan

Membuat kerangka navigasi utama aplikasi menggunakan bottom navigation.

### Scope

* Membuat `MainNavigation`.
* Membuat bottom navigation dengan 4 tab:

  1. Home
  2. Cart
  3. Manage
  4. Settings
* Menyiapkan screen placeholder untuk setiap tab.
* Menjaga active tab state.
* Menghubungkan `app.dart` ke main navigation.

### Out of scope

* Belum membuat isi detail setiap screen.
* Belum integrasi SQLite.
* Belum integrasi SharedPreferences.
* Belum membuat Product Detail/Form navigation.

### Screen/component terkait

* Home
* Cart
* Manage
* Settings
* AppBottomNav

### File yang kemungkinan dibuat

* `lib/navigation/main_navigation.dart`
* `lib/widgets/app_bottom_nav.dart`
* `lib/screens/home/home_screen.dart`
* `lib/screens/cart/cart_screen.dart`
* `lib/screens/manage/manage_screen.dart`
* `lib/screens/settings/settings_screen.dart`

### File yang kemungkinan diubah

* `lib/app.dart`
* `lib/main.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Screen List**
* DESIGN_HANDOFF.md bagian **Layout & Responsive Rules**
* DESIGN_HANDOFF.md bagian **AppBottomNav**

### Acceptance criteria

* Bottom navigation memiliki 4 tab.
* User bisa berpindah Home, Cart, Manage, Settings.
* Active tab terlihat jelas.
* Tidak ada back button pada screen utama tab.
* Tidak ada cart icon tambahan di top bar.

### Manual test

* Jalankan aplikasi.
* Tap setiap tab bottom navigation.
* Pastikan screen berubah sesuai tab.
* Pastikan active state bottom nav berubah.
* Pastikan tidak ada screen crash.

### Risiko

* Bottom nav muncul di screen detail/form yang seharusnya fokus.
* Navigasi terlalu kompleks.
* Agent menambahkan route yang belum dibutuhkan.

---

## Task 4: Implement Splash Screen Static

### Tujuan

Membuat splash screen sederhana sesuai final design.

### Scope

* Membuat screen splash.
* Menampilkan brand name “Laviade Studio”.
* Menampilkan subtitle “Local Catalog & Cart”.
* Setelah delay singkat, masuk ke main navigation.
* Visual monochrome minimal.

### Out of scope

* Tidak ada onboarding.
* Tidak ada login/register.
* Tidak ada animasi kompleks.
* Tidak ada pengecekan auth.

### Screen/component terkait

* SplashScreen
* MainNavigation

### File yang kemungkinan dibuat

* `lib/screens/splash/splash_screen.dart`

### File yang kemungkinan diubah

* `lib/app.dart`
* `lib/main.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Splash Screen**

### Acceptance criteria

* Splash tampil saat aplikasi pertama dibuka.
* Brand name dan subtitle muncul jelas.
* Setelah durasi singkat, user diarahkan ke Home.
* Tidak ada login/register.

### Manual test

* Jalankan aplikasi dari awal.
* Pastikan splash muncul.
* Pastikan setelah beberapa detik masuk Home.
* Restart app untuk cek splash muncul kembali.

### Risiko

* Delay terlalu lama.
* Splash dibuat terlalu kompleks.
* Agent menambahkan onboarding yang tidak diminta.

---

# Phase 3 — Reusable Components

---

## Task 5: Implement Reusable Basic Components

### Tujuan

Membuat komponen UI dasar yang akan dipakai di banyak screen.

### Scope

Membuat komponen:

* `PrimaryButton`
* `SecondaryButton`
* `CustomTextField`
* `CustomDropdown`
* `SectionTitle`
* `EmptyState`
* `LoadingState`
* `ErrorState`

### Out of scope

* Belum membuat ProductCard.
* Belum membuat CartItemTile.
* Belum membuat database logic.
* Belum membuat validation logic penuh.

### Screen/component terkait

* Semua screen.

### File yang kemungkinan dibuat

* `lib/widgets/primary_button.dart`
* `lib/widgets/secondary_button.dart`
* `lib/widgets/custom_text_field.dart`
* `lib/widgets/custom_dropdown.dart`
* `lib/widgets/section_title.dart`
* `lib/widgets/empty_state.dart`
* `lib/widgets/loading_state.dart`
* `lib/widgets/error_state.dart`

### File yang kemungkinan diubah

* `lib/core/theme/app_theme.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Component Breakdown**
* DESIGN_HANDOFF.md bagian **Button Style**
* DESIGN_HANDOFF.md bagian **Input Style**

### Acceptance criteria

* Button reusable bisa menerima label dan onPressed.
* Text field memiliki label dan error text.
* Dropdown bisa menerima list option sederhana.
* EmptyState memiliki title, description, dan CTA optional.
* LoadingState dan ErrorState sederhana, tidak berlebihan.

### Manual test

* Pakai sementara komponen di screen placeholder.
* Cek button bisa ditekan.
* Cek input tampil dengan label.
* Cek empty/loading/error component tampil tanpa overflow.

### Risiko

* Komponen terlalu fleksibel dan kompleks.
* Style tiap komponen tidak konsisten.
* Agent membuat terlalu banyak variant yang tidak dibutuhkan.

---

## Task 6: Implement Product UI Components

### Tujuan

Membuat komponen produk yang dipakai di katalog dan manage product.

### Scope

Membuat:

* `ProductCard`
* `ProductListTile`
* `ProductManageTile`
* `CategoryChip`
* `StockBadge`

### Out of scope

* Belum membuat Product Detail Screen.
* Belum integrasi SQLite.
* Belum implementasi add/edit/delete logic.
* Belum implementasi filter logic penuh.

### Screen/component terkait

* Home
* Manage Product
* Product Detail

### File yang kemungkinan dibuat

* `lib/widgets/product_card.dart`
* `lib/widgets/product_list_tile.dart`
* `lib/widgets/product_manage_tile.dart`
* `lib/widgets/category_chip.dart`
* `lib/widgets/stock_badge.dart`

### File yang kemungkinan diubah

* `lib/screens/home/home_screen.dart`
* `lib/screens/manage/manage_product_screen.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **ProductCard**
* DESIGN_HANDOFF.md bagian **ProductManageTile**
* DESIGN_HANDOFF.md bagian **CategoryChip**
* DESIGN_HANDOFF.md bagian **StockBadge**

### Acceptance criteria

* ProductCard menampilkan image placeholder, nama, kategori, harga, stok.
* ProductManageTile menampilkan edit dan delete action.
* CategoryChip punya selected dan unselected state.
* StockBadge bisa menampilkan status stok.
* Semua harga tampil dalam format Rupiah.

### Manual test

* Render dummy product di Home.
* Render dummy manage product item.
* Tap ProductCard dan pastikan callback terpanggil.
* Tap edit/delete icon dan pastikan callback terpanggil.
* Ubah selected state CategoryChip dan pastikan visual berubah.

### Risiko

* Komponen terlalu tergantung data model final.
* ProductCard terlalu ramai.
* Gambar produk dipaksa upload/online image.

---

## Task 7: Implement Cart UI Components

### Tujuan

Membuat komponen reusable untuk cart.

### Scope

Membuat:

* `CartItemTile`
* `QuantityControl`
* `CartSummary`
* `DeleteConfirmationDialog`

### Out of scope

* Belum integrasi SQLite cart.
* Belum implementasi total calculation dari database.
* Belum implementasi stock validation final.

### Screen/component terkait

* Cart
* Manage Product
* Manage Category

### File yang kemungkinan dibuat

* `lib/widgets/cart_item_tile.dart`
* `lib/widgets/quantity_control.dart`
* `lib/widgets/cart_summary.dart`
* `lib/widgets/delete_confirmation_dialog.dart`

### File yang kemungkinan diubah

* `lib/screens/cart/cart_screen.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **CartItemTile**
* DESIGN_HANDOFF.md bagian **QuantityControl**
* DESIGN_HANDOFF.md bagian **DeleteConfirmationDialog**

### Acceptance criteria

* CartItemTile menampilkan product name, price, quantity, subtotal, delete action.
* QuantityControl memiliki plus dan minus.
* Minus disabled atau tidak menurunkan quantity di bawah 1.
* DeleteConfirmationDialog bisa dipakai untuk product, category, dan cart item.
* CartSummary menampilkan total harga.

### Manual test

* Render dummy cart item.
* Tap plus dan minus.
* Pastikan quantity tidak bisa turun di bawah 1.
* Tap delete dan tampilkan dialog.
* Tap cancel dan dialog tertutup.
* Tap hapus dan callback terpanggil.

### Risiko

* Quantity control terlalu kompleks.
* Delete dialog hanya cocok untuk satu jenis item.
* Cart tile menampilkan data out of scope seperti size/shipping.

---

## Task 8: Implement Settings UI Components

### Tujuan

Membuat komponen reusable untuk halaman settings dan SharedPreferences UI.

### Scope

Membuat:

* `SettingTile`
* `PreferenceSelect`
* `ProfileNameInput`
* `SessionInfoCard`

### Out of scope

* Belum menyimpan ke SharedPreferences.
* Belum implementasi dark mode logic.
* Belum membaca category terakhir dari local storage.

### Screen/component terkait

* Settings

### File yang kemungkinan dibuat

* `lib/widgets/setting_tile.dart`
* `lib/widgets/preference_select.dart`
* `lib/widgets/profile_name_input.dart`
* `lib/widgets/session_info_card.dart`

### File yang kemungkinan diubah

* `lib/screens/settings/settings_screen.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Settings / Profile Screen**
* DESIGN_HANDOFF.md bagian **SettingTile**

### Acceptance criteria

* User name input tampil jelas.
* Toggle dark mode tampil jelas.
* Select sort type tampil jelas.
* Select preferred view hanya punya opsi Grid/List.
* Session info card tidak terlalu dominan.

### Manual test

* Render settings dengan dummy preference.
* Ubah input user name.
* Toggle dark mode.
* Pilih Grid/List.
* Pastikan visual tidak overflow.

### Risiko

* Preferred view dibuat terlalu kompleks.
* Session info terlalu besar.
* Agent menambahkan key baru di luar PRD.

---

# Phase 4 — Static Screen Slicing

---

## Task 9: Slice Home / Product Catalog Static UI

### Tujuan

Membuat tampilan Home sesuai design handoff menggunakan dummy data.

### Scope

* Header Home.
* Greeting user.
* Category chips.
* Sort control.
* View mode toggle.
* Product grid/list dengan dummy data.
* Bottom navigation sudah menggunakan layout utama.

### Out of scope

* Belum integrasi SQLite.
* Belum menyimpan selected category ke SharedPreferences.
* Belum navigation ke real Product Detail.
* Belum sorting real.

### Screen/component terkait

* HomeScreen
* ProductCard
* CategoryChip

### File yang kemungkinan dibuat

* `lib/screens/home/home_screen.dart`

### File yang kemungkinan diubah

* `lib/widgets/product_card.dart`
* `lib/widgets/category_chip.dart`
* `lib/navigation/main_navigation.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Home / Product Catalog Screen**

### Acceptance criteria

* Home tampil sesuai design.
* ProductCard dummy tampil rapi.
* Category chips tampil horizontal dan scrollable.
* Grid/list toggle terlihat.
* Tidak ada back button di Home.
* Tidak ada cart icon tambahan di top bar.

### Manual test

* Buka aplikasi.
* Masuk Home.
* Scroll product list.
* Tap category chip.
* Tap toggle view mode.
* Pastikan tidak overflow.

### Risiko

* Home terlalu ramai.
* Category chips tidak scrollable.
* Grid/List toggle dianggap sudah harus menyimpan preference padahal task ini static UI.

---

## Task 10: Slice Product Detail Static UI

### Tujuan

Membuat tampilan detail produk berdasarkan dummy data.

### Scope

* App bar dengan back button.
* Product image placeholder.
* Product name.
* Category chip.
* Stock badge.
* Price.
* Description.
* Add to Cart button.

### Out of scope

* Belum integrasi produk dari SQLite.
* Belum add to cart real.
* Tidak membuat material/fit/care.
* Tidak membuat size selection.

### Screen/component terkait

* ProductDetailScreen
* ProductDetailHeader
* PrimaryButton

### File yang kemungkinan dibuat

* `lib/screens/home/product_detail_screen.dart`

### File yang kemungkinan diubah

* `lib/screens/home/home_screen.dart`
* `lib/widgets/primary_button.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Product Detail Screen**

### Acceptance criteria

* Product Detail tampil rapi.
* Tidak ada Material/Fit/Care.
* Tidak ada size.
* Tidak ada checkout/payment/shipping.
* Add to Cart terlihat sebagai primary CTA.
* Back button bekerja.

### Manual test

* Dari Home, sementara tap product dummy menuju Product Detail.
* Tap back dan kembali ke Home.
* Pastikan screen tidak overflow.
* Pastikan Add to Cart callback bisa menampilkan snackbar dummy.

### Risiko

* Agent menambahkan field product di luar schema.
* Detail screen terlalu besar dan tidak scrollable.
* Tombol Add to Cart terlalu bawah atau tertutup navigation.

---

## Task 11: Slice Cart Static UI

### Tujuan

Membuat tampilan Cart dengan dummy cart item.

### Scope

* Cart title.
* CartItemTile dummy.
* QuantityControl.
* CartSummary.
* Continue Browsing button.
* Local cart simulation note.
* Delete confirmation dialog.

### Out of scope

* Belum integrasi SQLite.
* Belum total calculation dari database.
* Belum validasi stok.
* Tidak membuat checkout/shipping/payment.

### Screen/component terkait

* CartScreen
* CartItemTile
* QuantityControl
* CartSummary
* DeleteConfirmationDialog

### File yang kemungkinan dibuat

* `lib/screens/cart/cart_screen.dart`

### File yang kemungkinan diubah

* `lib/widgets/cart_item_tile.dart`
* `lib/widgets/cart_summary.dart`
* `lib/widgets/delete_confirmation_dialog.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Cart Screen**

### Acceptance criteria

* Cart menampilkan item dummy.
* Quantity control terlihat dan bisa ditekan secara dummy.
* Total harga tampil.
* Continue Browsing button ada.
* Tidak ada checkout, shipping, payment, order, address.
* Delete confirmation muncul saat delete ditekan.

### Manual test

* Buka Cart.
* Tap plus/minus.
* Tap delete.
* Pastikan dialog muncul.
* Tap Batal.
* Tap Continue Browsing dan kembali ke Home.

### Risiko

* Muncul wording checkout real.
* Empty cart tertukar dengan recently viewed.
* Quantity control menurunkan sampai 0.

---

## Task 12: Slice Manage Screen Static UI

### Tujuan

Membuat screen Manage sebagai pintu masuk Product CRUD dan Category CRUD.

### Scope

* Header Manage Data.
* Copy “Kelola data lokal untuk demo SQLite.”
* Manage Product card.
* Manage Category card.
* Navigation ke screen placeholder.

### Out of scope

* Belum CRUD real.
* Belum count produk/kategori wajib.
* Tidak membuat dashboard admin/statistik/chart.

### Screen/component terkait

* ManageScreen
* ManageMenuCard

### File yang kemungkinan dibuat

* `lib/screens/manage/manage_screen.dart`
* `lib/widgets/manage_menu_card.dart`

### File yang kemungkinan diubah

* `lib/navigation/main_navigation.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Manage Screen**

### Acceptance criteria

* Manage screen hanya punya dua menu utama.
* Manage Product card bisa ditekan.
* Manage Category card bisa ditekan.
* Tidak ada admin dashboard kompleks.
* Tidak ada chart/statistik/payment/order.

### Manual test

* Buka tab Manage.
* Tap Manage Product.
* Tap Manage Category.
* Pastikan navigasi menuju placeholder/screen target.

### Risiko

* Agent menambahkan analytics dashboard.
* Manage screen terlalu ramai.
* Card menggunakan background dekoratif berlebihan.

---

## Task 13: Slice Manage Product Static UI

### Tujuan

Membuat UI daftar produk untuk kebutuhan CRUD produk menggunakan dummy data.

### Scope

* App bar dengan back button.
* Title Manage Product.
* ProductManageTile list.
* Add Product FAB/button.
* Edit action.
* Delete action.
* Delete confirmation dialog.

### Out of scope

* Belum integrasi SQLite.
* Belum create/edit/delete real.
* Belum search/filter wajib.
* Belum validasi form.

### Screen/component terkait

* ManageProductScreen
* ProductManageTile
* DeleteConfirmationDialog

### File yang kemungkinan dibuat

* `lib/screens/manage/manage_product_screen.dart`

### File yang kemungkinan diubah

* `lib/widgets/product_manage_tile.dart`
* `lib/widgets/delete_confirmation_dialog.dart`
* `lib/screens/manage/manage_screen.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Manage Product Screen**

### Acceptance criteria

* Manage Product menampilkan list produk dummy.
* Add Product button terlihat jelas.
* Edit icon terlihat.
* Delete icon terlihat.
* Delete confirmation muncul.
* Back button kembali ke Manage.

### Manual test

* Buka Manage Product.
* Tap Add Product dan masuk ke Product Form placeholder.
* Tap edit dan masuk ke Product Form edit placeholder.
* Tap delete dan dialog muncul.
* Tap back dan kembali ke Manage.

### Risiko

* Product management item tidak konsisten dengan ProductCard.
* Delete action tidak punya confirmation.
* Search/filter dianggap wajib padahal optional.

---

## Task 14: Slice Product Form Static UI

### Tujuan

Membuat UI form tambah/edit produk sesuai schema `products`.

### Scope

* Product Name field.
* Category Dropdown.
* Price field.
* Stock field.
* Description field.
* Image Asset Name field.
* Save Product button.
* Cancel button.
* Validation message visual.

### Out of scope

* Belum save ke SQLite.
* Belum load kategori dari SQLite.
* Tidak membuat image upload.
* Tidak membuat material/fit/care.
* Tidak membuat size/color field.

### Screen/component terkait

* ProductFormScreen
* CustomTextField
* CustomDropdown
* PrimaryButton
* SecondaryButton

### File yang kemungkinan dibuat

* `lib/screens/manage/product_form_screen.dart`

### File yang kemungkinan diubah

* `lib/widgets/custom_text_field.dart`
* `lib/widgets/custom_dropdown.dart`
* `lib/screens/manage/manage_product_screen.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Product Form Screen**

### Acceptance criteria

* Field sesuai schema Technical Design.
* Image field hanya untuk local asset name.
* Tidak ada copy cloud bucket.
* Tidak ada upload button.
* Tidak ada material/fit/care/size.
* Save dan Cancel button terlihat jelas.

### Manual test

* Buka Product Form dari Add Product.
* Isi field dummy.
* Kosongkan nama produk dan tampilkan validation dummy.
* Tap Cancel dan kembali ke Manage Product.

### Risiko

* Agent menambah field di luar schema.
* Form terlalu panjang dan tidak scrollable.
* Numeric keyboard belum disiapkan untuk price/stock.

---

## Task 15: Slice Manage Category Static UI

### Tujuan

Membuat UI list kategori untuk CRUD kategori menggunakan dummy data.

### Scope

* App bar dengan back button.
* Title Manage Category.
* CategoryManageTile list.
* Add Category button/FAB.
* Edit action.
* Delete action.
* Delete confirmation.
* Delete conflict dialog.

### Out of scope

* Belum integrasi SQLite.
* Belum product count wajib.
* Belum real delete conflict check.

### Screen/component terkait

* ManageCategoryScreen
* CategoryManageTile
* DeleteConfirmationDialog

### File yang kemungkinan dibuat

* `lib/screens/manage/manage_category_screen.dart`
* `lib/widgets/category_manage_tile.dart`

### File yang kemungkinan diubah

* `lib/screens/manage/manage_screen.dart`
* `lib/widgets/delete_confirmation_dialog.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Manage Category Screen**

### Acceptance criteria

* List kategori dummy tampil.
* Add Category button terlihat.
* Edit dan delete action tersedia.
* Delete confirmation muncul.
* Conflict error dialog tersedia.
* Back button kembali ke Manage.

### Manual test

* Buka Manage Category.
* Tap Add Category dan masuk ke Category Form.
* Tap edit dan masuk ke Category Form edit.
* Tap delete dan dialog muncul.
* Trigger conflict dummy dan error dialog muncul.

### Risiko

* Product count menjadi fitur wajib.
* Delete conflict tidak disediakan.
* Category tile terlalu ramai.

---

## Task 16: Slice Category Form Static UI

### Tujuan

Membuat UI form tambah/edit kategori.

### Scope

* Category Name field.
* Save Category button.
* Cancel button.
* Validation message.

### Out of scope

* Belum save ke SQLite.
* Belum check duplicate category.
* Belum logic edit real.

### Screen/component terkait

* CategoryFormScreen
* CustomTextField
* PrimaryButton
* SecondaryButton

### File yang kemungkinan dibuat

* `lib/screens/manage/category_form_screen.dart`

### File yang kemungkinan diubah

* `lib/screens/manage/manage_category_screen.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Category Form Screen**

### Acceptance criteria

* Form terlihat sederhana.
* Category Name field punya label.
* Save dan Cancel button ada.
* Validation message “Nama kategori wajib diisi” tersedia.
* Back button kembali ke Manage Category.

### Manual test

* Buka Add Category.
* Kosongkan input dan tampilkan validation dummy.
* Isi nama kategori.
* Tap Cancel dan kembali.

### Risiko

* Form terlalu kecil/tidak nyaman.
* Validation tidak terlihat dekat input.
* Agent menambahkan field tidak perlu.

---

## Task 17: Slice Settings Static UI

### Tujuan

Membuat UI Settings untuk 6 key SharedPreferences menggunakan dummy state.

### Scope

* User name input.
* Dark mode toggle.
* Product sort type select.
* Preferred view mode select Grid/List.
* Last selected category info.
* Cart last opened info.
* Save Preferences button.

### Out of scope

* Belum save/load SharedPreferences.
* Belum implement dark theme real.
* Tidak menambah key baru.
* Tidak menambah account/profile kompleks.

### Screen/component terkait

* SettingsScreen
* SettingTile
* PreferenceSelect
* ProfileNameInput
* SessionInfoCard

### File yang kemungkinan dibuat

* `lib/screens/settings/settings_screen.dart`

### File yang kemungkinan diubah

* `lib/widgets/setting_tile.dart`
* `lib/widgets/preference_select.dart`
* `lib/widgets/profile_name_input.dart`
* `lib/widgets/session_info_card.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Settings / Profile Screen**

### Acceptance criteria

* Semua 6 key SharedPreferences punya representasi UI.
* Preferred view hanya Grid/List.
* Tidak ada account/login/avatar kompleks.
* Save Preferences button terlihat jelas.
* UI tidak terlalu ramai.

### Manual test

* Buka Settings.
* Ubah user name dummy.
* Toggle dark mode dummy.
* Pilih sort type.
* Pilih Grid/List.
* Tap Save Preferences dan tampilkan snackbar dummy.

### Risiko

* Agent menambah key baru.
* Dark mode logic dibuat terlalu kompleks.
* Preferred view dibuat Bento/Editorial lagi.

---

# Phase 5 — UI State Implementation

---

## Task 18: Implement Empty States untuk Screen Utama

### Tujuan

Menambahkan empty state untuk screen yang membutuhkan data lokal.

### Scope

Empty state untuk:

* Product Catalog
* Cart
* Manage Product
* Manage Category

### Out of scope

* Belum integrasi database real jika belum siap.
* Belum membuat loading/error state.
* Belum membuat custom illustration kompleks.

### Screen/component terkait

* Home
* Cart
* Manage Product
* Manage Category
* EmptyState

### File yang kemungkinan dibuat

Tidak wajib.

### File yang kemungkinan diubah

* `lib/screens/home/home_screen.dart`
* `lib/screens/cart/cart_screen.dart`
* `lib/screens/manage/manage_product_screen.dart`
* `lib/screens/manage/manage_category_screen.dart`
* `lib/widgets/empty_state.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **State Handling**
* DESIGN_HANDOFF.md bagian **EmptyState**

### Acceptance criteria

* Product empty state muncul saat produk kosong.
* Cart empty state muncul saat cart kosong.
* Manage Product empty state muncul saat produk kosong.
* Manage Category empty state muncul saat kategori kosong.
* Empty state punya title, description, dan CTA relevan.

### Manual test

* Set dummy list kosong.
* Buka tiap screen.
* Pastikan empty state muncul.
* Tap CTA dan pastikan navigasi sesuai.

### Risiko

* Empty state menampilkan fitur out of scope seperti recently viewed.
* CTA mengarah ke screen yang salah.
* Empty state terlalu dekoratif.

---

## Task 19: Implement Loading, Error, Success, dan Validation UI States

### Tujuan

Menyiapkan UI state standar untuk loading, error, success snackbar, dan validation error.

### Scope

* LoadingState untuk product/cart/category/settings.
* ErrorState untuk data gagal dimuat.
* Snackbar sukses/error.
* Validation message pada Product Form dan Category Form.
* Product not found state.

### Out of scope

* Belum wajib integrasi ke semua logic database jika belum ada.
* Tidak membuat skeleton/shimmer kompleks.

### Screen/component terkait

* Home
* Product Detail
* Cart
* Product Form
* Category Form
* Settings
* LoadingState
* ErrorState
* CustomTextField
* SuccessSnackbar

### File yang kemungkinan dibuat

* `lib/widgets/success_snackbar.dart` atau helper snackbar optional
* `lib/widgets/validation_message.dart`

### File yang kemungkinan diubah

* `lib/widgets/loading_state.dart`
* `lib/widgets/error_state.dart`
* `lib/widgets/custom_text_field.dart`
* `lib/screens/manage/product_form_screen.dart`
* `lib/screens/manage/category_form_screen.dart`
* `lib/screens/settings/settings_screen.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Interaction Notes**
* DESIGN_HANDOFF.md bagian **State Handling Final**

### Acceptance criteria

* Loading text/indicator tersedia.
* Error view tersedia.
* Snackbar sukses bisa dipanggil.
* Validation message tampil di bawah field.
* Tidak ada raw technical error tampil ke user.

### Manual test

* Simulasikan loading dengan boolean dummy.
* Simulasikan error dengan boolean dummy.
* Tap Save dengan input kosong.
* Pastikan validation muncul.
* Tap action dummy sukses dan snackbar muncul.

### Risiko

* State handling tersebar tidak konsisten.
* Snackbar text terlalu teknis.
* Loading dibuat terlalu kompleks.

---

# Phase 6 — Data Integration After UI Static

---

## Task 20: Bind Home UI ke Dummy Data Terstruktur / Model Sementara

### Tujuan

Memisahkan UI dari hardcoded widget langsung dengan data model sederhana sebelum integrasi SQLite.

### Scope

* Buat model sederhana jika belum ada.
* Gunakan dummy list structured untuk product dan category.
* ProductCard membaca data dari list.
* CategoryChip membaca data dari list.

### Out of scope

* Belum SQLite real.
* Belum CRUD real.
* Belum SharedPreferences real.

### Screen/component terkait

* Home
* ProductCard
* CategoryChip

### File yang kemungkinan dibuat

* `lib/models/product_model.dart`
* `lib/models/category_model.dart`

### File yang kemungkinan diubah

* `lib/screens/home/home_screen.dart`
* `lib/widgets/product_card.dart`
* `lib/widgets/category_chip.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Data Binding Notes**

### Acceptance criteria

* Home tidak lagi menulis produk langsung di widget secara manual.
* ProductCard menerima data dari object/list.
* CategoryChip menerima data dari object/list.
* Mudah diganti ke SQLite nanti.

### Manual test

* Tambahkan dummy product baru di list.
* Pastikan produk muncul di UI.
* Ubah category dummy.
* Pastikan chip berubah.

### Risiko

* Model tidak sesuai schema Technical Design.
* Dummy data jadi terlalu banyak dan tidak dibersihkan.
* Agent langsung membuat database padahal task masih dummy data.

---

## Task 21: Bind Cart UI ke Dummy Data Terstruktur / Model Sementara

### Tujuan

Menyiapkan struktur data cart agar UI siap dihubungkan ke SQLite.

### Scope

* Buat `CartItemModel` sementara.
* CartItemTile membaca data dari list cart dummy.
* Total dihitung dari dummy data.
* Quantity update masih dummy state.

### Out of scope

* Belum SQLite real.
* Belum addToCart real.
* Belum validasi stok real.

### Screen/component terkait

* Cart
* CartItemTile
* CartSummary

### File yang kemungkinan dibuat

* `lib/models/cart_item_model.dart`

### File yang kemungkinan diubah

* `lib/screens/cart/cart_screen.dart`
* `lib/widgets/cart_item_tile.dart`
* `lib/widgets/cart_summary.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Cart Data Binding**

### Acceptance criteria

* Cart item ditampilkan dari list dummy.
* Total dihitung dari price x quantity.
* Quantity bisa berubah di dummy state.
* Delete item dummy bisa menghapus dari list state.

### Manual test

* Buka Cart.
* Tap plus/minus.
* Pastikan subtotal dan total berubah.
* Delete item.
* Jika list kosong, empty state muncul.

### Risiko

* Quantity update tidak sinkron.
* Total salah.
* Cart dummy sulit diganti ke SQLite.

---

## Task 22: Bind Settings UI ke State Sementara

### Tujuan

Menyiapkan UI Settings agar siap dihubungkan ke SharedPreferences.

### Scope

* State sementara untuk:

  * user_name
  * is_dark_mode
  * product_sort_type
  * preferred_view_mode
  * last_selected_category_id
  * cart_last_opened
* Save button menampilkan snackbar dummy.

### Out of scope

* Belum SharedPreferences real.
* Belum dark theme real.
* Belum persistence.

### Screen/component terkait

* SettingsScreen
* SettingTile
* PreferenceSelect

### File yang kemungkinan dibuat

Tidak wajib.

### File yang kemungkinan diubah

* `lib/screens/settings/settings_screen.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **Settings Data Binding**

### Acceptance criteria

* User bisa mengetik nama.
* User bisa toggle dark mode.
* User bisa pilih sort type.
* User bisa pilih Grid/List.
* Save Preferences menampilkan snackbar.
* Tidak ada key tambahan di luar PRD.

### Manual test

* Buka Settings.
* Ubah semua field.
* Tap Save.
* Snackbar muncul.
* Pastikan tidak error.

### Risiko

* Agent langsung membuat SharedPreferences sebelum waktunya.
* Preferred view opsi melebar.
* Dark mode dibuat terlalu kompleks.

---

# Phase 7 — Static Navigation Flow Completion

---

## Task 23: Connect Static Navigation Antar Screen

### Tujuan

Menghubungkan screen static agar user flow utama bisa diklik dari awal sampai akhir.

### Scope

* Home → Product Detail.
* Product Detail → Home.
* Product Detail Add to Cart → snackbar dummy.
* Cart Continue Browsing → Home.
* Manage → Manage Product.
* Manage → Manage Category.
* Manage Product → Product Form.
* Manage Category → Category Form.
* Form Cancel/Back → list screen.
* Settings tetap di bottom nav.

### Out of scope

* Belum CRUD real.
* Belum SQLite real.
* Belum SharedPreferences real.

### Screen/component terkait

* Semua screen utama.

### File yang kemungkinan dibuat

Tidak wajib.

### File yang kemungkinan diubah

* `lib/navigation/main_navigation.dart`
* `lib/screens/home/home_screen.dart`
* `lib/screens/home/product_detail_screen.dart`
* `lib/screens/cart/cart_screen.dart`
* `lib/screens/manage/manage_screen.dart`
* `lib/screens/manage/manage_product_screen.dart`
* `lib/screens/manage/product_form_screen.dart`
* `lib/screens/manage/manage_category_screen.dart`
* `lib/screens/manage/category_form_screen.dart`

### Design reference

* DESIGN_HANDOFF.md bagian **User Flow Mapping**

### Acceptance criteria

* Semua screen utama bisa dicapai.
* Tidak ada dead-end.
* Back button bekerja.
* Bottom nav tetap bekerja.
* Flow utama bisa didemokan walau masih dummy.

### Manual test

* Mulai dari Home.
* Buka Product Detail.
* Add to Cart dummy.
* Buka Cart.
* Continue Browsing.
* Buka Manage.
* Masuk Manage Product dan Product Form.
* Kembali.
* Masuk Manage Category dan Category Form.
* Buka Settings.

### Risiko

* Navigation stack berantakan.
* Bottom nav muncul di form yang tidak perlu.
* Screen tidak bisa kembali dengan benar.

---

# Phase 8 — Responsive Polish & Final UI Review

---

## Task 24: Responsive Polish dan Safe Area Cleanup

### Tujuan

Memastikan seluruh screen nyaman digunakan di Android mobile dan tidak overflow.

### Scope

* SafeArea.
* Scroll behavior.
* Form scroll saat keyboard muncul.
* Bottom nav tidak menutup konten.
* Padding konsisten.
* Tap target cukup besar.
* Text tidak terpotong.
* Product grid/list tidak overflow.

### Out of scope

* Tidak mengubah fitur.
* Tidak redesign besar.
* Tidak menambah screen.

### Screen/component terkait

* Semua screen.

### File yang kemungkinan dibuat

Tidak wajib.

### File yang kemungkinan diubah

* Semua screen yang memiliki layout issue.
* Widget reusable terkait spacing.

### Design reference

* DESIGN_HANDOFF.md bagian **Layout & Responsive Rules**
* DESIGN_HANDOFF.md bagian **Accessibility Notes**

### Acceptance criteria

* Tidak ada overflow warning.
* Semua screen bisa discroll jika perlu.
* Bottom nav tidak menutup tombol/konten.
* Form tetap usable saat keyboard muncul.
* Button mudah ditekan.
* Font tetap terbaca.

### Manual test

* Jalankan di emulator ukuran kecil.
* Jalankan di emulator ukuran normal.
* Buka semua screen.
* Cek overflow kuning/hitam Flutter.
* Coba input form dengan keyboard.
* Coba scroll screen panjang.

### Risiko

* Perbaikan layout mengubah visual terlalu jauh.
* Button sticky menutupi konten.
* Grid tidak adaptif.

---

## Task 25: Final UI QA Review Before SQLite Integration

### Tujuan

Melakukan review akhir UI static sebelum masuk integrasi SQLite dan SharedPreferences real.

### Scope

* Cek screen sesuai PRD.
* Cek tidak ada fitur out of scope.
* Cek semua flow bisa diklik.
* Cek komponen reusable.
* Cek state UI dasar.
* Cek copywriting.
* Cek design consistency.
* Cek tidak ada checkout/payment/login/wishlist/maps/chart.

### Out of scope

* Belum test SQLite.
* Belum test persistence SharedPreferences.
* Belum final QA functional full.

### Screen/component terkait

* Semua screen dan component.

### File yang kemungkinan dibuat

Tidak wajib.

### File yang kemungkinan diubah

* Minor cleanup di screen/component.

### Design reference

* PRD
* Technical Design
* DESIGN_HANDOFF.md
* AGENTS.md

### Acceptance criteria

* Semua screen final ada.
* UI mengikuti design handoff.
* Tidak ada screen out of scope.
* Tidak ada field data di luar schema.
* Tidak ada wording cloud bucket, checkout, payment, shipping, size, recently viewed.
* UI siap lanjut ke integrasi data.

### Manual test

* Jalankan aplikasi.
* Navigasi seluruh flow.
* Cek setiap screen.
* Catat bug visual.
* Pastikan tidak ada crash.
* Pastikan tidak ada overflow.

### Risiko

* Ada fitur out of scope tersisa.
* Ada component yang tidak reusable.
* Ada screen yang belum punya empty/error state.

---

# Recommended Implementation Order Summary

1. Task 1 — Setup Design Tokens dan Theme Dasar
2. Task 2 — Setup Struktur Folder UI
3. Task 3 — Implement App Entry, App Scaffold, dan Main Navigation
4. Task 4 — Implement Splash Screen Static
5. Task 5 — Implement Reusable Basic Components
6. Task 6 — Implement Product UI Components
7. Task 7 — Implement Cart UI Components
8. Task 8 — Implement Settings UI Components
9. Task 9 — Slice Home / Product Catalog Static UI
10. Task 10 — Slice Product Detail Static UI
11. Task 11 — Slice Cart Static UI
12. Task 12 — Slice Manage Screen Static UI
13. Task 13 — Slice Manage Product Static UI
14. Task 14 — Slice Product Form Static UI
15. Task 15 — Slice Manage Category Static UI
16. Task 16 — Slice Category Form Static UI
17. Task 17 — Slice Settings Static UI
18. Task 18 — Implement Empty States
19. Task 19 — Implement Loading, Error, Success, dan Validation UI States
20. Task 20 — Bind Home UI ke Dummy Data Terstruktur
21. Task 21 — Bind Cart UI ke Dummy Data Terstruktur
22. Task 22 — Bind Settings UI ke State Sementara
23. Task 23 — Connect Static Navigation Antar Screen
24. Task 24 — Responsive Polish dan Safe Area Cleanup
25. Task 25 — Final UI QA Review Before SQLite Integration

---

# Final Notes for AI Agent

Gunakan task breakdown ini secara bertahap. Jangan langsung membuat semua screen dan logic dalam satu prompt.

Prinsip utama:

1. Satu task kecil.
2. Satu tujuan jelas.
3. Satu perubahan terkontrol.
4. Test manual setelah setiap task.
5. Jangan menambahkan fitur di luar PRD.
6. Jangan integrasi SQLite sebelum UI static siap.
7. Jangan integrasi SharedPreferences sebelum UI Settings siap.
8. Jangan membuat backend/API/auth/payment.
9. Pastikan setiap screen bisa dijelaskan saat presentasi Assessment 2.

Target tahap ini adalah:

> UI Flutter static yang rapi, sesuai design handoff, siap dihubungkan ke SQLite dan SharedPreferences.

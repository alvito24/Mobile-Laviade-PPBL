# ANTIGRAVITY_UI_TASK_PROMPTS.md

## Laviade Studio Mobile — Local Catalog & Cart

### Prompt per Task untuk AI Agent IDE + Google Stitch MCP

---

# Prompt Task 1 — Setup Design Tokens dan Theme Dasar

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk melihat referensi design system, color tokens, typography, spacing, button, input, dan card style yang relevan dengan project Laviade Studio Mobile — Local Catalog & Cart.

Task yang dikerjakan:
Task 1: Setup Design Tokens dan Theme Dasar

Tujuan:
Membuat fondasi visual aplikasi agar warna, typography, spacing, button, input, dan card konsisten sejak awal.

Scope:
- Membuat file theme aplikasi.
- Mendefinisikan warna utama.
- Mendefinisikan text style dasar.
- Mendefinisikan radius, spacing, dan style button dasar.
- Menyiapkan light theme.
- Menyiapkan dark theme sederhana jika dibutuhkan untuk is_dark_mode.

Out of scope:
- Belum membuat screen.
- Belum membuat SQLite.
- Belum membuat SharedPreferences logic.
- Belum membuat animasi kompleks.
- Belum menambahkan font custom wajib.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya scope task ini.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru tanpa izin.
8. Ikuti DESIGN_HANDOFF.md secara ketat.
9. Ikuti AGENTS.md.
10. Gunakan token warna dan spacing yang reusable.
11. Jangan membuat UI template generic.
12. Jangan mengubah backend/database.
13. Setelah selesai, jelaskan perubahan file satu per satu.
14. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/core/theme/app_theme.dart
- lib/core/constants/app_colors.dart
- lib/core/constants/app_spacing.dart
- lib/core/constants/app_radius.dart

File yang kemungkinan diubah:
- lib/main.dart
- lib/app.dart

Acceptance criteria:
- Aplikasi memiliki theme dasar.
- Warna utama mengikuti style Laviade: black, off-white, white, gray.
- Primary button default berwarna hitam dengan teks putih.
- Input dan card memiliki border/radius konsisten.
- Tidak ada gradient random atau style berlebihan.

Manual test:
- Jalankan aplikasi.
- Pastikan app tidak error.
- Pastikan theme berhasil dipakai di screen kosong/default.
- Ganti sementara warna background untuk memastikan theme terbaca.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 2 — Setup Struktur Folder UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Task yang dikerjakan:
Task 2: Setup Struktur Folder UI

Tujuan:
Membuat struktur folder awal agar project rapi dan sesuai Technical Design serta AGENTS.md.

Scope:
- Membuat folder screen.
- Membuat folder widget.
- Membuat folder navigation.
- Membuat folder core.
- Membuat file placeholder bila diperlukan.

Out of scope:
- Belum implementasi UI detail.
- Belum membuat database/helper.
- Belum membuat logic CRUD.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file/folder yang akan dibaca.
4. Sebutkan folder/file yang akan dibuat atau diubah.
5. Implementasikan hanya scope task ini.
6. Jangan membuat screen detail di luar task.
7. Jangan menambah dependency baru.
8. Ikuti struktur folder dari TECHNICAL_DESIGN.md dan AGENTS.md.
9. Jangan over-engineering.
10. Setelah selesai, jelaskan perubahan file/folder satu per satu.
11. Berikan langkah manual testing.

File/folder yang kemungkinan dibuat:
- lib/screens/splash/
- lib/screens/home/
- lib/screens/cart/
- lib/screens/manage/
- lib/screens/settings/
- lib/widgets/
- lib/navigation/
- lib/core/

File yang kemungkinan diubah:
- lib/main.dart
- lib/app.dart

Acceptance criteria:
- Struktur folder sesuai rencana.
- Tidak ada folder yang terlalu berlebihan.
- File screen/widget terpisah dengan jelas.
- Project tetap bisa dijalankan.

Manual test:
- Jalankan flutter analyze.
- Pastikan tidak ada import error.
- Pastikan folder mudah dibaca.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 3 — Implement App Entry, App Scaffold, dan Main Navigation

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk melihat referensi bottom navigation final: Home, Cart, Manage, Settings.

Task yang dikerjakan:
Task 3: Implement App Entry, App Scaffold, dan Main Navigation

Tujuan:
Membuat kerangka navigasi utama aplikasi menggunakan bottom navigation.

Scope:
- Membuat MainNavigation.
- Membuat bottom navigation dengan 4 tab: Home, Cart, Manage, Settings.
- Menyiapkan screen placeholder untuk setiap tab.
- Menjaga active tab state.
- Menghubungkan app.dart ke main navigation.

Out of scope:
- Belum membuat isi detail setiap screen.
- Belum integrasi SQLite.
- Belum integrasi SharedPreferences.
- Belum membuat Product Detail/Form navigation.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya scope task ini.
6. Jangan membuat isi screen detail di luar placeholder sederhana.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Jangan membuat UI template generic.
10. Jangan mengubah backend/database.
11. Setelah selesai, jelaskan perubahan file satu per satu.
12. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/navigation/main_navigation.dart
- lib/widgets/app_bottom_nav.dart
- lib/screens/home/home_screen.dart
- lib/screens/cart/cart_screen.dart
- lib/screens/manage/manage_screen.dart
- lib/screens/settings/settings_screen.dart

File yang kemungkinan diubah:
- lib/app.dart
- lib/main.dart

Acceptance criteria:
- Bottom navigation memiliki 4 tab.
- User bisa berpindah Home, Cart, Manage, Settings.
- Active tab terlihat jelas.
- Tidak ada back button pada screen utama tab.
- Tidak ada cart icon tambahan di top bar.

Manual test:
- Jalankan aplikasi.
- Tap setiap tab bottom navigation.
- Pastikan screen berubah sesuai tab.
- Pastikan active state bottom nav berubah.
- Pastikan tidak ada screen crash.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 4 — Implement Splash Screen Static

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk melihat referensi Splash Screen final jika tersedia. Jika tidak tersedia, gunakan aturan dari DESIGN_HANDOFF.md.

Task yang dikerjakan:
Task 4: Implement Splash Screen Static

Tujuan:
Membuat splash screen sederhana sesuai final design.

Scope:
- Membuat screen splash.
- Menampilkan brand name “Laviade Studio”.
- Menampilkan subtitle “Local Catalog & Cart”.
- Setelah delay singkat, masuk ke main navigation.
- Visual monochrome minimal.

Out of scope:
- Tidak ada onboarding.
- Tidak ada login/register.
- Tidak ada animasi kompleks.
- Tidak ada pengecekan auth.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya scope task ini.
6. Jangan membuat onboarding/login/register.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan style theme yang sudah dibuat.
10. Setelah selesai, jelaskan perubahan file satu per satu.
11. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/splash/splash_screen.dart

File yang kemungkinan diubah:
- lib/app.dart
- lib/main.dart

Acceptance criteria:
- Splash tampil saat aplikasi pertama dibuka.
- Brand name dan subtitle muncul jelas.
- Setelah durasi singkat, user diarahkan ke Home.
- Tidak ada login/register.

Manual test:
- Jalankan aplikasi dari awal.
- Pastikan splash muncul.
- Pastikan setelah beberapa detik masuk Home.
- Restart app untuk cek splash muncul kembali.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 5 — Implement Reusable Basic Components

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk melihat referensi button, input, empty state, loading state, dan error state.

Task yang dikerjakan:
Task 5: Implement Reusable Basic Components

Tujuan:
Membuat komponen UI dasar yang akan dipakai di banyak screen.

Scope:
Membuat komponen:
- PrimaryButton
- SecondaryButton
- CustomTextField
- CustomDropdown
- SectionTitle
- EmptyState
- LoadingState
- ErrorState

Out of scope:
- Belum membuat ProductCard.
- Belum membuat CartItemTile.
- Belum membuat database logic.
- Belum membuat validation logic penuh.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya komponen dalam scope task ini.
6. Jangan membuat screen baru.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan theme/tokens yang sudah ada.
10. Jangan membuat UI template generic.
11. Setelah selesai, jelaskan perubahan file satu per satu.
12. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/widgets/primary_button.dart
- lib/widgets/secondary_button.dart
- lib/widgets/custom_text_field.dart
- lib/widgets/custom_dropdown.dart
- lib/widgets/section_title.dart
- lib/widgets/empty_state.dart
- lib/widgets/loading_state.dart
- lib/widgets/error_state.dart

File yang kemungkinan diubah:
- lib/core/theme/app_theme.dart

Acceptance criteria:
- Button reusable bisa menerima label dan onPressed.
- Text field memiliki label dan error text.
- Dropdown bisa menerima list option sederhana.
- EmptyState memiliki title, description, dan CTA optional.
- LoadingState dan ErrorState sederhana, tidak berlebihan.

Manual test:
- Pakai sementara komponen di screen placeholder.
- Cek button bisa ditekan.
- Cek input tampil dengan label.
- Cek empty/loading/error component tampil tanpa overflow.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 6 — Implement Product UI Components

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk melihat referensi ProductCard, ProductManageTile, CategoryChip, dan StockBadge dari desain final.

Task yang dikerjakan:
Task 6: Implement Product UI Components

Tujuan:
Membuat komponen produk yang dipakai di katalog dan manage product.

Scope:
Membuat:
- ProductCard
- ProductListTile
- ProductManageTile
- CategoryChip
- StockBadge

Out of scope:
- Belum membuat Product Detail Screen.
- Belum integrasi SQLite.
- Belum implementasi add/edit/delete logic.
- Belum implementasi filter logic penuh.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya komponen product UI.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Jangan membuat UI template generic.
11. Gunakan data dummy sederhana jika perlu preview.
12. Setelah selesai, jelaskan perubahan file satu per satu.
13. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/widgets/product_card.dart
- lib/widgets/product_list_tile.dart
- lib/widgets/product_manage_tile.dart
- lib/widgets/category_chip.dart
- lib/widgets/stock_badge.dart

File yang kemungkinan diubah:
- lib/screens/home/home_screen.dart
- lib/screens/manage/manage_product_screen.dart

Acceptance criteria:
- ProductCard menampilkan image placeholder, nama, kategori, harga, stok.
- ProductManageTile menampilkan edit dan delete action.
- CategoryChip punya selected dan unselected state.
- StockBadge bisa menampilkan status stok.
- Semua harga tampil dalam format Rupiah.

Manual test:
- Render dummy product di Home.
- Render dummy manage product item.
- Tap ProductCard dan pastikan callback terpanggil.
- Tap edit/delete icon dan pastikan callback terpanggil.
- Ubah selected state CategoryChip dan pastikan visual berubah.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 7 — Implement Cart UI Components

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk melihat referensi CartItemTile, QuantityControl, CartSummary, dan DeleteConfirmationDialog.

Task yang dikerjakan:
Task 7: Implement Cart UI Components

Tujuan:
Membuat komponen reusable untuk cart.

Scope:
Membuat:
- CartItemTile
- QuantityControl
- CartSummary
- DeleteConfirmationDialog

Out of scope:
- Belum integrasi SQLite cart.
- Belum implementasi total calculation dari database.
- Belum implementasi stock validation final.
- Tidak membuat checkout, shipping, payment, order, address, atau size.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya komponen cart.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Jangan membuat UI template generic.
11. Gunakan data dummy sementara jika diperlukan.
12. Setelah selesai, jelaskan perubahan file satu per satu.
13. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/widgets/cart_item_tile.dart
- lib/widgets/quantity_control.dart
- lib/widgets/cart_summary.dart
- lib/widgets/delete_confirmation_dialog.dart

File yang kemungkinan diubah:
- lib/screens/cart/cart_screen.dart

Acceptance criteria:
- CartItemTile menampilkan product name, price, quantity, subtotal, delete action.
- QuantityControl memiliki plus dan minus.
- Minus disabled atau tidak menurunkan quantity di bawah 1.
- DeleteConfirmationDialog bisa dipakai untuk product, category, dan cart item.
- CartSummary menampilkan total harga.

Manual test:
- Render dummy cart item.
- Tap plus dan minus.
- Pastikan quantity tidak bisa turun di bawah 1.
- Tap delete dan tampilkan dialog.
- Tap cancel dan dialog tertutup.
- Tap hapus dan callback terpanggil.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 8 — Implement Settings UI Components

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk melihat referensi Settings / Preferences screen.

Task yang dikerjakan:
Task 8: Implement Settings UI Components

Tujuan:
Membuat komponen reusable untuk halaman settings dan SharedPreferences UI.

Scope:
Membuat:
- SettingTile
- PreferenceSelect
- ProfileNameInput
- SessionInfoCard

Out of scope:
- Belum menyimpan ke SharedPreferences.
- Belum implementasi dark mode logic.
- Belum membaca category terakhir dari local storage.
- Tidak menambah key SharedPreferences baru.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya komponen settings.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Preferred view hanya Grid/List.
10. Jangan membuat account/login/profile kompleks.
11. Gunakan data dummy sementara jika data real belum tersedia.
12. Setelah selesai, jelaskan perubahan file satu per satu.
13. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/widgets/setting_tile.dart
- lib/widgets/preference_select.dart
- lib/widgets/profile_name_input.dart
- lib/widgets/session_info_card.dart

File yang kemungkinan diubah:
- lib/screens/settings/settings_screen.dart

Acceptance criteria:
- User name input tampil jelas.
- Toggle dark mode tampil jelas.
- Select sort type tampil jelas.
- Select preferred view hanya punya opsi Grid/List.
- Session info card tidak terlalu dominan.

Manual test:
- Render settings dengan dummy preference.
- Ubah input user name.
- Toggle dark mode.
- Pilih Grid/List.
- Pastikan visual tidak overflow.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 9 — Slice Home / Product Catalog Static UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect Home / Product Catalog screen final.

Task yang dikerjakan:
Task 9: Slice Home / Product Catalog Static UI

Tujuan:
Membuat tampilan Home sesuai design handoff menggunakan dummy data.

Scope:
- Header Home.
- Greeting user.
- Category chips.
- Sort control.
- View mode toggle.
- Product grid/list dengan dummy data.
- Bottom navigation sudah menggunakan layout utama.

Out of scope:
- Belum integrasi SQLite.
- Belum menyimpan selected category ke SharedPreferences.
- Belum navigation ke real Product Detail.
- Belum sorting real.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya Home static UI.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md secara ketat.
9. Ikuti AGENTS.md.
10. Gunakan komponen reusable yang sudah dibuat.
11. Jangan membuat UI template generic.
12. Jangan mengubah backend/database.
13. Gunakan data dummy sementara.
14. Setelah selesai, jelaskan perubahan file satu per satu.
15. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/home/home_screen.dart

File yang kemungkinan diubah:
- lib/widgets/product_card.dart
- lib/widgets/category_chip.dart
- lib/navigation/main_navigation.dart

Acceptance criteria:
- Home tampil sesuai design.
- ProductCard dummy tampil rapi.
- Category chips tampil horizontal dan scrollable.
- Grid/list toggle terlihat.
- Tidak ada back button di Home.
- Tidak ada cart icon tambahan di top bar.

Manual test:
- Buka aplikasi.
- Masuk Home.
- Scroll product list.
- Tap category chip.
- Tap toggle view mode.
- Pastikan tidak overflow.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 10 — Slice Product Detail Static UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect Product Detail screen final. Abaikan elemen yang tidak sesuai TDD seperti material, fit, care, size, review, atau rating jika masih muncul di desain.

Task yang dikerjakan:
Task 10: Slice Product Detail Static UI

Tujuan:
Membuat tampilan detail produk berdasarkan dummy data.

Scope:
- App bar dengan back button.
- Product image placeholder.
- Product name.
- Category chip.
- Stock badge.
- Price.
- Description.
- Add to Cart button.

Out of scope:
- Belum integrasi produk dari SQLite.
- Belum add to cart real.
- Tidak membuat material/fit/care.
- Tidak membuat size selection.
- Tidak membuat checkout/payment/shipping.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya Product Detail static UI.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Jangan membuat UI template generic.
11. Gunakan data dummy sementara.
12. Setelah selesai, jelaskan perubahan file satu per satu.
13. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/home/product_detail_screen.dart

File yang kemungkinan diubah:
- lib/screens/home/home_screen.dart
- lib/widgets/primary_button.dart

Acceptance criteria:
- Product Detail tampil rapi.
- Tidak ada Material/Fit/Care.
- Tidak ada size.
- Tidak ada checkout/payment/shipping.
- Add to Cart terlihat sebagai primary CTA.
- Back button bekerja.

Manual test:
- Dari Home, sementara tap product dummy menuju Product Detail.
- Tap back dan kembali ke Home.
- Pastikan screen tidak overflow.
- Pastikan Add to Cart callback bisa menampilkan snackbar dummy.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 11 — Slice Cart Static UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect Cart screen final dan empty cart state jika tersedia.

Task yang dikerjakan:
Task 11: Slice Cart Static UI

Tujuan:
Membuat tampilan Cart dengan dummy cart item.

Scope:
- Cart title.
- CartItemTile dummy.
- QuantityControl.
- CartSummary.
- Continue Browsing button.
- Local cart simulation note.
- Delete confirmation dialog.

Out of scope:
- Belum integrasi SQLite.
- Belum total calculation dari database.
- Belum validasi stok.
- Tidak membuat checkout/shipping/payment/order/address/size.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya Cart static UI.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Jangan membuat UI template generic.
11. Jangan mengubah backend/database.
12. Gunakan data dummy sementara.
13. Setelah selesai, jelaskan perubahan file satu per satu.
14. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/cart/cart_screen.dart

File yang kemungkinan diubah:
- lib/widgets/cart_item_tile.dart
- lib/widgets/cart_summary.dart
- lib/widgets/delete_confirmation_dialog.dart

Acceptance criteria:
- Cart menampilkan item dummy.
- Quantity control terlihat dan bisa ditekan secara dummy.
- Total harga tampil.
- Continue Browsing button ada.
- Tidak ada checkout, shipping, payment, order, address.
- Delete confirmation muncul saat delete ditekan.

Manual test:
- Buka Cart.
- Tap plus/minus.
- Tap delete.
- Pastikan dialog muncul.
- Tap Batal.
- Tap Continue Browsing dan kembali ke Home.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 12 — Slice Manage Screen Static UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect Manage Data screen final.

Task yang dikerjakan:
Task 12: Slice Manage Screen Static UI

Tujuan:
Membuat screen Manage sebagai pintu masuk Product CRUD dan Category CRUD.

Scope:
- Header Manage Data.
- Copy “Kelola data lokal untuk demo SQLite.”
- Manage Product card.
- Manage Category card.
- Navigation ke screen placeholder.

Out of scope:
- Belum CRUD real.
- Belum count produk/kategori wajib.
- Tidak membuat dashboard admin/statistik/chart.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya Manage static UI.
6. Jangan membuat screen lain di luar task kecuali placeholder navigation target jika sangat perlu.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Jangan membuat admin dashboard kompleks.
10. Jangan membuat UI template generic.
11. Gunakan data dummy sementara jika diperlukan.
12. Setelah selesai, jelaskan perubahan file satu per satu.
13. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/manage/manage_screen.dart
- lib/widgets/manage_menu_card.dart

File yang kemungkinan diubah:
- lib/navigation/main_navigation.dart

Acceptance criteria:
- Manage screen hanya punya dua menu utama.
- Manage Product card bisa ditekan.
- Manage Category card bisa ditekan.
- Tidak ada admin dashboard kompleks.
- Tidak ada chart/statistik/payment/order.

Manual test:
- Buka tab Manage.
- Tap Manage Product.
- Tap Manage Category.
- Pastikan navigasi menuju placeholder/screen target.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 13 — Slice Manage Product Static UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect Manage Product screen final.

Task yang dikerjakan:
Task 13: Slice Manage Product Static UI

Tujuan:
Membuat UI daftar produk untuk kebutuhan CRUD produk menggunakan dummy data.

Scope:
- App bar dengan back button.
- Title Manage Product.
- ProductManageTile list.
- Add Product FAB/button.
- Edit action.
- Delete action.
- Delete confirmation dialog.

Out of scope:
- Belum integrasi SQLite.
- Belum create/edit/delete real.
- Belum search/filter wajib.
- Belum validasi form.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya Manage Product static UI.
6. Jangan membuat screen lain di luar task kecuali navigation ke Product Form placeholder jika perlu.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Jangan membuat UI template generic.
11. Gunakan data dummy sementara.
12. Setelah selesai, jelaskan perubahan file satu per satu.
13. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/manage/manage_product_screen.dart

File yang kemungkinan diubah:
- lib/widgets/product_manage_tile.dart
- lib/widgets/delete_confirmation_dialog.dart
- lib/screens/manage/manage_screen.dart

Acceptance criteria:
- Manage Product menampilkan list produk dummy.
- Add Product button terlihat jelas.
- Edit icon terlihat.
- Delete icon terlihat.
- Delete confirmation muncul.
- Back button kembali ke Manage.

Manual test:
- Buka Manage Product.
- Tap Add Product dan masuk ke Product Form placeholder.
- Tap edit dan masuk ke Product Form edit placeholder.
- Tap delete dan dialog muncul.
- Tap back dan kembali ke Manage.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 14 — Slice Product Form Static UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect Product Form screen final. Abaikan copy/elemen yang mengarah ke cloud bucket, upload image, material, fit, care, size, atau field tambahan lain.

Task yang dikerjakan:
Task 14: Slice Product Form Static UI

Tujuan:
Membuat UI form tambah/edit produk sesuai schema products.

Scope:
- Product Name field.
- Category Dropdown.
- Price field.
- Stock field.
- Description field.
- Image Asset Name field.
- Save Product button.
- Cancel button.
- Validation message visual.

Out of scope:
- Belum save ke SQLite.
- Belum load kategori dari SQLite.
- Tidak membuat image upload.
- Tidak membuat material/fit/care.
- Tidak membuat size/color field.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya Product Form static UI.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Jangan membuat UI template generic.
11. Gunakan dummy category options sementara.
12. Jangan mengubah backend/database.
13. Setelah selesai, jelaskan perubahan file satu per satu.
14. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/manage/product_form_screen.dart

File yang kemungkinan diubah:
- lib/widgets/custom_text_field.dart
- lib/widgets/custom_dropdown.dart
- lib/screens/manage/manage_product_screen.dart

Acceptance criteria:
- Field sesuai schema Technical Design.
- Image field hanya untuk local asset name.
- Tidak ada copy cloud bucket.
- Tidak ada upload button.
- Tidak ada material/fit/care/size.
- Save dan Cancel button terlihat jelas.

Manual test:
- Buka Product Form dari Add Product.
- Isi field dummy.
- Kosongkan nama produk dan tampilkan validation dummy.
- Tap Cancel dan kembali ke Manage Product.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 15 — Slice Manage Category Static UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect Manage Category screen final, delete confirmation, dan category deletion error.

Task yang dikerjakan:
Task 15: Slice Manage Category Static UI

Tujuan:
Membuat UI list kategori untuk CRUD kategori menggunakan dummy data.

Scope:
- App bar dengan back button.
- Title Manage Category.
- CategoryManageTile list.
- Add Category button/FAB.
- Edit action.
- Delete action.
- Delete confirmation.
- Delete conflict dialog.

Out of scope:
- Belum integrasi SQLite.
- Belum product count wajib.
- Belum real delete conflict check.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya Manage Category static UI.
6. Jangan membuat screen lain di luar task kecuali navigation ke Category Form placeholder jika perlu.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Jangan membuat UI template generic.
11. Gunakan data dummy sementara.
12. Setelah selesai, jelaskan perubahan file satu per satu.
13. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/manage/manage_category_screen.dart
- lib/widgets/category_manage_tile.dart

File yang kemungkinan diubah:
- lib/screens/manage/manage_screen.dart
- lib/widgets/delete_confirmation_dialog.dart

Acceptance criteria:
- List kategori dummy tampil.
- Add Category button terlihat.
- Edit dan delete action tersedia.
- Delete confirmation muncul.
- Conflict error dialog tersedia.
- Back button kembali ke Manage.

Manual test:
- Buka Manage Category.
- Tap Add Category dan masuk ke Category Form.
- Tap edit dan masuk ke Category Form edit.
- Tap delete dan dialog muncul.
- Trigger conflict dummy dan error dialog muncul.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 16 — Slice Category Form Static UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect Category Form screen final.

Task yang dikerjakan:
Task 16: Slice Category Form Static UI

Tujuan:
Membuat UI form tambah/edit kategori.

Scope:
- Category Name field.
- Save Category button.
- Cancel button.
- Validation message.

Out of scope:
- Belum save ke SQLite.
- Belum check duplicate category.
- Belum logic edit real.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya Category Form static UI.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Jangan membuat UI template generic.
11. Setelah selesai, jelaskan perubahan file satu per satu.
12. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/manage/category_form_screen.dart

File yang kemungkinan diubah:
- lib/screens/manage/manage_category_screen.dart

Acceptance criteria:
- Form terlihat sederhana.
- Category Name field punya label.
- Save dan Cancel button ada.
- Validation message “Nama kategori wajib diisi” tersedia.
- Back button kembali ke Manage Category.

Manual test:
- Buka Add Category.
- Kosongkan input dan tampilkan validation dummy.
- Isi nama kategori.
- Tap Cancel dan kembali.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 17 — Slice Settings Static UI

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect Settings / Preferences screen final.

Task yang dikerjakan:
Task 17: Slice Settings Static UI

Tujuan:
Membuat UI Settings untuk 6 key SharedPreferences menggunakan dummy state.

Scope:
- User name input.
- Dark mode toggle.
- Product sort type select.
- Preferred view mode select Grid/List.
- Last selected category info.
- Cart last opened info.
- Save Preferences button.

Out of scope:
- Belum save/load SharedPreferences.
- Belum implement dark theme real.
- Tidak menambah key baru.
- Tidak menambah account/profile kompleks.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya Settings static UI.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Preferred view hanya Grid/List.
11. Jangan membuat UI template generic.
12. Gunakan dummy state sementara.
13. Setelah selesai, jelaskan perubahan file satu per satu.
14. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/screens/settings/settings_screen.dart

File yang kemungkinan diubah:
- lib/widgets/setting_tile.dart
- lib/widgets/preference_select.dart
- lib/widgets/profile_name_input.dart
- lib/widgets/session_info_card.dart

Acceptance criteria:
- Semua 6 key SharedPreferences punya representasi UI.
- Preferred view hanya Grid/List.
- Tidak ada account/login/avatar kompleks.
- Save Preferences button terlihat jelas.
- UI tidak terlalu ramai.

Manual test:
- Buka Settings.
- Ubah user name dummy.
- Toggle dark mode dummy.
- Pilih sort type.
- Pilih Grid/List.
- Tap Save Preferences dan tampilkan snackbar dummy.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 18 — Implement Empty States untuk Screen Utama

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect empty states final jika tersedia: empty product, empty category, empty cart.

Task yang dikerjakan:
Task 18: Implement Empty States untuk Screen Utama

Tujuan:
Menambahkan empty state untuk screen yang membutuhkan data lokal.

Scope:
Empty state untuk:
- Product Catalog
- Cart
- Manage Product
- Manage Category

Out of scope:
- Belum integrasi database real jika belum siap.
- Belum membuat loading/error state.
- Belum membuat custom illustration kompleks.
- Jangan membuat recently viewed.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya empty states.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen EmptyState reusable.
10. Jangan membuat UI template generic.
11. Gunakan dummy empty list untuk testing jika data real belum tersedia.
12. Setelah selesai, jelaskan perubahan file satu per satu.
13. Berikan langkah manual testing.

File yang kemungkinan diubah:
- lib/screens/home/home_screen.dart
- lib/screens/cart/cart_screen.dart
- lib/screens/manage/manage_product_screen.dart
- lib/screens/manage/manage_category_screen.dart
- lib/widgets/empty_state.dart

Acceptance criteria:
- Product empty state muncul saat produk kosong.
- Cart empty state muncul saat cart kosong.
- Manage Product empty state muncul saat produk kosong.
- Manage Category empty state muncul saat kategori kosong.
- Empty state punya title, description, dan CTA relevan.

Manual test:
- Set dummy list kosong.
- Buka tiap screen.
- Pastikan empty state muncul.
- Tap CTA dan pastikan navigasi sesuai.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 19 — Implement Loading, Error, Success, dan Validation UI States

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch untuk inspect loading, error, success snackbar, validation, dan dialog states jika tersedia.

Task yang dikerjakan:
Task 19: Implement Loading, Error, Success, dan Validation UI States

Tujuan:
Menyiapkan UI state standar untuk loading, error, success snackbar, dan validation error.

Scope:
- LoadingState untuk product/cart/category/settings.
- ErrorState untuk data gagal dimuat.
- Snackbar sukses/error.
- Validation message pada Product Form dan Category Form.
- Product not found state.

Out of scope:
- Belum wajib integrasi ke semua logic database jika belum ada.
- Tidak membuat skeleton/shimmer kompleks.
- Tidak menampilkan raw database error ke user.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya UI states.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Gunakan komponen reusable.
10. Jangan membuat UI template generic.
11. Gunakan dummy boolean/state sementara jika logic real belum tersedia.
12. Setelah selesai, jelaskan perubahan file satu per satu.
13. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/widgets/success_snackbar.dart
- lib/widgets/validation_message.dart

File yang kemungkinan diubah:
- lib/widgets/loading_state.dart
- lib/widgets/error_state.dart
- lib/widgets/custom_text_field.dart
- lib/screens/manage/product_form_screen.dart
- lib/screens/manage/category_form_screen.dart
- lib/screens/settings/settings_screen.dart

Acceptance criteria:
- Loading text/indicator tersedia.
- Error view tersedia.
- Snackbar sukses bisa dipanggil.
- Validation message tampil di bawah field.
- Tidak ada raw technical error tampil ke user.

Manual test:
- Simulasikan loading dengan boolean dummy.
- Simulasikan error dengan boolean dummy.
- Tap Save dengan input kosong.
- Pastikan validation muncul.
- Tap action dummy sukses dan snackbar muncul.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 20 — Bind Home UI ke Dummy Data Terstruktur / Model Sementara

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Task yang dikerjakan:
Task 20: Bind Home UI ke Dummy Data Terstruktur / Model Sementara

Tujuan:
Memisahkan UI dari hardcoded widget langsung dengan data model sederhana sebelum integrasi SQLite.

Scope:
- Buat model sederhana jika belum ada.
- Gunakan dummy list structured untuk product dan category.
- ProductCard membaca data dari list.
- CategoryChip membaca data dari list.

Out of scope:
- Belum SQLite real.
- Belum CRUD real.
- Belum SharedPreferences real.
- Jangan membuat database helper di task ini.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya dummy structured data untuk Home.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti schema field dari TECHNICAL_DESIGN.md.
9. Jangan membuat field data di luar schema.
10. Gunakan model sederhana yang mudah diganti SQLite nanti.
11. Setelah selesai, jelaskan perubahan file satu per satu.
12. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/models/product_model.dart
- lib/models/category_model.dart

File yang kemungkinan diubah:
- lib/screens/home/home_screen.dart
- lib/widgets/product_card.dart
- lib/widgets/category_chip.dart

Acceptance criteria:
- Home tidak lagi menulis produk langsung di widget secara manual.
- ProductCard menerima data dari object/list.
- CategoryChip menerima data dari object/list.
- Mudah diganti ke SQLite nanti.

Manual test:
- Tambahkan dummy product baru di list.
- Pastikan produk muncul di UI.
- Ubah category dummy.
- Pastikan chip berubah.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 21 — Bind Cart UI ke Dummy Data Terstruktur / Model Sementara

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Task yang dikerjakan:
Task 21: Bind Cart UI ke Dummy Data Terstruktur / Model Sementara

Tujuan:
Menyiapkan struktur data cart agar UI siap dihubungkan ke SQLite.

Scope:
- Buat CartItemModel sementara.
- CartItemTile membaca data dari list cart dummy.
- Total dihitung dari dummy data.
- Quantity update masih dummy state.

Out of scope:
- Belum SQLite real.
- Belum addToCart real.
- Belum validasi stok real.
- Jangan membuat checkout/payment/order.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya dummy structured data untuk Cart.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti TECHNICAL_DESIGN.md.
9. Jangan membuat field cart di luar schema.
10. Gunakan model sederhana yang mudah diganti SQLite nanti.
11. Setelah selesai, jelaskan perubahan file satu per satu.
12. Berikan langkah manual testing.

File yang kemungkinan dibuat:
- lib/models/cart_item_model.dart

File yang kemungkinan diubah:
- lib/screens/cart/cart_screen.dart
- lib/widgets/cart_item_tile.dart
- lib/widgets/cart_summary.dart

Acceptance criteria:
- Cart item ditampilkan dari list dummy.
- Total dihitung dari price x quantity.
- Quantity bisa berubah di dummy state.
- Delete item dummy bisa menghapus dari list state.

Manual test:
- Buka Cart.
- Tap plus/minus.
- Pastikan subtotal dan total berubah.
- Delete item.
- Jika list kosong, empty state muncul.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 22 — Bind Settings UI ke State Sementara

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Task yang dikerjakan:
Task 22: Bind Settings UI ke State Sementara

Tujuan:
Menyiapkan UI Settings agar siap dihubungkan ke SharedPreferences.

Scope:
- State sementara untuk user_name.
- State sementara untuk is_dark_mode.
- State sementara untuk product_sort_type.
- State sementara untuk preferred_view_mode.
- State sementara untuk last_selected_category_id.
- State sementara untuk cart_last_opened.
- Save button menampilkan snackbar dummy.

Out of scope:
- Belum SharedPreferences real.
- Belum dark theme real.
- Belum persistence.
- Jangan menambah key baru.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya state sementara Settings.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti 6 key SharedPreferences dari TECHNICAL_DESIGN.md.
9. Preferred view hanya Grid/List.
10. Jangan membuat account/profile kompleks.
11. Setelah selesai, jelaskan perubahan file satu per satu.
12. Berikan langkah manual testing.

File yang kemungkinan diubah:
- lib/screens/settings/settings_screen.dart

Acceptance criteria:
- User bisa mengetik nama.
- User bisa toggle dark mode.
- User bisa pilih sort type.
- User bisa pilih Grid/List.
- Save Preferences menampilkan snackbar.
- Tidak ada key tambahan di luar PRD.

Manual test:
- Buka Settings.
- Ubah semua field.
- Tap Save.
- Snackbar muncul.
- Pastikan tidak error.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 23 — Connect Static Navigation Antar Screen

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Task yang dikerjakan:
Task 23: Connect Static Navigation Antar Screen

Tujuan:
Menghubungkan screen static agar user flow utama bisa diklik dari awal sampai akhir.

Scope:
- Home → Product Detail.
- Product Detail → Home.
- Product Detail Add to Cart → snackbar dummy.
- Cart Continue Browsing → Home.
- Manage → Manage Product.
- Manage → Manage Category.
- Manage Product → Product Form.
- Manage Category → Category Form.
- Form Cancel/Back → list screen.
- Settings tetap di bottom nav.

Out of scope:
- Belum CRUD real.
- Belum SQLite real.
- Belum SharedPreferences real.
- Tidak membuat screen baru di luar PRD.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya static navigation flow.
6. Jangan membuat screen lain di luar task.
7. Jangan menambah dependency baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Jangan membuat auth, checkout, payment, order, wishlist, maps, chart.
10. Setelah selesai, jelaskan perubahan file satu per satu.
11. Berikan langkah manual testing.

File yang kemungkinan diubah:
- lib/navigation/main_navigation.dart
- lib/screens/home/home_screen.dart
- lib/screens/home/product_detail_screen.dart
- lib/screens/cart/cart_screen.dart
- lib/screens/manage/manage_screen.dart
- lib/screens/manage/manage_product_screen.dart
- lib/screens/manage/product_form_screen.dart
- lib/screens/manage/manage_category_screen.dart
- lib/screens/manage/category_form_screen.dart

Acceptance criteria:
- Semua screen utama bisa dicapai.
- Tidak ada dead-end.
- Back button bekerja.
- Bottom nav tetap bekerja.
- Flow utama bisa didemokan walau masih dummy.

Manual test:
- Mulai dari Home.
- Buka Product Detail.
- Add to Cart dummy.
- Buka Cart.
- Continue Browsing.
- Buka Manage.
- Masuk Manage Product dan Product Form.
- Kembali.
- Masuk Manage Category dan Category Form.
- Buka Settings.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 24 — Responsive Polish dan Safe Area Cleanup

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Gunakan MCP Google Stitch sebagai visual reference, tapi prioritaskan responsive Flutter layout daripada pixel-perfect kaku.

Task yang dikerjakan:
Task 24: Responsive Polish dan Safe Area Cleanup

Tujuan:
Memastikan seluruh screen nyaman digunakan di Android mobile dan tidak overflow.

Scope:
- SafeArea.
- Scroll behavior.
- Form scroll saat keyboard muncul.
- Bottom nav tidak menutup konten.
- Padding konsisten.
- Tap target cukup besar.
- Text tidak terpotong.
- Product grid/list tidak overflow.

Out of scope:
- Tidak mengubah fitur.
- Tidak redesign besar.
- Tidak menambah screen.
- Tidak menambah dependency.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana implementasi.
2. Analisis struktur project yang relevan.
3. Sebutkan file yang akan dibaca.
4. Sebutkan file yang akan dibuat atau diubah.
5. Implementasikan hanya responsive polish dan safe area cleanup.
6. Jangan mengubah scope fitur.
7. Jangan membuat screen baru.
8. Ikuti DESIGN_HANDOFF.md dan AGENTS.md.
9. Pastikan layout Flutter tidak overflow.
10. Setelah selesai, jelaskan perubahan file satu per satu.
11. Berikan langkah manual testing.

File yang kemungkinan diubah:
- Semua screen yang memiliki layout issue.
- Widget reusable terkait spacing.

Acceptance criteria:
- Tidak ada overflow warning.
- Semua screen bisa discroll jika perlu.
- Bottom nav tidak menutup tombol/konten.
- Form tetap usable saat keyboard muncul.
- Button mudah ditekan.
- Font tetap terbaca.

Manual test:
- Jalankan di emulator ukuran kecil.
- Jalankan di emulator ukuran normal.
- Buka semua screen.
- Cek overflow kuning/hitam Flutter.
- Coba input form dengan keyboard.
- Coba scroll screen panjang.

Mulai dengan menjelaskan rencana implementasi singkat terlebih dahulu.
```

---

# Prompt Task 25 — Final UI QA Review Before SQLite Integration

```text
Baca terlebih dahulu file berikut:
- AGENTS.md
- docs/PRD.md
- docs/TECHNICAL_DESIGN.md
- docs/DESIGN_HANDOFF.md
- docs/UI_IMPLEMENTATION_TASKS.md

Task yang dikerjakan:
Task 25: Final UI QA Review Before SQLite Integration

Tujuan:
Melakukan review akhir UI static sebelum masuk integrasi SQLite dan SharedPreferences real.

Scope:
- Cek screen sesuai PRD.
- Cek tidak ada fitur out of scope.
- Cek semua flow bisa diklik.
- Cek komponen reusable.
- Cek state UI dasar.
- Cek copywriting.
- Cek design consistency.
- Cek tidak ada checkout/payment/login/wishlist/maps/chart.

Out of scope:
- Belum test SQLite.
- Belum test persistence SharedPreferences.
- Belum final QA functional full.
- Tidak membuat fitur baru.

Instruksi kerja:
1. Jangan langsung mengubah kode sebelum menjelaskan rencana review.
2. Analisis struktur project yang relevan.
3. Sebutkan file/screen yang akan dicek.
4. Jangan mengubah kode besar-besaran.
5. Jika ada issue kecil, perbaiki hanya yang berkaitan dengan UI static.
6. Jangan menambah dependency baru.
7. Ikuti PRD, TECHNICAL_DESIGN, DESIGN_HANDOFF, UI_IMPLEMENTATION_TASKS, dan AGENTS.md.
8. Jangan membuat fitur di luar scope.
9. Setelah selesai, jelaskan temuan dan perubahan file satu per satu.
10. Berikan langkah manual testing final.

File yang kemungkinan diubah:
- Minor cleanup di screen/component yang bermasalah.

Acceptance criteria:
- Semua screen final ada.
- UI mengikuti design handoff.
- Tidak ada screen out of scope.
- Tidak ada field data di luar schema.
- Tidak ada wording cloud bucket, checkout, payment, shipping, size, recently viewed.
- UI siap lanjut ke integrasi data.

Manual test:
- Jalankan aplikasi.
- Navigasi seluruh flow.
- Cek setiap screen.
- Catat bug visual.
- Pastikan tidak ada crash.
- Pastikan tidak ada overflow.

Mulai dengan menjelaskan rencana review singkat terlebih dahulu.
```

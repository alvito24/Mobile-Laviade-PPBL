# PRD.md

# Product Requirement Document

## Laviade Studio Mobile — Local Catalog & Cart

---

## 1. Product Overview

### Ringkasan Project

Laviade Studio Mobile — Local Catalog & Cart adalah aplikasi mobile berbasis Flutter yang dibuat untuk menampilkan katalog produk streetwear Laviade dan simulasi belanja sederhana secara lokal. Pada Assessment 2, aplikasi ini tidak menggunakan backend, API, login online, maupun payment gateway. Seluruh data utama seperti produk, kategori, dan cart disimpan menggunakan SQLite, sedangkan preferensi pengguna disimpan menggunakan SharedPreferences.

Project ini merupakan rebuild dari konsep aplikasi mobile e-commerce Laviade sebelumnya, tetapi dengan implementasi yang disesuaikan dengan kebutuhan Assessment 2 mata kuliah PPBL. Fokus utama aplikasi ini adalah membuktikan penerapan penyimpanan lokal menggunakan SQLite dan SharedPreferences dalam bentuk aplikasi katalog dan cart sederhana.

### Masalah Utama yang Diselesaikan

Masalah utama yang diselesaikan adalah kebutuhan untuk membuat aplikasi mobile Laviade yang tetap memiliki konsep e-commerce, tetapi lebih sederhana dan sesuai dengan requirement Assessment 2. Aplikasi ini memungkinkan pengguna melihat katalog produk, mengelola data produk dan kategori, menambahkan produk ke cart, serta menyimpan preferensi aplikasi secara lokal.

Dengan pendekatan local-first, aplikasi dapat berjalan tanpa koneksi server dan tetap dapat menunjukkan implementasi CRUD SQLite serta penyimpanan key-value menggunakan SharedPreferences secara jelas.

### Target User

Target user aplikasi ini terdiri dari:

1. **Customer**
   Pengguna yang melihat katalog produk, membuka detail produk, menambahkan produk ke cart, mengubah quantity cart, dan mengatur preferensi sederhana.

2. **Pengelola Data Demo**
   Pengguna yang mengelola data produk dan kategori untuk kebutuhan demo, pengujian CRUD, dan presentasi Assessment 2.

Catatan: Pada Assessment 2, tidak ada sistem login dan tidak ada pemisahan role berbasis autentikasi. Perbedaan user hanya dibedakan berdasarkan menu atau fungsi yang digunakan di dalam aplikasi.

---

## 2. Background / Latar Belakang

Laviade Studio sebelumnya memiliki konsep aplikasi mobile e-commerce yang terintegrasi dengan backend Laravel. Namun, pada Assessment 2 mata kuliah PPBL, fokus implementasi diarahkan pada penggunaan SQLite dan SharedPreferences. Oleh karena itu, aplikasi perlu dibuat ulang dengan pendekatan yang lebih sederhana, lokal, dan sesuai dengan materi yang diuji.

Jika aplikasi tetap dibuat seperti full e-commerce online, maka scope project akan menjadi terlalu besar. Fitur seperti backend, login online, payment gateway, checkout real, dan integrasi server dapat membuat pengerjaan menjadi tidak realistis untuk Assessment 2. Selain itu, fitur yang terlalu kompleks dapat membuat fokus utama, yaitu implementasi SQLite dan SharedPreferences, menjadi kurang terlihat.

Dengan membuat aplikasi local catalog dan cart sederhana, project tetap mempertahankan identitas Laviade sebagai brand streetwear, tetapi implementasinya lebih realistis untuk dikerjakan oleh tim berisi 3 orang. Aplikasi ini juga dapat menjadi pondasi awal untuk dikembangkan lebih lanjut pada tugas besar.

---

## 3. Goals

### Tujuan Utama Project

Membangun aplikasi mobile Flutter sederhana untuk katalog produk dan simulasi cart Laviade dengan penyimpanan lokal menggunakan SQLite dan SharedPreferences.

### Tujuan dari Sisi User

1. User dapat melihat daftar produk Laviade.
2. User dapat melihat detail produk.
3. User dapat memilih kategori produk.
4. User dapat menambahkan produk ke cart.
5. User dapat mengubah quantity produk di cart.
6. User dapat menghapus produk dari cart.
7. User dapat melihat total harga sementara di cart.
8. User dapat menyimpan preferensi aplikasi seperti nama, tema, kategori terakhir, sorting produk, tampilan katalog, dan waktu terakhir membuka cart.

### Tujuan dari Sisi Sistem / Akademik

1. Sistem dapat menyimpan data produk, kategori, dan cart secara lokal menggunakan SQLite.
2. Sistem dapat menjalankan operasi CRUD pada data produk dan kategori.
3. Sistem dapat menjalankan operasi cart sederhana seperti tambah, baca, ubah quantity, dan hapus item.
4. Sistem dapat menyimpan minimal 6 key SharedPreferences sesuai pembagian anggota kelompok.
5. Sistem dapat berjalan tanpa backend dan tetap mempertahankan konsep aplikasi e-commerce sederhana.
6. Sistem memiliki struktur yang mudah dipahami, mudah dijelaskan saat presentasi, dan tidak over-engineering.
7. Project dapat menjadi pondasi untuk dikembangkan pada tugas besar.

---

## 4. Non-Goals / Out of Scope

Pada Assessment 2, beberapa fitur sengaja tidak dikerjakan agar project tetap realistis dan fokus pada requirement utama.

Fitur yang tidak termasuk scope Assessment 2:

1. Integrasi backend Laravel.
2. Login dan register online.
3. Sistem autentikasi multi-role.
4. Payment gateway.
5. Checkout pembayaran real.
6. Order history.
7. Address management.
8. Wishlist.
9. Maps.
10. Chart.
11. Push notification.
12. Upload gambar produk dari galeri.
13. API online.
14. Sinkronisasi data dengan server.
15. Stock per size.
16. Review dan rating produk.
17. UI animasi kompleks.
18. Arsitektur enterprise yang terlalu berat.

Fitur-fitur tersebut dapat dipertimbangkan pada tahap tugas besar atau pengembangan lanjutan setelah Assessment 2 selesai.

---

## 5. User Roles

### 5.1 Customer

Customer adalah pengguna utama aplikasi yang menggunakan aplikasi untuk melihat katalog produk dan melakukan simulasi belanja melalui cart.

Hak akses Customer:

1. Melihat daftar produk.
2. Melihat detail produk.
3. Memilih kategori produk.
4. Menambahkan produk ke cart.
5. Melihat isi cart.
6. Mengubah quantity produk di cart.
7. Menghapus produk dari cart.
8. Melihat total harga sementara.
9. Mengatur preferensi sederhana di halaman Profile atau Settings.

### 5.2 Pengelola Data Demo

Pengelola Data Demo adalah pengguna yang mengelola data produk dan kategori di dalam aplikasi untuk kebutuhan demo, assessment, dan pengujian CRUD SQLite.

Hak akses Pengelola Data Demo:

1. Melihat daftar kategori.
2. Menambahkan kategori.
3. Mengedit kategori.
4. Menghapus kategori.
5. Melihat daftar produk.
6. Menambahkan produk.
7. Mengedit produk.
8. Menghapus produk.

Catatan: Pengelola Data Demo bukan role autentikasi. Pada Assessment 2, fitur ini hanya disediakan melalui menu pengelolaan data tanpa login khusus.

---

## 6. Core Features

### 6.1 Product Catalog

**Deskripsi Fitur:**
Fitur ini menampilkan daftar produk Laviade yang tersimpan di SQLite. Produk ditampilkan dalam bentuk katalog sederhana yang berisi nama produk, harga, stok, kategori, dan gambar placeholder atau asset lokal.

**User yang Menggunakan:**
Customer

**Tujuan Fitur:**
Memudahkan user melihat produk Laviade yang tersedia di dalam aplikasi.

**Alur Singkat:**
User membuka halaman Home, sistem mengambil data produk dari SQLite, lalu menampilkan produk dalam bentuk list atau grid sederhana.

**Prioritas:**
Must Have

---

### 6.2 Product Detail

**Deskripsi Fitur:**
Fitur ini menampilkan informasi detail dari produk yang dipilih user, seperti nama produk, kategori, harga, stok, deskripsi, dan tombol untuk menambahkan produk ke cart.

**User yang Menggunakan:**
Customer

**Tujuan Fitur:**
Memberikan informasi produk yang lebih jelas sebelum user menambahkan produk ke cart.

**Alur Singkat:**
User memilih salah satu produk dari katalog, lalu sistem menampilkan halaman detail produk.

**Prioritas:**
Should Have

---

### 6.3 Product CRUD

**Deskripsi Fitur:**
Fitur ini memungkinkan Pengelola Data Demo untuk menambahkan, melihat, mengedit, dan menghapus data produk secara lokal menggunakan SQLite.

**User yang Menggunakan:**
Pengelola Data Demo

**Tujuan Fitur:**
Membuktikan implementasi CRUD SQLite pada data produk dan menyediakan data yang akan ditampilkan di katalog.

**Alur Singkat:**
Pengelola Data Demo membuka menu Manage Product, melihat daftar produk, lalu dapat menambah, mengedit, atau menghapus produk.

**Prioritas:**
Must Have

---

### 6.4 Category CRUD

**Deskripsi Fitur:**
Fitur ini memungkinkan Pengelola Data Demo untuk menambahkan, melihat, mengedit, dan menghapus kategori produk secara lokal menggunakan SQLite.

**User yang Menggunakan:**
Pengelola Data Demo

**Tujuan Fitur:**
Membantu mengelompokkan produk berdasarkan kategori dan menunjukkan relasi sederhana antara kategori dan produk.

**Alur Singkat:**
Pengelola Data Demo membuka menu Manage Category, melihat daftar kategori, lalu dapat menambah, mengedit, atau menghapus kategori.

**Prioritas:**
Must Have

**Catatan Aturan:**
Kategori tidak dapat dihapus jika masih digunakan oleh produk.

---

### 6.5 Cart Management

**Deskripsi Fitur:**
Fitur ini memungkinkan Customer untuk menambahkan produk ke cart, melihat isi cart, mengubah quantity produk, menghapus item, dan melihat total harga sementara.

**User yang Menggunakan:**
Customer

**Tujuan Fitur:**
Menyediakan simulasi belanja sederhana yang tetap sesuai dengan konsep aplikasi e-commerce Laviade.

**Alur Singkat:**
User membuka detail produk atau katalog, menambahkan produk ke cart, lalu membuka halaman cart untuk melihat dan mengelola produk yang dipilih.

**Prioritas:**
Must Have

**Catatan Aturan:**
Jika produk yang sama ditambahkan lagi ke cart, sistem akan menambah quantity produk tersebut, bukan membuat item cart baru.

---

### 6.6 SharedPreferences Settings

**Deskripsi Fitur:**
Fitur ini menyimpan preferensi sederhana pengguna menggunakan SharedPreferences. Data yang disimpan berupa key-value dan bukan data utama aplikasi.

**User yang Menggunakan:**
Customer

**Tujuan Fitur:**
Membuktikan penerapan SharedPreferences untuk menyimpan preferensi user secara lokal.

**Alur Singkat:**
User membuka halaman Profile atau Settings, mengubah preferensi, lalu sistem menyimpannya menggunakan SharedPreferences. Saat aplikasi dibuka kembali, preferensi tersebut tetap tersimpan.

**Prioritas:**
Must Have

---

### 6.7 Product Filter

**Deskripsi Fitur:**
Fitur ini memungkinkan user memilih kategori produk di halaman katalog. Kategori terakhir yang dipilih disimpan menggunakan SharedPreferences.

**User yang Menggunakan:**
Customer

**Tujuan Fitur:**
Memudahkan user melihat produk berdasarkan kategori tertentu dan menunjukkan penggunaan SharedPreferences pada katalog.

**Alur Singkat:**
User memilih kategori pada halaman katalog, sistem menampilkan produk berdasarkan kategori tersebut, lalu menyimpan kategori terakhir yang dipilih.

**Prioritas:**
Should Have

---

### 6.8 Simple UI Preferences

**Deskripsi Fitur:**
Fitur ini memungkinkan user mengatur tampilan sederhana seperti light/dark mode dan mode tampilan katalog.

**User yang Menggunakan:**
Customer

**Tujuan Fitur:**
Memberikan personalisasi sederhana tanpa membuat aplikasi terlalu kompleks.

**Alur Singkat:**
User membuka halaman Settings, memilih preferensi tampilan, lalu sistem menyimpan preferensi menggunakan SharedPreferences.

**Prioritas:**
Should Have

---

## 7. User Flow

### 7.1 Customer Flow

1. User membuka aplikasi.
2. Sistem menampilkan halaman Home berisi katalog produk.
3. User memilih kategori produk.
4. Sistem menampilkan produk berdasarkan kategori yang dipilih.
5. User memilih salah satu produk.
6. Sistem menampilkan detail produk.
7. User menambahkan produk ke cart.
8. Sistem menyimpan data cart ke SQLite.
9. User membuka halaman Cart.
10. Sistem menampilkan daftar produk di cart.
11. User dapat mengubah quantity produk.
12. User dapat menghapus produk dari cart.
13. Sistem menghitung dan menampilkan total harga sementara.
14. User membuka halaman Profile atau Settings.
15. User mengubah preferensi sederhana.
16. Sistem menyimpan preferensi menggunakan SharedPreferences.
17. Saat aplikasi dibuka kembali, data SQLite dan SharedPreferences tetap tersimpan.

---

### 7.2 Pengelola Data Demo Flow

1. Pengelola Data Demo membuka menu Manage.
2. Pengelola Data Demo memilih Manage Category.
3. Sistem menampilkan daftar kategori dari SQLite.
4. Pengelola Data Demo dapat menambah, mengedit, atau menghapus kategori.
5. Pengelola Data Demo memilih Manage Product.
6. Sistem menampilkan daftar produk dari SQLite.
7. Pengelola Data Demo dapat menambah, mengedit, atau menghapus produk.
8. Data produk dan kategori yang berhasil disimpan akan muncul di halaman katalog Customer.

---

### 7.3 Preferences Flow

1. User membuka halaman Profile atau Settings.
2. User mengisi atau mengubah nama.
3. User mengubah tema aplikasi.
4. User memilih kategori produk.
5. User memilih sorting atau mode tampilan katalog.
6. Sistem menyimpan data preferensi menggunakan SharedPreferences.
7. User menutup aplikasi.
8. Saat aplikasi dibuka kembali, preferensi yang pernah disimpan tetap digunakan.

---

## 8. Data Requirements

### 8.1 Data yang Disimpan di SQLite

Data utama aplikasi yang disimpan di SQLite:

1. Data kategori.
2. Data produk.
3. Data cart.

### 8.2 Data yang Disimpan di SharedPreferences

Data preferensi user yang disimpan menggunakan SharedPreferences:

1. Nama user.
2. Status tema aplikasi.
3. Kategori terakhir yang dipilih.
4. Jenis sorting produk.
5. Mode tampilan katalog.
6. Waktu terakhir user membuka cart.

---

### 8.3 Entitas SQLite

#### 1. categories

Data kategori digunakan untuk mengelompokkan produk.

Atribut utama:

* id
* name
* created_at
* updated_at

#### 2. products

Data produk digunakan untuk menyimpan informasi produk Laviade.

Atribut utama:

* id
* category_id
* name
* price
* stock
* description
* image_name
* created_at
* updated_at

#### 3. cart_items

Data cart digunakan untuk menyimpan produk yang dipilih user.

Atribut utama:

* id
* product_id
* quantity
* created_at
* updated_at

---

### 8.4 Relasi Antar Data

1. Satu kategori dapat memiliki banyak produk.
2. Satu produk hanya berada dalam satu kategori.
3. Satu produk dapat ditambahkan ke cart.
4. Cart item menyimpan referensi ke produk melalui product_id.
5. SharedPreferences tidak memiliki relasi langsung dengan SQLite karena hanya digunakan untuk menyimpan preferensi sederhana.

---

### 8.5 SharedPreferences Key

Minimal 6 key SharedPreferences yang digunakan:

| No | Key                       | Tipe Data      | Fungsi                                                   |
| -- | ------------------------- | -------------- | -------------------------------------------------------- |
| 1  | user_name                 | String         | Menyimpan nama user                                      |
| 2  | is_dark_mode              | Boolean        | Menyimpan status tema aplikasi                           |
| 3  | last_selected_category_id | Integer/String | Menyimpan kategori terakhir yang dipilih                 |
| 4  | product_sort_type         | String         | Menyimpan jenis sorting produk                           |
| 5  | preferred_view_mode       | String         | Menyimpan mode tampilan katalog, misalnya list atau grid |
| 6  | cart_last_opened          | String         | Menyimpan waktu terakhir halaman cart dibuka             |

---

### 8.6 Pembagian Key SharedPreferences per Anggota

Karena kelompok terdiri dari 3 orang dan setiap orang minimal memiliki 2 key SharedPreferences, pembagian key dirancang sebagai berikut:

| Anggota   | Key 1                     | Key 2             | Tanggung Jawab Umum       |
| --------- | ------------------------- | ----------------- | ------------------------- |
| Anggota 1 | last_selected_category_id | product_sort_type | Katalog produk dan filter |
| Anggota 2 | preferred_view_mode       | cart_last_opened  | Tampilan katalog dan cart |
| Anggota 3 | user_name                 | is_dark_mode      | Profile dan settings      |

---

## 9. Functional Requirements

1. Sistem harus dapat menampilkan daftar produk dari SQLite.
2. Sistem harus dapat menampilkan detail produk.
3. Sistem harus dapat menampilkan daftar kategori dari SQLite.
4. Sistem harus dapat memfilter produk berdasarkan kategori.
5. Sistem harus dapat menambahkan produk baru ke SQLite.
6. Sistem harus dapat mengedit data produk.
7. Sistem harus dapat menghapus data produk.
8. Sistem harus dapat menambahkan kategori baru ke SQLite.
9. Sistem harus dapat mengedit data kategori.
10. Sistem harus dapat menghapus data kategori.
11. Sistem harus dapat mencegah penghapusan kategori yang masih digunakan oleh produk.
12. Sistem harus dapat menambahkan produk ke cart.
13. Sistem harus dapat menampilkan daftar produk di cart.
14. Sistem harus dapat mengubah quantity produk di cart.
15. Sistem harus dapat menghapus item dari cart.
16. Sistem harus dapat menghitung total harga sementara di cart.
17. Sistem harus dapat menambahkan quantity jika produk yang sama ditambahkan lagi ke cart.
18. Sistem harus dapat menyimpan nama user menggunakan SharedPreferences.
19. Sistem harus dapat menyimpan status tema aplikasi menggunakan SharedPreferences.
20. Sistem harus dapat menyimpan kategori terakhir yang dipilih menggunakan SharedPreferences.
21. Sistem harus dapat menyimpan jenis sorting produk menggunakan SharedPreferences.
22. Sistem harus dapat menyimpan mode tampilan katalog menggunakan SharedPreferences.
23. Sistem harus dapat menyimpan waktu terakhir halaman cart dibuka menggunakan SharedPreferences.
24. Sistem harus dapat memuat kembali data SQLite saat aplikasi dibuka ulang.
25. Sistem harus dapat memuat kembali data SharedPreferences saat aplikasi dibuka ulang.
26. Sistem harus dapat menampilkan empty state jika data produk, kategori, atau cart kosong.
27. Sistem harus dapat memberikan validasi sederhana pada form produk dan kategori.
28. Sistem harus dapat mencegah input harga, stok, dan quantity bernilai negatif.
29. Sistem harus dapat menampilkan pesan sederhana ketika data berhasil ditambah, diubah, atau dihapus.

---

## 10. Non-Functional Requirements

### 10.1 Usability

1. Aplikasi harus mudah digunakan oleh user tanpa alur yang rumit.
2. Navigasi utama harus sederhana dan mudah dipahami.
3. Tampilan katalog harus fokus pada informasi produk.
4. Form input produk dan kategori harus jelas.
5. Pesan validasi harus mudah dipahami.

### 10.2 Performance

1. Aplikasi harus dapat menampilkan data lokal dalam waktu yang wajar.
2. Operasi tambah, baca, ubah, dan hapus data SQLite harus berjalan lancar untuk data demo dalam jumlah kecil.
3. Aplikasi tidak boleh menjalankan proses berat yang tidak diperlukan pada Assessment 2.

### 10.3 Security Dasar

1. Aplikasi tidak menyimpan password, token, atau data sensitif.
2. SharedPreferences hanya digunakan untuk menyimpan preferensi sederhana.
3. Input harga, stok, dan quantity harus divalidasi agar tidak bernilai negatif.
4. Input nama produk dan kategori tidak boleh kosong.

### 10.4 Maintainability

1. Struktur project harus mudah dipahami oleh anggota tim.
2. Logic database sebaiknya dipisahkan dari tampilan.
3. File screen, model, database helper, dan widget sebaiknya dipisahkan secara sederhana.
4. Penamaan file, class, dan variabel harus jelas.
5. Project tidak menambahkan library yang tidak dibutuhkan untuk Assessment 2.

### 10.5 Responsiveness

1. Tampilan aplikasi harus nyaman digunakan pada layar mobile.
2. Button, card, dan input harus memiliki ukuran yang mudah ditekan.
3. Layout tidak boleh overflow pada ukuran layar umum Android.
4. Halaman katalog, manage, cart, dan settings harus tetap terbaca dengan baik.

### 10.6 Reliability

1. Data produk, kategori, dan cart harus tetap tersimpan setelah aplikasi ditutup dan dibuka kembali.
2. Data SharedPreferences harus tetap tersimpan setelah aplikasi ditutup dan dibuka kembali.
3. Aplikasi tidak boleh crash saat data kosong.
4. Aplikasi harus tetap dapat digunakan meskipun belum ada produk atau kategori yang tersimpan.

---

## 11. Acceptance Criteria

### 11.1 Kriteria Project Dianggap Selesai

Project Assessment 2 dianggap selesai jika:

1. Aplikasi dapat dijalankan di emulator atau perangkat Android.
2. Aplikasi memiliki katalog produk berbasis data SQLite.
3. Aplikasi memiliki CRUD produk.
4. Aplikasi memiliki CRUD kategori.
5. Aplikasi memiliki cart sederhana.
6. Aplikasi dapat menyimpan dan membaca data dari SQLite.
7. Aplikasi dapat menyimpan minimal 6 key SharedPreferences.
8. Setiap anggota memiliki minimal 2 key SharedPreferences yang dapat dijelaskan.
9. Data SQLite tetap tersimpan setelah aplikasi ditutup dan dibuka kembali.
10. Data SharedPreferences tetap tersimpan setelah aplikasi ditutup dan dibuka kembali.
11. UI sederhana, rapi, dan tidak over-engineering.
12. Setiap fitur utama dapat didemokan dan dijelaskan saat presentasi.

---

### 11.2 Acceptance Criteria Product Catalog

1. User dapat melihat daftar produk.
2. Produk menampilkan nama, harga, stok, kategori, dan gambar sederhana.
3. User dapat memilih kategori produk.
4. Produk dapat ditampilkan berdasarkan kategori yang dipilih.
5. Jika tidak ada produk, sistem menampilkan empty state.

---

### 11.3 Acceptance Criteria Product Detail

1. User dapat membuka detail produk dari katalog.
2. Detail produk menampilkan nama, kategori, harga, stok, dan deskripsi.
3. User dapat menambahkan produk ke cart dari halaman detail.

---

### 11.4 Acceptance Criteria Product CRUD

1. Pengelola Data Demo dapat menambahkan produk baru.
2. Pengelola Data Demo dapat melihat daftar produk.
3. Pengelola Data Demo dapat mengedit produk.
4. Pengelola Data Demo dapat menghapus produk.
5. Produk yang ditambahkan tersimpan di SQLite.
6. Produk yang diedit tampil sesuai perubahan terbaru.
7. Produk yang dihapus tidak muncul lagi di katalog.
8. Sistem melakukan validasi agar nama produk tidak kosong.
9. Sistem melakukan validasi agar harga dan stok tidak bernilai negatif.

---

### 11.5 Acceptance Criteria Category CRUD

1. Pengelola Data Demo dapat menambahkan kategori baru.
2. Pengelola Data Demo dapat melihat daftar kategori.
3. Pengelola Data Demo dapat mengedit kategori.
4. Pengelola Data Demo dapat menghapus kategori.
5. Kategori yang ditambahkan tersimpan di SQLite.
6. Kategori dapat digunakan pada data produk.
7. Kategori tidak dapat dihapus jika masih digunakan oleh produk.
8. Sistem melakukan validasi agar nama kategori tidak kosong.

---

### 11.6 Acceptance Criteria Cart Management

1. User dapat menambahkan produk ke cart.
2. User dapat melihat daftar produk di cart.
3. User dapat mengubah quantity produk di cart.
4. User dapat menghapus item dari cart.
5. Sistem dapat menghitung total harga sementara.
6. Jika produk yang sama ditambahkan lagi, quantity produk bertambah.
7. Cart tetap tersimpan selama belum dihapus oleh user.
8. Sistem menampilkan empty state jika cart kosong.
9. Sistem mencegah quantity bernilai negatif atau nol saat update cart.

---

### 11.7 Acceptance Criteria SharedPreferences

1. Sistem dapat menyimpan key `user_name`.
2. Sistem dapat menyimpan key `is_dark_mode`.
3. Sistem dapat menyimpan key `last_selected_category_id`.
4. Sistem dapat menyimpan key `product_sort_type`.
5. Sistem dapat menyimpan key `preferred_view_mode`.
6. Sistem dapat menyimpan key `cart_last_opened`.
7. Data SharedPreferences tetap tersimpan setelah aplikasi ditutup dan dibuka kembali.
8. Setiap key memiliki fungsi yang dapat didemokan saat presentasi.
9. Setiap anggota dapat menjelaskan minimal 2 key SharedPreferences yang menjadi tanggung jawabnya.

---

## 12. Assumptions

1. Aplikasi dibuat untuk kebutuhan Assessment 2, bukan untuk transaksi real.
2. Aplikasi tidak menggunakan backend.
3. Aplikasi tidak menggunakan login dan register.
4. Aplikasi tidak menggunakan payment gateway.
5. Data produk, kategori, dan cart disimpan secara lokal menggunakan SQLite.
6. Data preferensi disimpan menggunakan SharedPreferences.
7. Gambar produk menggunakan asset lokal atau placeholder sederhana.
8. Jumlah data demo tidak terlalu besar.
9. Aplikasi dikembangkan oleh kelompok berisi 3 orang.
10. Setiap anggota bertanggung jawab pada bagian fitur dan key SharedPreferences tertentu.
11. Role Pengelola Data Demo tidak memerlukan autentikasi.
12. Project Assessment 2 akan menjadi pondasi untuk pengembangan tugas besar.
13. UI dibuat sederhana agar mudah dikembangkan, diuji, dan dijelaskan saat presentasi.

---

## 13. Risks

### 13.1 Risiko Teknis

1. Struktur database SQLite kurang rapi sehingga sulit dikembangkan ke tugas besar.
2. Relasi antara produk, kategori, dan cart tidak dirancang dengan benar.
3. SharedPreferences digunakan untuk data yang seharusnya disimpan di SQLite.
4. Operasi CRUD tidak berjalan konsisten.
5. Data tidak tersimpan setelah aplikasi ditutup karena kesalahan implementasi local storage.
6. Layout mengalami overflow pada ukuran layar tertentu.
7. Validasi input tidak berjalan dengan baik.
8. Cart menghasilkan data duplikat jika produk yang sama ditambahkan berulang kali tanpa pengecekan.

### 13.2 Risiko Scope

1. Project menjadi terlalu besar jika fitur lama dari aplikasi backend dipaksakan masuk.
2. Fitur seperti login, backend, payment, maps, chart, wishlist, dan order history dapat membuat project keluar dari fokus Assessment 2.
3. Terlalu banyak halaman dapat membuat pengerjaan tidak selesai tepat waktu.
4. UI yang terlalu kompleks dapat mengurangi fokus pada SQLite dan SharedPreferences.

### 13.3 Risiko Waktu

1. Tim memiliki waktu terbatas untuk membuat, menguji, dan mempresentasikan aplikasi.
2. Integrasi antar fitur anggota dapat memakan waktu jika pembagian kerja tidak jelas.
3. Debugging SQLite dapat memakan waktu jika struktur database tidak dirancang sejak awal.
4. Perubahan requirement mendadak dapat mengganggu pengerjaan.

### 13.4 Risiko Pemahaman Tim

1. Anggota tim bisa memiliki pemahaman berbeda tentang scope project.
2. Role Pengelola Data Demo dapat disalahpahami sebagai admin dengan login.
3. SharedPreferences dapat disalahpahami sebagai tempat menyimpan seluruh data aplikasi.
4. Cart dapat melebar menjadi checkout real jika tidak dibatasi.
5. Project bisa terlihat terlalu sederhana jika tidak dijelaskan bahwa fokusnya adalah implementasi local storage.

---

## 14. MVP Scope

### 14.1 MVP Assessment 2

Versi MVP Assessment 2 adalah aplikasi mobile Flutter sederhana yang memiliki katalog produk lokal, pengelolaan produk dan kategori, cart sederhana, serta penyimpanan preferensi user.

### 14.2 Fitur MVP

1. Home / Product Catalog.
2. Product Detail sederhana.
3. Product CRUD.
4. Category CRUD.
5. Cart Management.
6. Profile / Settings.
7. SharedPreferences untuk minimal 6 key:

   * user_name
   * is_dark_mode
   * last_selected_category_id
   * product_sort_type
   * preferred_view_mode
   * cart_last_opened

### 14.3 Data MVP

SQLite:

1. categories
2. products
3. cart_items

SharedPreferences:

1. user_name
2. is_dark_mode
3. last_selected_category_id
4. product_sort_type
5. preferred_view_mode
6. cart_last_opened

### 14.4 Batasan MVP

1. Tidak menggunakan backend.
2. Tidak menggunakan login/register.
3. Tidak menggunakan payment gateway.
4. Tidak menggunakan checkout real.
5. Tidak menggunakan order history.
6. Tidak menggunakan address.
7. Tidak menggunakan wishlist.
8. Tidak menggunakan maps.
9. Tidak menggunakan chart.
10. Tidak menggunakan upload gambar.
11. Tidak membuat sistem role berbasis autentikasi.
12. Tidak menggunakan UI animasi kompleks.

### 14.5 Fokus MVP

Fokus MVP adalah memastikan aplikasi dapat:

1. Menyimpan data produk, kategori, dan cart menggunakan SQLite.
2. Menampilkan data dari SQLite ke UI.
3. Melakukan operasi CRUD pada produk dan kategori.
4. Melakukan operasi cart sederhana.
5. Menyimpan dan membaca preferensi user menggunakan SharedPreferences.
6. Menyediakan flow e-commerce sederhana yang mudah dipahami.
7. Menjadi pondasi yang rapi untuk dikembangkan pada tugas besar.

---

## 15. Prioritas Pengerjaan

### Tahap 1 — Database Foundation

1. Membuat tabel categories.
2. Membuat tabel products.
3. Membuat tabel cart_items.
4. Membuat database helper.
5. Menguji operasi insert, read, update, dan delete secara sederhana.

### Tahap 2 — Product & Category Management

1. Membuat halaman Manage Category.
2. Membuat halaman Manage Product.
3. Membuat form input kategori.
4. Membuat form input produk.
5. Menambahkan validasi sederhana.

### Tahap 3 — Product Catalog

1. Menampilkan produk dari SQLite.
2. Menampilkan kategori.
3. Menambahkan filter kategori.
4. Menambahkan detail produk sederhana.

### Tahap 4 — Cart

1. Menambahkan produk ke cart.
2. Menampilkan isi cart.
3. Mengubah quantity cart.
4. Menghapus item cart.
5. Menghitung total harga sementara.

### Tahap 5 — SharedPreferences

1. Membuat halaman Profile atau Settings.
2. Menyimpan key `user_name`.
3. Menyimpan key `is_dark_mode`.
4. Menyimpan key `last_selected_category_id`.
5. Menyimpan key `product_sort_type`.
6. Menyimpan key `preferred_view_mode`.
7. Menyimpan key `cart_last_opened`.
8. Memastikan semua key tetap tersimpan setelah aplikasi dibuka ulang.

### Tahap 6 — UI Cleanup dan Testing

1. Merapikan layout utama.
2. Menambahkan empty state.
3. Menambahkan pesan sukses atau error sederhana.
4. Menguji flow dari katalog sampai cart.
5. Menguji CRUD produk dan kategori.
6. Menguji persistence SQLite.
7. Menguji persistence SharedPreferences.

---

## 16. Pembagian Kerja Tim

### Anggota 1 — Product & Category

Tanggung jawab:

1. Product CRUD.
2. Category CRUD.
3. Product Catalog.
4. Filter kategori.

SharedPreferences:

1. `last_selected_category_id`
2. `product_sort_type`

### Anggota 2 — Cart & Catalog View

Tanggung jawab:

1. Add to cart.
2. Read cart.
3. Update quantity cart.
4. Delete cart item.
5. Total harga sementara.
6. Mode tampilan katalog.

SharedPreferences:

1. `preferred_view_mode`
2. `cart_last_opened`

### Anggota 3 — Profile & Settings

Tanggung jawab:

1. Profile / Settings page.
2. Menyimpan nama user.
3. Theme preference.
4. Load dan save SharedPreferences.
5. UI cleanup sederhana.

SharedPreferences:

1. `user_name`
2. `is_dark_mode`

---

## 17. Final Scope Statement

Assessment 2 Laviade Studio Mobile difokuskan pada pembuatan aplikasi Flutter local-first yang sederhana dan mudah dijelaskan. Aplikasi ini menyediakan katalog produk, pengelolaan produk dan kategori, cart sederhana, serta penyimpanan preferensi pengguna. Data utama disimpan menggunakan SQLite, sedangkan preferensi user disimpan menggunakan SharedPreferences.

Scope final Assessment 2 adalah:

1. Product Catalog.
2. Product Detail sederhana.
3. Product CRUD.
4. Category CRUD.
5. Cart Management.
6. Profile / Settings dengan 6 key SharedPreferences.

Project tidak diarahkan menjadi full e-commerce online pada Assessment 2. Fokus utama adalah memastikan implementasi SQLite dan SharedPreferences berjalan dengan jelas, stabil, dan dapat didemokan oleh seluruh anggota kelompok.

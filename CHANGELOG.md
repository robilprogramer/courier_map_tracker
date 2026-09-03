# Changelog

## 1.0.2

* Fixed: Removed dangling library doc comment in `courier_map_tracker_lib.dart`.
* Improved: Static analysis now passes all linting checks.

## 1.0.1

* Minor bug fixes and stability improvements.
* Improved documentation.

## 1.0.0

Rilis perdana `courier_map_tracker` dengan dokumentasi lengkap dan contoh aplikasi.

### Core Features
* Menambahkan widget `CourierDeliveryMap` untuk menampilkan peta lokasi pelanggan dan kurir.
* Menambahkan marker lokasi kurir secara opsional (marker merah untuk pelanggan, biru untuk kurir).
* Menambahkan tombol navigasi ke lokasi pelanggan melalui aplikasi peta yang tersedia.
* Menambahkan informasi nama pelanggan, alamat, dan detail layanan dalam panel info.
* Menambahkan callback untuk menghubungi pelanggan via tombol telepon.
* Menambahkan callback untuk menandai pengantaran telah selesai.
* Layout responsif dengan panel informasi di bagian bawah peta.

### Documentation & Examples
* Menambahkan dartdoc lengkap untuk semua public API elements (13+ dokumentasi).
* Menambahkan comprehensive README dengan contoh usage, API reference, dan troubleshooting.
* Menambahkan example application lengkap di folder `/example`.
* Menambahkan architecture documentation dan widget hierarchy.
* Menambahkan customization guide dan integration examples.
* Mengaktifkan `public_member_api_docs` lint rule untuk enforce dokumentasi.

### Dependencies
* flutter_map: ^8.3.2 (interactive map widget)
* latlong2: ^0.10.1 (geographic coordinates)
* map_launcher: ^6.0.0 (native map integration)

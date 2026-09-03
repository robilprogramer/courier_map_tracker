# Courier Map Tracker

Widget Flutter untuk menampilkan lokasi pelanggan dan kurir pada peta, lalu
membantu kurir membuka lokasi pelanggan di aplikasi peta yang tersedia pada
perangkat.

Paket ini cocok untuk aplikasi laundry, pengantaran makanan, logistik, dan
aplikasi lain yang memiliki pesanan aktif dengan tujuan pengantaran.

## Fitur

- Menampilkan peta OpenStreetMap.
- Menampilkan marker lokasi pelanggan.
- Menampilkan marker kurir secara opsional.
- Membuka lokasi pelanggan pada aplikasi navigasi yang tersedia.
- Menampilkan nama pelanggan, alamat, dan detail layanan.
- Callback untuk menghubungi pelanggan.
- Callback untuk menandai pengantaran sebagai selesai.
- Layout responsif dengan panel informasi di bagian bawah peta.

## Persyaratan

- Flutter dengan Dart SDK `^3.13.1`.
- Aplikasi Android atau iOS dengan aplikasi peta yang dapat digunakan untuk
  navigasi.
- Koneksi internet untuk memuat tile OpenStreetMap.

## Instalasi

Tambahkan paket ke `pubspec.yaml` aplikasi Anda:

```yaml
dependencies:
  courier_map_tracker: ^0.0.1
```

Kemudian jalankan:

```bash
flutter pub get
```

Untuk memakai versi lokal saat mengembangkan paket ini, gunakan:

```yaml
dependencies:
  courier_map_tracker:
    path: ../courier_map_tracker
```

## Pemakaian dasar

Import library, lalu tempatkan `CourierDeliveryMap` sebagai halaman atau
bagian dari navigation stack aplikasi Anda:

```dart
import 'package:flutter/material.dart';
import 'package:courier_map_tracker/courier_map_tracker.dart';

class ActiveOrderPage extends StatelessWidget {
  const ActiveOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CourierDeliveryMap(
      customerLat: -6.200000,
      customerLng: 106.816666,
      customerName: 'Robil Dev',
      customerAddress:
          'Jl. Kebon Jeruk Raya No. 12, Jakarta Barat',
      serviceDetail: 'Laundry Kiloan 5kg + Setrika',
      onDeliveryCompleted: () {
        // Simpan status pengantaran ke database atau API Anda.
        Navigator.pop(context);
      },
    );
  }
}
```

## Contoh lengkap

Contoh berikut menampilkan posisi kurir dan menambahkan aksi untuk menghubungi
pelanggan:

```dart
import 'package:flutter/material.dart';
import 'package:courier_map_tracker/courier_map_tracker.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesanan Aktif')),
      body: CourierDeliveryMap(
        customerLat: -6.200000,
        customerLng: 106.816666,
        courierLat: -6.210000,
        courierLng: 106.820000,
        customerName: 'Robil Dev',
        customerAddress:
            'Jl. Kebon Jeruk Raya No. 12, RT 01/RW 03, Jakarta Barat',
        serviceDetail: 'Laundry Kiloan 5kg + Setrika',
        destinationTitle: 'Tujuan Pengantaran',
        onContactCustomer: () {
          // Hubungkan dengan url_launcher atau fitur telepon aplikasi Anda.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Menghubungi pelanggan...')),
          );
        },
        onDeliveryCompleted: () {
          showDialog<void>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Selesaikan pengantaran?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    // Update status pesanan di aplikasi Anda.
                  },
                  child: const Text('Ya, selesai'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
```

## API `CourierDeliveryMap`

| Parameter | Tipe | Wajib | Keterangan |
| --- | --- | :---: | --- |
| `customerLat` | `double` | Ya | Latitude lokasi pelanggan. |
| `customerLng` | `double` | Ya | Longitude lokasi pelanggan. |
| `customerName` | `String` | Ya | Nama yang ditampilkan pada panel. |
| `customerAddress` | `String` | Ya | Alamat tujuan pengantaran. |
| `serviceDetail` | `String` | Ya | Detail layanan atau pesanan. |
| `onDeliveryCompleted` | `VoidCallback` | Ya | Dipanggil saat tombol selesai ditekan. |
| `courierLat` | `double?` | Tidak | Latitude kurir. Jika tidak diisi, marker kurir tidak ditampilkan. |
| `courierLng` | `double?` | Tidak | Longitude kurir. Harus diisi bersama `courierLat`. |
| `destinationTitle` | `String` | Tidak | Judul marker navigasi. Default: `Lokasi Pelanggan`. |
| `onContactCustomer` | `VoidCallback?` | Tidak | Aksi tombol telepon. Jika `null`, tombol tidak ditampilkan. |

### Koordinat

Gunakan sistem koordinat WGS84 dalam derajat desimal. Nilai latitude berada
di antara `-90` dan `90`, sedangkan longitude berada di antara `-180` dan
`180`. Contoh Jakarta:

```dart
customerLat: -6.200000,
customerLng: 106.816666,
```

Pastikan `courierLat` dan `courierLng` berasal dari pembaruan lokasi terbaru.
Widget ini hanya menampilkan posisi yang diberikan; pelacakan lokasi dan
penyimpanan data tetap menjadi tanggung jawab aplikasi Anda.

## Navigasi

Ketika tombol **Navigasi** ditekan, paket menggunakan `map_launcher` untuk
membuka lokasi pelanggan pada aplikasi peta yang tersedia. Jika tidak ada
aplikasi peta yang cocok atau pembukaan navigasi gagal, error ditangani oleh
paket dan dicatat melalui debug log.

Untuk pengalaman yang lebih baik, uji fitur ini pada perangkat fisik dengan
Google Maps, Apple Maps, atau aplikasi peta lain yang terpasang. Emulator dapat
tidak memiliki aplikasi peta yang diperlukan.

## Peta dan OpenStreetMap

Tile peta diambil dari OpenStreetMap melalui URL tile publik. Pastikan aplikasi
Anda memiliki koneksi internet dan tetap mematuhi [kebijakan penggunaan tile
OpenStreetMap](https://operations.osmfoundation.org/policies/tiles/). Untuk
aplikasi produksi dengan trafik tinggi, pertimbangkan provider tile yang
memiliki SLA dan kebijakan penggunaan yang sesuai.

## Pengembangan

Jalankan pemeriksaan kode dan test dari root paket:

```bash
flutter analyze
flutter test
```

## Kontribusi dan dukungan

Bug, usulan fitur, dan pull request dapat diajukan melalui issue tracker
repository proyek. Sertakan versi Flutter, platform perangkat, langkah untuk
mereproduksi masalah, dan pesan error yang relevan.

## Lisensi

Lihat file [LICENSE](LICENSE) untuk informasi lisensi paket.

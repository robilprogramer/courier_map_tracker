# Courier Map Tracker

A comprehensive Flutter package for displaying dynamic courier delivery route tracking with interactive map navigation.

![Flutter Badge](https://img.shields.io/badge/Flutter-3.13+-blue)
![Dart Badge](https://img.shields.io/badge/Dart-3.13+-blue)
![License Badge](https://img.shields.io/badge/License-MIT-green)

## Overview

**courier_map_tracker** is a production-ready Flutter widget package that enables real-time courier delivery tracking with an interactive map interface. Perfect for delivery applications, food delivery platforms, laundry services, and any business requiring live order tracking.

Paket ini cocok untuk aplikasi laundry, pengantaran makanan, logistik, dan aplikasi lain yang memiliki pesanan aktif dengan tujuan pengantaran.

### Key Features / Fitur Utama

✨ **Interactive Map Display / Tampilan Peta Interaktif**
- Real-time map rendering using OpenStreetMap tiles
- Smooth zoom and pan controls
- Responsive to different screen sizes
- Menampilkan peta OpenStreetMap secara real-time dengan kontrol zoom dan pan

📍 **Dual Location Markers / Marker Lokasi Ganda**
- Red marker for customer delivery location
- Blue marker for courier's current position
- Clear visual distinction between locations
- Marker merah untuk lokasi pelanggan, marker biru untuk posisi kurir

👤 **Customer Information Panel / Panel Informasi Pelanggan**
- Customer name and avatar
- Service/order details display
- Full delivery address with icon
- Clean, modern UI with rounded corners
- Menampilkan nama pelanggan, detail layanan, dan alamat lengkap

📞 **Communication Features / Fitur Komunikasi**
- Direct phone button to contact customer
- Customizable contact callback
- Optional callback handling
- Tombol untuk menghubungi pelanggan

🎯 **Action Buttons / Tombol Aksi**
- Navigation button for GPS integration
- Delivery completion confirmation
- Customizable action callbacks
- Dialog-based confirmation workflow
- Tombol navigasi dan penyelesaian pengiriman

## Installation / Instalasi

Add `courier_map_tracker` to your `pubspec.yaml`:

```yaml
dependencies:
  courier_map_tracker: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Platform Support

| Platform | Support | Minimum Version |
|----------|---------|-----------------|
| Android  | ✅      | API 21          |
| iOS      | ✅      | 12.0            |
| Web      | ⚠️      | Supported       |
| Windows  | ⚠️      | Experimental    |
| macOS    | ⚠️      | Experimental    |
| Linux    | ⚠️      | Experimental    |

## Quick Start / Mulai Cepat

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:courier_map_tracker/courier_map_tracker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Tracker',
      home: Scaffold(
        appBar: AppBar(title: const Text('Active Delivery')),
        body: CourierDeliveryMap(
          customerLat: -6.200000,
          customerLng: 106.816666,
          customerName: 'John Doe',
          customerAddress: '123 Main Street, Jakarta',
          serviceDetail: 'Laundry Service 5kg',
          onDeliveryCompleted: () {
            print('Delivery completed!');
          },
        ),
      ),
    );
  }
}
```

### Advanced Usage with Courier Location

```dart
CourierDeliveryMap(
  // Customer location (required)
  customerLat: -6.200000,
  customerLng: 106.816666,
  
  // Courier current location (optional)
  courierLat: -6.195000,
  courierLng: 106.820000,
  
  // Customer details (required)
  customerName: 'Robil Dev',
  customerAddress: 'Jl. Kebon Jeruk Raya No. 12, Jakarta Barat',
  serviceDetail: 'Laundry Kiloan 5kg + Setrika',
  
  // Location marker title (optional, default: "Lokasi Pelanggan")
  destinationTitle: 'Customer Address',
  
  // Callbacks (onDeliveryCompleted required)
  onDeliveryCompleted: () {
    // Update delivery status in database
    // Navigate to next order
    // Show completion screen
  },
  
  onContactCustomer: () {
    // Integrate with url_launcher to make calls
    // launch('tel:+62812345678');
  },
)
```

## API Reference

### CourierDeliveryMap

A stateless widget that displays a real-time courier delivery tracking interface.

#### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `customerLat` | `double` | Customer's delivery location latitude |
| `customerLng` | `double` | Customer's delivery location longitude |
| `customerName` | `String` | Name of the customer receiving delivery |
| `customerAddress` | `String` | Full delivery address |
| `serviceDetail` | `String` | Description of service/items being delivered |
| `onDeliveryCompleted` | `VoidCallback` | Callback when delivery completion button is pressed |

#### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `courierLat` | `double?` | `null` | Courier's current latitude |
| `courierLng` | `double?` | `null` | Courier's current longitude |
| `onContactCustomer` | `VoidCallback?` | `null` | Callback when contact button is pressed |
| `destinationTitle` | `String` | `"Lokasi Pelanggan"` | Label for customer location marker |

## Dependencies

```yaml
flutter_map: ^8.3.2        # Interactive map widget
latlong2: ^0.10.1          # Geographic coordinates
map_launcher: ^6.0.0       # Native map application integration
```

## Examples / Contoh

See the [example](./example) directory for a complete working application demonstrating all features.

### Running the Example

```bash
cd example
flutter pub get
flutter run
```

## Customization / Kustomisasi

### Modifying Colors and Styling

To customize marker colors, modify the icon colors in the `MarkerLayer`:

```dart
// Red marker for customer (default)
child: const Icon(
  Icons.location_on,
  color: Colors.red,    // Change this
  size: 50,
)

// Blue marker for courier (default)
child: const Icon(
  Icons.delivery_dining,
  color: Colors.blue,   // Change this
  size: 50,
)
```

### Custom Map Tiles

Replace the OpenStreetMap URL in the `TileLayer`:

```dart
TileLayer(
  urlTemplate: 'https://your-tile-provider.com/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.your_app.package',
)
```

### Integration with url_launcher

To enable actual phone calls:

```dart
import 'package:url_launcher/url_launcher.dart';

CourierDeliveryMap(
  // ... other parameters
  onContactCustomer: () async {
    final phoneNumber = 'tel:+62812345678';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    }
  },
)
```

## Architecture

### Widget Hierarchy

```
CourierDeliveryMap (StatelessWidget)
├── Scaffold
│   └── Stack
│       ├── FlutterMap
│       │   ├── TileLayer (OpenStreetMap)
│       │   └── MarkerLayer
│       │       ├── Customer Marker (Red)
│       │       └── Courier Marker (Blue, if provided)
│       └── Align (Bottom)
│           └── SafeArea
│               └── Container (Info Panel)
│                   ├── Customer Info Row
│                   ├── Divider
│                   ├── Address Row
│                   └── Action Buttons Row
│                       ├── Navigation Button
│                       └── Completion Button
```

## Performance Considerations

- **Map Rendering**: Uses efficient tile-based rendering
- **Marker Updates**: Rebuild only when coordinates change
- **Memory Usage**: Optimized marker layer with conditional rendering
- **Network**: Uses OpenStreetMap CDN with configurable user agent

## Troubleshooting / Pemecahan Masalah

### Map Not Displaying

Ensure you have internet connectivity for loading map tiles and have proper permissions set:

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSLocalNetworkUsageDescription</key>
<string>This app needs access to your local network</string>
<key>NSBonjourServices</key>
<array>
  <string>_http._tcp</string>
</array>
```

### Courier Marker Not Showing

Ensure both `courierLat` and `courierLng` are provided. If either is `null`, the courier marker won't render.

```dart
// Correct - both provided
courierLat: -6.195000,
courierLng: 106.820000,

// Incorrect - courier won't show
courierLat: -6.195000,
courierLng: null,
```

### Navigation Not Working

The `map_launcher` package requires native map apps to be installed. Install a map application like Google Maps or Apple Maps on your device.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For issues, questions, or suggestions, please create an issue on the [GitHub repository](https://github.com/robilprogramer/courier_map_tracker).

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and updates.

## Related Packages

- [flutter_map](https://pub.dev/packages/flutter_map) - Interactive map widget
- [map_launcher](https://pub.dev/packages/map_launcher) - Native map integration
- [latlong2](https://pub.dev/packages/latlong2) - Geographic coordinates
- [url_launcher](https://pub.dev/packages/url_launcher) - URL and phone launching

---

**Made with ❤️ for the Flutter community**

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

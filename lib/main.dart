import 'package:flutter/material.dart';
import 'package:courier_map_tracker/courier_map_tracker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courier Map Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ActiveOrderPage(),
    );
  }
}

class ActiveOrderPage extends StatelessWidget {
  const ActiveOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pesanan Aktif")),
      body: CourierDeliveryMap(
        customerLat: -6.200000,
        customerLng: 106.816666,
        customerName: "Robil Dev",
        customerAddress:
            "Jl. Kebon Jeruk Raya No. 12, RT 01/RW 03, Jakarta Barat",
        serviceDetail: "Laundry Kiloan 5kg + Setrika",
        onContactCustomer: () {
          // Logika panggil telepon (bisa gunakan url_launcher)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Memanggil pelanggan...")),
          );
        },
        onDeliveryCompleted: () {
          // Logika update database dari aplikasi utama
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("Selesaikan Pesanan?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx); // Tutup dialog
                    Navigator.pop(context); // Kembali ke menu utama
                  },
                  child: const Text("Ya, Selesai"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

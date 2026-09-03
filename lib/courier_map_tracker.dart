library courier_map_tracker;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// Gunakan alias 'ml' agar tidak ada bentrok nama dengan file/class lokal Anda
import 'package:map_launcher/map_launcher.dart' as ml;

class CourierDeliveryMap extends StatelessWidget {
  final double customerLat;
  final double customerLng;
  final double? courierLat;
  final double? courierLng;

  final String customerName;
  final String customerAddress;
  final String serviceDetail;
  final String destinationTitle;

  final VoidCallback onDeliveryCompleted;
  final VoidCallback? onContactCustomer;

  const CourierDeliveryMap({
    super.key,
    required this.customerLat,
    required this.customerLng,
    required this.customerName,
    required this.customerAddress,
    required this.serviceDetail,
    required this.onDeliveryCompleted,
    this.destinationTitle = "Lokasi Pelanggan",
    this.courierLat,
    this.courierLng,
    this.onContactCustomer,
  });

  /// map_launcher ^6.0.0 mengganti total API-nya:
  /// - `MapLauncher.installedMaps` + `AvailableMap.showMarker(...)` (gaya lama)
  ///   digantikan oleh `MapLauncher.marker(...).show(...)`.
  /// - Jika parameter `map:` tidak diisi, plugin otomatis memilih aplikasi
  ///   peta terbaik yang tersedia di perangkat (mirip perilaku kode lama
  ///   yang mengambil `installedMaps.first`).
  Future<void> _openNavigation() async {
    try {
      final marker = ml.MapLauncher.marker(
        ml.LocationCoords(customerLat, customerLng, title: destinationTitle),
      );
      await marker.show();
    } on ml.MapLaunchException catch (e) {
      debugPrint("Gagal membuka aplikasi navigasi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lapisan Peta
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(customerLat, customerLng),
              initialZoom: 16.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.courier_map_tracker.pkg',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(customerLat, customerLng),
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                  if (courierLat != null && courierLng != null)
                    Marker(
                      point: LatLng(courierLat!, courierLng!),
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.delivery_dining,
                        color: Colors.blue,
                        size: 50,
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Lapisan Panel Bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          child: const Icon(Icons.person, color: Colors.blue),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customerName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                serviceDetail,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        if (onContactCustomer != null)
                          IconButton(
                            icon: const Icon(Icons.phone, color: Colors.green),
                            onPressed: onContactCustomer,
                          ),
                      ],
                    ),
                    const Divider(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.place, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            customerAddress,
                            style: const TextStyle(fontSize: 14, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _openNavigation,
                            icon: const Icon(Icons.navigation),
                            label: const Text("Navigasi"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            onPressed: onDeliveryCompleted,
                            child: const Text(
                              "Selesaikan",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

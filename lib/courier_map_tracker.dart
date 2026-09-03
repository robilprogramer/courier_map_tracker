/// A Flutter package for displaying dynamic courier delivery route tracking with interactive map navigation.
///
/// This package provides a comprehensive widget for real-time courier delivery tracking,
/// displaying customer locations, courier positions, and service details on an interactive map.
/// It integrates with Flutter Map for mapping and Map Launcher for external navigation.
///
/// ## Features
/// - Display customer and courier locations on an interactive map
/// - Real-time courier tracking with marker updates
/// - Direct navigation integration using native map applications
/// - Customer contact functionality with phone button
/// - Delivery completion confirmation workflow
/// - Responsive design with rounded UI panels
/// - Support for various service types and delivery details
///
/// ## Usage
/// ```dart
/// CourierDeliveryMap(
///   customerLat: -6.200000,
///   customerLng: 106.816666,
///   customerName: "John Doe",
///   customerAddress: "123 Main St, Jakarta",
///   serviceDetail: "Laundry 5kg",
///   onDeliveryCompleted: () => print("Delivery completed"),
/// )
/// ```
///
/// See [CourierDeliveryMap] for more details and complete API documentation.
library courier_map_tracker;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// Gunakan alias 'ml' agar tidak ada bentrok nama dengan file/class lokal Anda
import 'package:map_launcher/map_launcher.dart' as ml;

/// A widget that displays a real-time courier delivery tracking map.
///
/// [CourierDeliveryMap] is a stateless widget that shows an interactive map
/// with customer and courier locations, along with delivery details and action buttons.
/// It uses OpenStreetMap tiles via Flutter Map and supports direct navigation
/// through native map applications via Map Launcher.
///
/// The widget displays:
/// - An interactive map centered on the customer location
/// - A red marker for the customer's delivery address
/// - A blue marker for the courier's current location (if provided)
/// - A bottom panel with customer details, service information, and action buttons
///
/// ## Parameters
/// - [customerLat], [customerLng]: Required customer location coordinates
/// - [courierLat], [courierLng]: Optional courier current location coordinates
/// - [customerName]: The name of the customer receiving the delivery
/// - [customerAddress]: The full delivery address
/// - [serviceDetail]: Description of the service/items being delivered
/// - [onDeliveryCompleted]: Callback triggered when delivery is marked as complete
/// - [onContactCustomer]: Optional callback for contacting the customer
/// - [destinationTitle]: Label for the customer location marker (default: "Lokasi Pelanggan")
///
/// ## Example
/// ```dart
/// CourierDeliveryMap(
///   customerLat: -6.200000,
///   customerLng: 106.816666,
///   courierLat: -6.201000,
///   courierLng: 106.817000,
///   customerName: "Robil Dev",
///   customerAddress: "Jl. Kebon Jeruk Raya No. 12, Jakarta Barat",
///   serviceDetail: "Laundry Kiloan 5kg + Setrika",
///   onDeliveryCompleted: () {
///     print("Delivery completed!");
///   },
///   onContactCustomer: () {
///     print("Calling customer...");
///   },
/// )
/// ```
class CourierDeliveryMap extends StatelessWidget {
  /// The latitude coordinate of the customer's delivery location.
  final double customerLat;

  /// The longitude coordinate of the customer's delivery location.
  final double customerLng;

  /// The latitude coordinate of the courier's current location.
  ///
  /// If null, the courier marker will not be displayed on the map.
  final double? courierLat;

  /// The longitude coordinate of the courier's current location.
  ///
  /// If null, the courier marker will not be displayed on the map.
  final double? courierLng;

  /// The name of the customer receiving the delivery.
  final String customerName;

  /// The full delivery address of the customer.
  final String customerAddress;

  /// Description of the service or items being delivered.
  ///
  /// Example: "Laundry Kiloan 5kg + Setrika", "Express Delivery", etc.
  final String serviceDetail;

  /// The title/label for the customer location marker on the map.
  ///
  /// Defaults to "Lokasi Pelanggan" (Customer Location in Indonesian).
  final String destinationTitle;

  /// Callback triggered when the "Selesaikan" (Complete) button is pressed.
  ///
  /// This callback should handle delivery completion logic, such as updating
  /// the delivery status in the backend database or closing the delivery screen.
  final VoidCallback onDeliveryCompleted;

  /// Optional callback triggered when the phone icon button is pressed.
  ///
  /// If null, the phone button will not be displayed in the UI.
  /// This callback typically handles initiating a call to the customer.
  final VoidCallback? onContactCustomer;

  /// Creates a [CourierDeliveryMap] widget.
  ///
  /// The [customerLat], [customerLng], [customerName], [customerAddress],
  /// [serviceDetail], and [onDeliveryCompleted] parameters are required.
  /// All other parameters are optional.
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

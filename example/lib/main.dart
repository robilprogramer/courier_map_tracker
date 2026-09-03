import 'package:flutter/material.dart';
import 'package:courier_map_tracker/courier_map_tracker.dart';

void main() {
  runApp(const CourierMapTrackerExample());
}

/// Example application demonstrating the CourierDeliveryMap widget.
class CourierMapTrackerExample extends StatelessWidget {
  const CourierMapTrackerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courier Map Tracker',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ExamplePage(),
    );
  }
}

/// Example page showing a sample delivery tracking scenario.
///
/// This page demonstrates the [CourierDeliveryMap] widget with realistic
/// delivery information for a laundry service order.
class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  bool _showCourierLocation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Tracking Example'),
        elevation: 0,
      ),
      body: _showCourierLocation
          ? CourierDeliveryMap(
              customerLat: -6.200000,
              customerLng: 106.816666,
              courierLat: -6.195000,
              courierLng: 106.820000,
              customerName: 'Robil Dev',
              customerAddress:
                  'Jl. Kebon Jeruk Raya No. 12, RT 01/RW 03, Jakarta Barat',
              serviceDetail: 'Laundry Kiloan 5kg + Setrika',
              destinationTitle: 'Lokasi Pelanggan',
              onContactCustomer: () {
                _showSnackBar('Panggilan ke pelanggan dijalankan...');
              },
              onDeliveryCompleted: () {
                _showDeliveryCompletionDialog();
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Pengiriman Selesai',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Icon(Icons.check_circle, color: Colors.green, size: 80),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showCourierLocation = true;
                      });
                    },
                    child: const Text('Kembali'),
                  ),
                ],
              ),
            ),
    );
  }

  /// Shows a confirmation dialog for delivery completion.
  void _showDeliveryCompletionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Selesaikan Pesanan?'),
        content: const Text(
          'Apakah Anda yakin ingin menyelesaikan pengiriman ini?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _showCourierLocation = false;
              });
              _showSnackBar('Pesanan berhasil diselesaikan');
            },
            child: const Text('Ya, Selesai'),
          ),
        ],
      ),
    );
  }

  /// Helper method to show a snackbar message.
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

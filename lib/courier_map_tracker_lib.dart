/// This is the main library file that exports all public APIs.
///
/// To use this package, import it as:
/// ```dart
/// import 'package:courier_map_tracker/courier_map_tracker.dart';
/// ```
///
/// Then use the [CourierDeliveryMap] widget to display delivery tracking:
/// ```dart
/// CourierDeliveryMap(
///   customerLat: -6.200000,
///   customerLng: 106.816666,
///   customerName: "John Doe",
///   customerAddress: "123 Main St, Jakarta",
///   serviceDetail: "Laundry Service",
///   onDeliveryCompleted: () => print("Delivery done"),
/// )
/// ```
library courier_map_tracker_lib;

export 'courier_map_tracker.dart';

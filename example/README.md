# Courier Map Tracker Example

This example demonstrates how to use the `courier_map_tracker` package to display real-time courier delivery tracking with an interactive map.

## Features Demonstrated

- **Interactive Map Display**: Shows a map centered on the customer's delivery location
- **Dual Markers**: Displays customer location (red) and courier location (blue)
- **Customer Information Panel**: Shows customer name, service details, and address
- **Navigation**: Quick access to navigation via native map applications
- **Contact Customer**: Direct call button to contact the customer
- **Delivery Completion**: Confirm delivery completion with a dialog

## Running the Example

### Prerequisites
- Flutter installed and configured
- A device or emulator running Android or iOS

### Steps

1. Navigate to the example directory:
```bash
cd example
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Usage

The example shows how to integrate the `CourierDeliveryMap` widget:

```dart
CourierDeliveryMap(
  customerLat: -6.200000,
  customerLng: 106.816666,
  courierLat: -6.195000,
  courierLng: 106.820000,
  customerName: 'Robil Dev',
  customerAddress: 'Jl. Kebon Jeruk Raya No. 12, Jakarta Barat',
  serviceDetail: 'Laundry Kiloan 5kg + Setrika',
  onDeliveryCompleted: () {
    // Handle delivery completion
  },
  onContactCustomer: () {
    // Initiate customer contact
  },
)
```

## Modifying the Example

To test with different locations:
1. Change the `customerLat` and `customerLng` values to any valid coordinates
2. Update `courierLat` and `courierLng` for the courier's position
3. Modify `customerName`, `customerAddress`, and `serviceDetail` with your test data

## App Navigation

- **Navigasi Button**: Opens the customer's location in your device's default map application
- **Phone Icon**: Shows a snackbar (implement `url_launcher` package for actual calling)
- **Selesaikan Button**: Shows a confirmation dialog to complete the delivery

After confirming completion, the app displays a success screen with an option to return to the tracking view.

## Requirements

- Flutter 1.17.0 or higher
- Dart 3.13.1 or higher
- Android (API 21+) or iOS (12.0+)

## Additional Resources

See the main package [README.md](../README.md) for more information about the `courier_map_tracker` package.

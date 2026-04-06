# Inventory Management App

A real-time Flutter inventory app built with Firebase Firestore. Users can create, read, update, and delete inventory items with instant UI synchronization through Firestore streams.

## Features

### Core
- Add, edit, and delete inventory items
- Real-time updates using `StreamBuilder` and Firestore snapshots
- Form validation for empty, numeric, and invalid values
- Loading, empty, and error state handling

### Enhanced Features

**1. Low Stock Warning Badge**
Items with a quantity below 5 display a red "Low stock" badge next to the quantity. This gives users an immediate visual signal to restock without having to manually check each item's quantity.

**2. Total Inventory Value Card**
A summary card at the top of the screen displays the total value of all inventory, calculated as the sum of each item's price multiplied by its quantity. This updates in real time as items are added, edited, or removed.

## Tech Stack

- Flutter
- Firebase Firestore
- StreamBuilder for real-time data

## Project Structure

```
lib/
  main.dart
  models/
    item.dart
  services/
    item_service.dart
  screens/
    home_screen.dart
    item_form.dart
```

## Setup

1. Clone the repo
2. Run `flutter pub get`
3. Run `flutterfire configure` and connect to your Firebase project
4. Enable Firestore in test mode in the Firebase Console
5. Run `flutter run`
# Skyris

Real-time forecasts with stunning visuals and precision.

## Project Overview

This project is Flutter application that displays current weather information, handles network requests, and manages state efficiently using `flutter_bloc`. It utilizes `retrofit` for network calls, `get_it` and `injectable` for dependency injection, and `freezed` for immutable object management.

> **Note:** This project uses **Flutter version 3.27.2**. For managing multiple Flutter versions, consider using **FVM** (Flutter Version Management).

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.6.0 <4.0.0)
- [Dart SDK](https://dart.dev/get-dart) (>=3.6.0 <4.0.0)

### Installation

1. Clone the repository:

   ```sh
   git clone https://github.com/betapundit/skyris.git
   cd skyris
   ```

2. Install the dependencies:

   ```sh
   flutter pub get
   ```

3. Run build runner:
   ```sh
   dart run build_runner build --delete-conflicting-outputs
   ```

### Running the App

Run the app on an emulator or connected device:

```sh
flutter run
```

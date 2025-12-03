# Stopwatch App

A simple, clean mobile stopwatch application built with Flutter.

## Features

- **Start/Stop**: Toggle the stopwatch with a single button
- **Reset**: Reset the timer to zero
- **Clean UI**: Modern, minimalist design with smooth animations
- **Accurate Timing**: Updates every 10ms for precise time display

## Project Structure

The project is organized into separate files for easy modification:

```
lib/
├── main.dart                    # App entry point and theme configuration
├── screens/
│   └── stopwatch_screen.dart   # Main screen with stopwatch logic
└── widgets/
    ├── stopwatch_display.dart  # Time display component
    └── stopwatch_controls.dart # Control buttons component
```

### File Descriptions

- **main.dart**: Sets up the MaterialApp, theme, and routes to the stopwatch screen
- **stopwatch_screen.dart**: Contains the main state management for the stopwatch (start, stop, reset logic)
- **stopwatch_display.dart**: Displays the elapsed time in MM:SS.mmm format
- **stopwatch_controls.dart**: Renders the Start/Stop and Reset buttons

## How to Run

1. Make sure you have Flutter installed
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to launch the app on your device/emulator

## Customization

### Changing Colors
- Edit the `colorScheme` in `lib/main.dart` to change the app's primary color
- Modify button colors in `lib/widgets/stopwatch_controls.dart`

### Changing Display Format
- Edit the `_formatDuration` method in `lib/widgets/stopwatch_display.dart`

### Changing Update Frequency
- Modify the `Duration(milliseconds: 10)` in `lib/screens/stopwatch_screen.dart` to change how often the timer updates

### Adding Features
- Add new state variables in `stopwatch_screen.dart`
- Create new widget files in the `widgets/` folder for reusable components
- Import and use them in `stopwatch_screen.dart`

## Requirements

- Flutter SDK 3.9.2 or higher
- Dart SDK

# George Ikwegbu Mobile

<p align="center">
  <img src="assets/images/icon.png" width="120" alt="App Icon" />
</p>

<p align="center">
  <strong>A lightweight Flutter WebView wrapper for the personal portfolio website of George Ikwegbu.</strong>
</p>

<p align="center">
  <a href="https://gikwegbu.netlify.app/" target="_blank">🌐 gikwegbu.netlify.app</a> &nbsp;|&nbsp;
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter" alt="Flutter" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey" alt="Platform" />
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License" />
</p>

---

## Overview

**George Ikwegbu Mobile** is a clean, minimal Flutter application that delivers a pure full-screen WebView experience for the personal portfolio and blog of George Ikwegbu — a Senior Flutter/Mobile Engineer. The app wraps [`https://gikwegbu.netlify.app/`](https://gikwegbu.netlify.app/) with no navigational chrome — no app bar, no bottom navigation — giving users a seamless, native-feeling browsing experience.

A floating action button provides a scannable **QR code** so visitors can instantly share the site with another device.

---

## Features

| Feature | Description |
|---|---|
| 🌐 **Full-Screen WebView** | Loads the portfolio website edge-to-edge with JavaScript enabled |
| ↩️ **Back Navigation** | Android back button navigates in-page history before exiting the app |
| 💦 **Native Splash Screen** | Branded `#00B4FF` splash appears on launch, transitions smoothly into the WebView |
| 📲 **QR Code FAB** | Floating action button opens a bottom sheet with a scannable QR code for the site URL |
| 🎨 **Custom Launcher Icon** | Branded `GI` icon generated for Android (adaptive) and iOS |

---

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) 3.x
- **Platforms**: Android (API 21+) · iOS (14+)
- **Package ID**: `app.netlify.gikwegbu`

### Dependencies

| Package | Purpose |
|---|---|
| [`webview_flutter`](https://pub.dev/packages/webview_flutter) | Renders the in-app WebView |
| [`qr_flutter`](https://pub.dev/packages/qr_flutter) | Generates the QR code image |
| [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash) | Configures the native launch splash screen |
| [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) | Generates Android & iOS launcher icons *(dev)* |

---

## Project Structure

```
lib/
├── main.dart              # App entry point & MaterialApp configuration
├── splash_screen.dart     # Branded 2-second splash with fade-in animation
├── webview_screen.dart    # Full-screen WebView + back-navigation + QR FAB
└── qr_modal.dart          # Bottom-sheet QR code modal widget

assets/
└── images/
    └── icon.png           # 1024×1024 launcher icon source

test/
└── widget_test.dart       # Widget & unit tests (MyApp, SplashScreen, QrModal)
```

---

## Getting Started

### Prerequisites

- Flutter SDK ≥ 3.0.0 ([install guide](https://docs.flutter.dev/get-started/install))
- Xcode (for iOS)
- Android Studio / Android SDK (for Android)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/gikwegbu/george_ikwegbu_mobile.git
cd george_ikwegbu_mobile

# 2. Install dependencies
flutter pub get

# 3. Generate launcher icons
dart run flutter_launcher_icons

# 4. Generate native splash screens
dart run flutter_native_splash:create

# 5. Run the app
flutter run
```

---

## Running Tests

```bash
flutter test
```

The test suite covers:

- **`MyApp`** — widget renders, correct title, debug banner disabled, initial route
- **`SplashScreen`** — correct text content, background colour, navigation timing
- **`QrModal`** — heading, URL display, helper text, accepts arbitrary URLs

---

## Building for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS (requires Apple Developer account)
flutter build ios --release
```

---

## License

```
MIT License

Copyright (c) 2026 George Ikwegbu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

---

## Author

**George Ikwegbu** — Senior Flutter/Mobile Engineer  
🌐 [gikwegbu.netlify.app](https://gikwegbu.netlify.app/)  
✉️ g.ikwegbu@gmail.com

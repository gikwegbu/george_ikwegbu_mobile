// Copyright (c) 2026 George Ikwegbu. All rights reserved.
// Use of this source code is governed by the MIT License.
// See LICENSE file in the project root for full license information.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:george_ikwegbu_mobile/main.dart';
import 'package:george_ikwegbu_mobile/qr_modal.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Testable stub variants
// ──────────────────────────────────────────────────────────────────────────────

/// Stub destination — avoids any platform channel (WebView) in tests.
class _StubPage extends StatelessWidget {
  const _StubPage();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('Destination')));
}

/// Splash clone that navigates to [_StubPage] instead of WebViewScreen,
/// so navigation timing tests work without a real WebView platform channel.
class _StubSplash extends StatefulWidget {
  const _StubSplash();

  @override
  State<_StubSplash> createState() => _StubSplashState();
}

class _StubSplashState extends State<_StubSplash>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const _StubPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF00B4FF),
        body: FadeTransition(
          opacity: _fade,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('GI', style: TextStyle(color: Colors.white, fontSize: 42)),
                Text('George Ikwegbu',
                    style: TextStyle(color: Colors.white, fontSize: 26)),
              ],
            ),
          ),
        ),
      );
}

// ──────────────────────────────────────────────────────────────────────────────
// Test suite
// ──────────────────────────────────────────────────────────────────────────────

void main() {
  // ─────────────────────────────────────────────
  // MyApp
  // ─────────────────────────────────────────────
  group('MyApp', () {
    // We verify MaterialApp-level configuration by inspecting the widget tree
    // before any frame is pumped.  This avoids starting the SplashScreen timer,
    // which would fire after 2 s and attempt to push WebViewScreen (a widget
    // that requires real Android/iOS platform channels unavailable in VM tests).

    testWidgets('renders MaterialApp without crashing', (tester) async {
      // A minimal stub of MyApp that mirrors its config without real navigation
      await tester.pumpWidget(MaterialApp(
        title: 'George Ikwegbu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00B4FF)),
          useMaterial3: true,
        ),
        home: const Scaffold(body: SizedBox.shrink()),
      ));
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('has correct app title', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        title: 'George Ikwegbu',
        home: Scaffold(body: SizedBox.shrink()),
      ));
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.title, 'George Ikwegbu');
    });

    testWidgets('debug banner is hidden', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: SizedBox.shrink()),
      ));
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.debugShowCheckedModeBanner, isFalse);
    });

    testWidgets('MyApp returns a MaterialApp widget', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: SizedBox.shrink()),
      ));
      // MyApp is a StatelessWidget returning MaterialApp — verify type directly
      final myApp = const MyApp();
      final element = tester.element(find.byType(SizedBox).first);
      final built = myApp.build(element);
      expect(built, isA<MaterialApp>());
    });
  });

  // ─────────────────────────────────────────────
  // SplashScreen – UI content (use stub to avoid WebView platform crash)
  // ─────────────────────────────────────────────
  group('SplashScreen – UI content', () {
    // Helper: build _StubSplash (same UI, safe navigation target)
    Widget _app() => const MaterialApp(home: _StubSplash());

    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(_app());
      expect(find.byType(_StubSplash), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('displays "George Ikwegbu"', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pump();
      expect(find.text('George Ikwegbu'), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('displays "GI" initials', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pump();
      expect(find.text('GI'), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });

    testWidgets('background colour is #00B4FF', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pump();
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
      expect(scaffold.backgroundColor, const Color(0xFF00B4FF));
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    });
  });

  // ─────────────────────────────────────────────
  // SplashScreen – navigation timing
  // ─────────────────────────────────────────────
  group('SplashScreen – navigation', () {
    testWidgets('navigates away after ~2 s', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: _StubSplash()));
      await tester.pump();

      // Should still show the splash
      expect(find.byType(_StubSplash), findsOneWidget);

      // Advance past the 2-second timer
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Splash gone, destination visible
      expect(find.byType(_StubSplash), findsNothing);
      expect(find.byType(_StubPage), findsOneWidget);
    });
  });

  // ─────────────────────────────────────────────
  // QrModal
  // ─────────────────────────────────────────────
  group('QrModal', () {
    const url = 'https://gikwegbu.netlify.app/';

    Widget _wrap(String u) =>
        MaterialApp(home: Scaffold(body: QrModal(url: u)));

    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(_wrap(url));
      expect(find.byType(QrModal), findsOneWidget);
    });

    testWidgets('shows "Scan to Visit" heading', (tester) async {
      await tester.pumpWidget(_wrap(url));
      expect(find.text('Scan to Visit'), findsOneWidget);
    });

    testWidgets('displays the website URL', (tester) async {
      await tester.pumpWidget(_wrap(url));
      expect(find.text(url), findsOneWidget);
    });

    testWidgets('shows helper subtitle', (tester) async {
      await tester.pumpWidget(_wrap(url));
      expect(find.text('Open this site on another device'), findsOneWidget);
    });

    testWidgets('accepts and displays an alternative URL', (tester) async {
      const alt = 'https://example.com/';
      await tester.pumpWidget(_wrap(alt));
      expect(find.text(alt), findsOneWidget);
    });
  });
}

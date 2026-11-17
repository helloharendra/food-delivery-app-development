// FeastGo – Food delivery app UI demo by Naya Prayog Technologies (https://nayaprayog.com)
// Run: flutter pub get && flutter run   (Android, iOS or Chrome)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart.dart';
import 'core/contact.dart';
import 'screens/home.dart';
import 'screens/tracking.dart';

const appName = 'FeastGo';
const brand = Color(0xFFFF5A1F);

/// Created once so state survives root rebuilds (resize, rotation, theme changes).
final _cart = Cart();

void main() => runApp(const FeastGoApp());

class FeastGoApp extends StatelessWidget {
  const FeastGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: brand, primary: brand, tertiary: const Color(0xFFFFB020)));
    return CartScope(
      cart: _cart,
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: base.copyWith(scaffoldBackgroundColor: const Color(0xFFF8F8FA), textTheme: GoogleFonts.poppinsTextTheme(base.textTheme)),
        home: const Shell(),
      ),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [const HomeScreen(), const TrackingScreen(), _Locked(onTap: () => Contact.show(context, appName, 'Customer Profile, Wallet & Addresses'))];
    return Scaffold(
      body: IndexedStack(index: i, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        backgroundColor: Colors.white,
        onDestinationSelected: (v) => setState(() => i = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.restaurant_outlined), selectedIcon: Icon(Icons.restaurant, color: brand), label: 'Food'),
          NavigationDestination(icon: Icon(Icons.delivery_dining_outlined), selectedIcon: Icon(Icons.delivery_dining, color: brand), label: 'Track order'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person, color: brand), label: 'Account'),
        ],
      ),
    );
  }
}

class _Locked extends StatelessWidget {
  const _Locked({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.lock_person_rounded, size: 64, color: brand),
          const SizedBox(height: 12),
          const Text('Accounts, wallet & saved addresses', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 12),
          FilledButton(onPressed: onTap, child: const Text('Available in full version')),
        ]),
      );
}

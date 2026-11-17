import 'dart:async';

import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../main.dart';

/// Live order tracking (simulated). The full app uses real-time rider GPS.
class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});
  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  static const steps = [
    ('Order placed', 'Biryani Darbar accepted your order', Icons.receipt_long),
    ('Preparing', 'Your food is being cooked', Icons.soup_kitchen),
    ('Picked up', 'Ravi is on the way', Icons.delivery_dining),
    ('Delivered', 'Enjoy your meal!', Icons.check_circle),
  ];
  int step = 1;
  double progress = .35;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      setState(() {
        progress = progress >= 1 ? .1 : progress + .15;
        step = progress < .3 ? 1 : progress < .95 ? 2 : 3;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Track order', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const Text('#FG-48213 · Biryani Darbar', style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 16),
        // Map mock with moving rider
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            height: 240,
            color: const Color(0xFFE8F0EA),
            child: LayoutBuilder(builder: (_, c) {
              return Stack(children: [
                CustomPaint(size: Size(c.maxWidth, 240), painter: _RoutePainter()),
                AnimatedPositioned(
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeInOut,
                  left: 24 + (c.maxWidth - 88) * progress,
                  top: 150 - 90 * progress,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: brand, shape: BoxShape.circle, boxShadow: [BoxShadow(color: brand.withValues(alpha: .5), blurRadius: 16)]),
                    child: const Icon(Icons.delivery_dining, color: Colors.white),
                  ),
                ),
                const Positioned(right: 20, top: 34, child: Icon(Icons.home_rounded, size: 34, color: Color(0xFF16A34A))),
              ]);
            }),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(children: [
            const CircleAvatar(radius: 24, backgroundColor: Color(0xFFFFEDD5), child: Text('🛵', style: TextStyle(fontSize: 22))),
            const SizedBox(width: 12),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Ravi Kumar', style: TextStyle(fontWeight: FontWeight.w700)), Text('Your delivery partner · 4.9 ★', style: TextStyle(color: Colors.black54, fontSize: 13))])),
            IconButton.filledTonal(onPressed: () => Contact.show(context, appName, 'Call / Chat with Delivery Partner'), icon: const Icon(Icons.call)),
          ]),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: List.generate(steps.length, (i) {
              final done = i <= step;
              return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: done ? brand : Colors.black12, shape: BoxShape.circle),
                    child: Icon(steps[i].$3, size: 16, color: Colors.white),
                  ),
                  if (i < steps.length - 1) Container(width: 2, height: 34, color: i < step ? brand : Colors.black12),
                ]),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(steps[i].$1, style: TextStyle(fontWeight: FontWeight.w700, color: done ? Colors.black : Colors.black38)),
                    Text(steps[i].$2, style: TextStyle(fontSize: 13, color: done ? Colors.black54 : Colors.black26)),
                  ]),
                ),
                if (i == step) Text('${((1 - progress) * 18).round()} min', style: const TextStyle(fontWeight: FontWeight.w800, color: brand)),
              ]);
            }),
          ),
        ),
      ]),
    );
  }
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()..color = Colors.white..strokeWidth = 14..style = PaintingStyle.stroke;
    for (var i = 0; i < 5; i++) {
      canvas.drawLine(Offset(0, 40.0 + i * 50), Offset(size.width, 20.0 + i * 50), road);
      canvas.drawLine(Offset(40.0 + i * size.width / 5, 0), Offset(20.0 + i * size.width / 5, size.height), road);
    }
    final route = Paint()..color = brand..strokeWidth = 5..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final path = Path()..moveTo(44, 170)..quadraticBezierTo(size.width * .5, 140, size.width - 40, 60);
    canvas.drawPath(path, route);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';

import '../cart.dart';
import '../core/contact.dart';
import '../core/net_image.dart';
import '../data.dart';
import '../main.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen(this.r, {super.key});
  final Restaurant r;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 240,
          pinned: true,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(backgroundColor: Colors.white, child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 20))),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(r.name, style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white, shadows: [Shadow(blurRadius: 12)])),
            background: Hero(tag: r.name, child: NetImage(r.image.replaceAll('w=600', 'w=1000'))),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(spacing: 8, runSpacing: 8, children: [
              _pill(Icons.star_rounded, '${r.rating} (2K+)', const Color(0xFF16A34A)),
              _pill(Icons.timer_outlined, '${r.time}–${r.time + 5} min', brand),
              _pill(Icons.delivery_dining, 'Free delivery', const Color(0xFF2563EB)),
            ]),
          ),
        ),
        SliverList.separated(
          itemCount: r.menu.length,
          separatorBuilder: (_, __) => const Divider(indent: 20, endIndent: 20),
          itemBuilder: (_, i) {
            final d = r.menu[i];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Icon(Icons.radio_button_checked, size: 16, color: d.veg ? const Color(0xFF16A34A) : const Color(0xFFB91C1C)),
                      if (d.bestseller) const Padding(padding: EdgeInsets.only(left: 6), child: Text('★ Bestseller', style: TextStyle(color: Color(0xFFEA580C), fontSize: 12, fontWeight: FontWeight.w700))),
                    ]),
                    const SizedBox(height: 4),
                    Text(d.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    Text('₹${d.price}', style: const TextStyle(fontWeight: FontWeight.w600)),
                    if (d.desc.isNotEmpty) Text(d.desc, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                  ]),
                ),
                _Stepper(d: d, r: r),
              ]),
            );
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ]),
      bottomSheet: ListenableBuilder(
        listenable: cart,
        builder: (_, __) => cart.count == 0
            ? const SizedBox.shrink()
            : SafeArea(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
                  decoration: BoxDecoration(color: const Color(0xFF16A34A), borderRadius: BorderRadius.circular(18)),
                  child: Row(children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                        Text('${cart.count} item${cart.count > 1 ? 's' : ''} · ₹${cart.total}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                        const Text('Extra charges may apply', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ]),
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF16A34A)),
                      onPressed: () => Contact.show(context, appName, 'Checkout & Payments (UPI, Cards, COD)'),
                      child: const Text('View cart  →', style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ]),
                ),
              ),
      ),
    );
  }

  Widget _pill(IconData i, String t, Color c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(color: c.withValues(alpha: .1), borderRadius: BorderRadius.circular(12)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(i, size: 16, color: c), const SizedBox(width: 4), Text(t, style: TextStyle(color: c, fontWeight: FontWeight.w700, fontSize: 12))]),
      );
}

class _Stepper extends StatelessWidget {
  const _Stepper({required this.d, required this.r});
  final Dish d;
  final Restaurant r;

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final q = cart.qty(d);
    return Container(
      width: 104,
      height: 40,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF16A34A).withValues(alpha: .4)), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .06), blurRadius: 10)]),
      child: q == 0
          ? TextButton(onPressed: () => cart.add(d, r), child: const Text('ADD', style: TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.w900)))
          : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(onTap: () => cart.remove(d), child: const Icon(Icons.remove, color: Color(0xFF16A34A))),
              Text('$q', style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF16A34A))),
              InkWell(onTap: () => cart.add(d, r), child: const Icon(Icons.add, color: Color(0xFF16A34A))),
            ]),
    );
  }
}

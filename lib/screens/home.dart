import 'package:flutter/material.dart';

import '../core/contact.dart';
import '../core/net_image.dart';
import '../data.dart';
import '../main.dart';
import 'restaurant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: const EdgeInsets.only(bottom: 24), children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Row(children: [
            const Icon(Icons.location_on_rounded, color: brand),
            const SizedBox(width: 6),
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Home', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                Text('42, MG Road, Bengaluru', style: TextStyle(color: Colors.black54, fontSize: 13)),
              ]),
            ),
            CircleAvatar(backgroundColor: brand.withValues(alpha: .12), child: const Text('AK', style: TextStyle(color: brand, fontWeight: FontWeight.w700))),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            readOnly: true,
            onTap: () => Contact.show(context, appName, 'Smart Search (Dishes & Restaurants)'),
            decoration: InputDecoration(
              hintText: 'Search "biryani"',
              prefixIcon: const Icon(Icons.search_rounded, color: brand),
              suffixIcon: const Icon(Icons.mic_none_rounded),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            ),
          ),
        ),
        // Offer banner
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(colors: [Color(0xFFFF7A3D), Color(0xFFFF3D54)]),
            boxShadow: [BoxShadow(color: brand.withValues(alpha: .35), blurRadius: 24, offset: const Offset(0, 10))],
          ),
          child: Row(children: [
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('FLAT 60% OFF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 26)),
                SizedBox(height: 4),
                Text('On your first 3 orders · Code FEAST60', style: TextStyle(color: Colors.white70)),
              ]),
            ),
            const Text('🍔', style: TextStyle(fontSize: 56)),
          ]),
        ),
        const SizedBox(height: 24),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text("What's on your mind?", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18))),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, i) => Column(children: [
              Container(width: 64, height: 64, alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Text(categories[i].$1, style: const TextStyle(fontSize: 30))),
              const SizedBox(height: 6),
              Text(categories[i].$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            ]),
          ),
        ),
        const SizedBox(height: 16),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text('${restaurants.length} restaurants near you', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18))),
        const SizedBox(height: 12),
        ...restaurants.map((r) => _RestaurantCard(r)),
      ]),
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  const _RestaurantCard(this.r);
  final Restaurant r;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RestaurantScreen(r))),
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 20, offset: const Offset(0, 8))]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Hero(tag: r.name, child: NetImage(r.image, height: 170, width: double.infinity, radius: 24)),
            if (r.offer != null)
              Positioned(
                left: 0, bottom: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: const BoxDecoration(color: Color(0xFF2563EB), borderRadius: BorderRadius.horizontal(right: Radius.circular(8))),
                  child: Text(r.offer!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                ),
              ),
            Positioned(right: 12, top: 12, child: CircleAvatar(backgroundColor: Colors.white, radius: 18, child: IconButton(iconSize: 18, onPressed: () => Contact.show(context, appName, 'Favourites'), icon: const Icon(Icons.favorite_border)))),
          ]),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                  Text(r.cuisine, style: const TextStyle(color: Colors.black54)),
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF16A34A), borderRadius: BorderRadius.circular(8)),
                child: Text('${r.rating} ★', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 10),
              Text('${r.time} min', style: const TextStyle(fontWeight: FontWeight.w600)),
            ]),
          ),
        ]),
      ),
    );
  }
}

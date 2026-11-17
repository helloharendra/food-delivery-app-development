import 'core/net_image.dart';

/// Sample data for the UI demo. The full app loads restaurants & menus from the backend.
class Dish {
  const Dish(this.name, this.price, this.veg, {this.desc = '', this.bestseller = false});
  final String name, desc;
  final int price;
  final bool veg, bestseller;
}

class Restaurant {
  const Restaurant({required this.name, required this.cuisine, required this.rating, required this.time, required this.image, required this.menu, this.offer});
  final String name, cuisine, image;
  final String? offer;
  final double rating;
  final int time;
  final List<Dish> menu;
}

const categories = [('🍕', 'Pizza'), ('🍔', 'Burger'), ('🍛', 'Biryani'), ('🥗', 'Healthy'), ('🍜', 'Chinese'), ('🧁', 'Desserts')];

final restaurants = <Restaurant>[
  Restaurant(name: 'Biryani Darbar', cuisine: 'Biryani · Mughlai', rating: 4.6, time: 30, offer: '50% OFF up to ₹100', image: unsplash('1563379091339-03b21ab4a4f8'), menu: const [
    Dish('Chicken Dum Biryani', 299, false, desc: 'Slow-cooked with saffron & fried onions', bestseller: true),
    Dish('Mutton Biryani', 399, false, desc: 'Tender mutton, aged basmati'),
    Dish('Paneer Tikka Biryani', 269, true, desc: 'Smoky paneer, mint raita'),
    Dish('Butter Chicken', 329, false, desc: 'Creamy tomato gravy', bestseller: true),
    Dish('Gulab Jamun', 89, true, desc: '2 pieces'),
  ]),
  Restaurant(name: 'Napoli Pizza Co.', cuisine: 'Pizza · Italian', rating: 4.5, time: 25, offer: 'Buy 1 Get 1', image: unsplash('1565299624946-b28f40a0ae38'), menu: const [
    Dish('Margherita', 249, true, desc: 'San Marzano tomato, fresh mozzarella', bestseller: true),
    Dish('Pepperoni Feast', 399, false, desc: 'Double pepperoni, chilli oil'),
    Dish('Farmhouse Veggie', 329, true, desc: 'Capsicum, olives, mushroom'),
    Dish('Garlic Bread', 129, true, desc: 'With cheesy dip'),
  ]),
  Restaurant(name: 'Smash Burgers', cuisine: 'Burgers · Shakes', rating: 4.4, time: 22, image: unsplash('1568901346375-23c9450c58cd'), menu: const [
    Dish('Classic Smash', 219, false, desc: 'Double patty, cheddar, house sauce', bestseller: true),
    Dish('Crispy Paneer Burger', 189, true),
    Dish('Peri Peri Fries', 119, true),
    Dish('Oreo Shake', 159, true),
  ]),
  Restaurant(name: 'Green Bowl', cuisine: 'Healthy · Salads', rating: 4.8, time: 18, offer: '20% OFF', image: unsplash('1546069901-ba9599a7e63c'), menu: const [
    Dish('Protein Power Bowl', 299, false, desc: 'Grilled chicken, quinoa, greens', bestseller: true),
    Dish('Mediterranean Salad', 249, true),
    Dish('Cold-pressed Juice', 149, true),
  ]),
];

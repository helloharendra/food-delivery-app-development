import 'package:flutter/widgets.dart';

import 'data.dart';

/// Minimal cart state shared through an InheritedNotifier (no extra packages).
class Cart extends ChangeNotifier {
  final Map<Dish, int> items = {};
  Restaurant? from;

  int get count => items.values.fold(0, (a, b) => a + b);
  int get total => items.entries.fold(0, (s, e) => s + e.key.price * e.value);
  int qty(Dish d) => items[d] ?? 0;

  void add(Dish d, Restaurant r) {
    if (from != r) items.clear();
    from = r;
    items[d] = qty(d) + 1;
    notifyListeners();
  }

  void remove(Dish d) {
    final q = qty(d) - 1;
    q <= 0 ? items.remove(d) : items[d] = q;
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}

class CartScope extends InheritedNotifier<Cart> {
  const CartScope({super.key, required Cart cart, required super.child}) : super(notifier: cart);
  static Cart of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<CartScope>()!.notifier!;
}

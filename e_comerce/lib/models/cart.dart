import '../models/product.dart';

class Cart {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void add(Product product) {
    _items.add(product);
  }

  void remove(Product product) {
    _items.remove(product);
  }

  double get totalPrice =>
      _items.fold(0.0, (total, item) => total + item.price);
}

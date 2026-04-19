import 'product.dart';

class CartItem {
  final Product product;
  double kg;

  CartItem({required this.product, this.kg = 1});

  double get totalPrice => product.pricePerKg * kg;
}

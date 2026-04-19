import 'cart_item.dart';
import 'product.dart';

class CartProvider {
  static final List<CartItem> cartItems = [];

  static void addToCart(Product product, double kg) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      cartItems[index].kg += kg;
    } else {
      cartItems.add(CartItem(product: product, kg: kg));
    }
  }

  static void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
  }

  static double get total =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);
}

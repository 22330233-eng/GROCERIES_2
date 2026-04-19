import 'package:flutter/material.dart';
import 'cart_provider.dart';
import 'check_out.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(
        children: [
          Expanded(
            child: CartProvider.cartItems.isEmpty
                ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: CartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = CartProvider.cartItems[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // PRODUCT IMAGE
                        Image.asset(
                          item.product.image,
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image,
                              size: 50,
                            );
                          },
                        ),

                        const SizedBox(width: 12),

                        // PRODUCT INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (item.kg > 1) {
                                          item.kg--;
                                        }
                                      });
                                    },
                                  ),

                                  Text('${item.kg} kg'),

                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        item.kg++;
                                      });
                                    },
                                  ),
                                ],
                              ),

                              Text(
                                '${item.totalPrice.toStringAsFixed(2)} \$',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),


                        // DELETE BUTTON
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              CartProvider.removeFromCart(
                                item.product.id,
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // TOTAL + DELIVERY
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Total: ${CartProvider.total.toStringAsFixed(2)} \$',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: CartProvider.cartItems.isEmpty
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CheckoutPage(),
                        ),
                      );
                    },
                    child: const Text('Proceed to Checkout'),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

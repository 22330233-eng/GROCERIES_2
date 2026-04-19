import 'package:flutter/material.dart';
import 'cart_provider.dart';
import 'payment_page.dart';


class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: CartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final item = CartProvider.cartItems[index];
                  return ListTile(
                    leading: Image.asset(
                      item.product.image,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(item.product.name),
                    subtitle: Text('${item.kg} kg'),
                    trailing: Text(
                      '${item.totalPrice.toStringAsFixed(2)} \$',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),

            const Divider(),

            Text(
              'Total: ${CartProvider.total.toStringAsFixed(2)} \$',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child:ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PaymentPage(),
                    ),
                  );
                },
                child: const Text(
                  'Continue to Payment',
                  style: TextStyle(fontSize: 18),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}

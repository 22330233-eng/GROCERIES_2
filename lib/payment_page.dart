import 'package:flutter/material.dart';
import 'cart_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = 'cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ORDER TOTAL
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '${CartProvider.total.toStringAsFixed(2)} \$',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // PAYMENT METHODS
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose Payment Method',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: 10),

            // CASH OPTION
            RadioListTile(
              value: 'cash',
              groupValue: selectedMethod,
              onChanged: (value) {
                setState(() => selectedMethod = value.toString());
              },
              title: const Text('Cash on Delivery'),
              subtitle: const Text('Pay when order arrives'),
              secondary: const Icon(Icons.money),
            ),

            // CARD OPTION
            RadioListTile(
              value: 'card',
              groupValue: selectedMethod,
              onChanged: (value) {
                setState(() => selectedMethod = value.toString());
              },
              title: const Text('Credit / Debit Card'),
              subtitle: const Text('Pay using your card'),
              secondary: const Icon(Icons.credit_card),
            ),

            const SizedBox(height: 20),

            // CARD FORM (UI ONLY)
            if (selectedMethod == 'card')
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          prefixIcon: Icon(Icons.credit_card),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(labelText: 'Card Holder Name'),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(labelText: 'MM/YY'),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(labelText: 'CVV'),
                              keyboardType: TextInputType.number,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const Spacer(),

            // CONFIRM BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Order Confirmed'),
                      content: Text(
                        selectedMethod == 'cash'
                            ? 'Your order will be paid in cash on delivery.'
                            : 'Your card payment was successful.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            CartProvider.cartItems.clear();
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

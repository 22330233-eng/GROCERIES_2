import 'package:flutter/material.dart';
import 'data.dart';
import 'cart_provider.dart';
import 'product_details_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'all';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final matchesCategory =
          selectedCategory == 'all' || product.category == selectedCategory;

      final matchesSearch =
      product.name.toLowerCase().contains(searchQuery);

      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Grocery Shop')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() => searchQuery = value.toLowerCase());
              },
              decoration: InputDecoration(
                hintText: 'Search fruits or vegetables',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() => searchQuery = '');
                  },
                )
                    : null,

              ),
            ),
          ),

          // Categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              categoryButton('Fruits', 'fruits'),
              categoryButton('Vegetables', 'vegetables'),
            ],
          ),

          // Products
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return productCard(filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryButton(String title, String category) {
    return ElevatedButton(
      onPressed: () {
        setState(() => selectedCategory = category);
      },
      child: Text(title),
    );
  }

  Widget productCard(product) {
    double kg = 1;

    return StatefulBuilder(
      builder: (context, setLocalState) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // IMAGE
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsPage(product: product),
                      ),
                    );
                  },
                  child: Image.asset(
                    product.image,
                    height: 80,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image, size: 80);
                    },
                  ),
                ),


                const SizedBox(height: 10),

                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text('${product.pricePerKg} \$ / kg'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (kg > 1) {
                          setLocalState(() => kg--);
                        }
                      },
                    ),
                    Text('$kg kg'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setLocalState(() => kg++);
                      },
                    ),
                  ],
                ),

                Text(
                  'Total: ${(kg * product.pricePerKg).toStringAsFixed(2)} \$',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                ElevatedButton(
                  onPressed: () {
                    CartProvider.addToCart(product, kg);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                  child: const Text('Add to Cart'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}

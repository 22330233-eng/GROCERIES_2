import 'package:flutter/material.dart';
import 'package:groceries/main.dart';
import 'home.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class Bottom extends StatefulWidget{
  const Bottom({super.key});
  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom>{
  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

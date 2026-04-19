import 'package:flutter/material.dart';
// These imports tell the app where your other screens are
import 'login_page.dart';
import 'signup_page.dart';

void main() {
  runApp(const OurShopApp());
}

class OurShopApp extends StatelessWidget {
  const OurShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the red "Debug" banner
      title: 'Our Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Full-screen Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/WhatsApp Image 2026-01-03 at 7.39.51 PM.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 2. Overlay to make the text pop
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.4), // Darkens the image slightly
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "OUR SHOP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Fresh groceries to your door",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                const SizedBox(height: 60),

                // LOGIN BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(250, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    // This takes you to login_page.dart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text("LOG IN", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),

                const SizedBox(height: 20),

                // SIGN UP BUTTON
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white, width: 2),
                    minimumSize: const Size(250, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    // This takes you to signup_page.dart
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpPage()),
                    );
                  },
                  child: const Text("SIGN UP", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
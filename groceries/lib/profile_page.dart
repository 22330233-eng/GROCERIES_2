import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: Somaya'),
            SizedBox(height: 10),
            Text('Email: somaya@email.com'),
            SizedBox(height: 10),
            Text('Address: Beirut, Lebanon'),
          ],
        ),
      ),
    );
  }
}

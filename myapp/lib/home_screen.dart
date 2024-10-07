import 'package:flutter/material.dart';
// Import shared footer widget
import 'bottom_nav_bar.dart'; // Import shared bottom navigation bar widget

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to sign-up screen
            },
            child: const Text('Sign up', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              // Navigate to sign-in screen
            },
            child: const Text('Sign in', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to ReportCycle'),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}

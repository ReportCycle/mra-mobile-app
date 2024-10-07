import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        backgroundColor: isDarkMode
            ? Colors.grey[900]
            : Colors.grey[50], // Adjust background color for dark mode
        appBar: AppBar(
          elevation: 0,
          backgroundColor: isDarkMode
              ? Colors.black
              : Colors.white, // Adjust the app bar color for night mode
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left Section: Logo and Dark Mode Toggle
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Go back to home screen
                    },
                    child: Image.asset(
                      isDarkMode
                          ? 'assets/Logo-White.png'
                          : 'assets/Logo.png', // Switch logo based on mode
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Dark mode switch
                  SvgPicture.asset(
                    isDarkMode
                        ? 'assets/moon-solid.svg'
                        : 'assets/sun-solid.svg',
                    height: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 6),
                  Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        toggleTheme();
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.grey.shade400,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              // Right Section: Sign In Button
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // Navigate back to the home screen for sign in
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                // Privacy Policy Page Title
                Center(
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: isDarkMode ? Colors.white : Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 30),
                // Under Construction Message
                Text(
                  'This page is currently under construction. We are working hard to improve your experience. Check back soon for updates!',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black, // Adjust text color for dark mode
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Back to Homepage Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to homepage
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 15.0),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blueAccent.withOpacity(0.3),
                    ),
                    child: const Text(
                      'Back to Homepage',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildModernBottomNavBar(),
      ),
    );
  }

  // Modern Bottom Navigation Bar
  Widget _buildModernBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_number),
          label: 'Tickets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code),
          label: 'QR Codes',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      elevation: 10,
      type: BottomNavigationBarType.fixed,
    );
  }
}

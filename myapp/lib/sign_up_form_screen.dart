import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpFormScreen extends StatefulWidget {
  const SignUpFormScreen({super.key});

  @override
  _SignUpFormScreenState createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
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
              // Right Section: Only Sign In Button on the Sign-Up Page
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Create Your Account Header
                Center(
                  child: Text(
                    'Create Your Account',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: isDarkMode ? Colors.white : Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Join our community and experience smart city solutions!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isDarkMode
                        ? Colors.grey[400]
                        : Colors.grey, // Adjust text color for night mode
                  ),
                ),
                const SizedBox(height: 30),
                // Username Field
                Text(
                  'Username: *',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                _buildModernTextField(
                  hintText: 'Can be generated automatically',
                  icon: Icons.casino,
                  isDarkMode: isDarkMode, // Pass night mode
                ),
                const SizedBox(height: 20),
                // Display Name
                Text(
                  'Display name:',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                _buildModernTextField(
                  hintText: 'Leave empty to use the username',
                  icon: Icons.person,
                  isDarkMode: isDarkMode, // Pass night mode
                ),
                const SizedBox(height: 20),
                // Email
                Text(
                  'Email: *',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                _buildModernTextField(
                  hintText: 'Will be used for activation',
                  icon: Icons.email,
                  isDarkMode: isDarkMode, // Pass night mode
                ),
                const SizedBox(height: 20),
                // Password Field
                Text(
                  'Password: *',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                _buildModernTextField(
                  hintText: 'Make sure your password is strong',
                  icon: Icons.lock,
                  isPassword: true,
                  isDarkMode: isDarkMode, // Pass night mode
                ),
                const SizedBox(height: 20),
                // Repeat Password Field
                Text(
                  'Repeat Password: *',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                _buildModernTextField(
                  hintText: 'Must match the password',
                  icon: Icons.lock,
                  isPassword: true,
                  isDarkMode: isDarkMode, // Pass night mode
                ),
                const SizedBox(height: 40),
                // Wrap button in Center widget
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
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
                      'Agree & Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Navigate back to the home screen
                    },
                    child: const Text(
                      'Already have an account? Sign in',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
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

  // Modern TextField with Icons and Rounded Corners
  Widget _buildModernTextField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    required bool isDarkMode,
  }) {
    return TextField(
      obscureText: isPassword,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.grey[500] : Colors.grey.shade500,
        ),
        suffixIcon: isPassword
            ? Icon(Icons.visibility_off,
                color: isDarkMode ? Colors.grey[400] : Colors.grey.shade500)
            : null,
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

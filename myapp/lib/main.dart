import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'sign_up_form_screen.dart'; // Import the SignUpFormScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          onPrimary: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          onPrimary: Colors.white,
          brightness: Brightness.dark,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MyHomePage(title: 'Report Cycle Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  bool _isPasswordVisible = false; // Track password visibility

  final List<Widget> _pages = [
    buildPage(
      title: 'Empower your Community',
      text:
          "Spot issues? Report instantly with MyReportApp! Whether it's damage in your neighborhood, suggestions for the advancement of a city, organizational flaws, or service complaints, share them privately with facility managers or publicly with the RC community. Your voice matters. Let's make it heard.",
      imagePath: 'assets/first.jpg',
    ),
    buildPage(
      title: 'Engage With Organizations',
      text:
          "Take action in your community with MyReportApp. Vote on local issues, track their resolution, and stay informed by simply scanning QR codes on issue announcements. Your involvement can drive change. Start by keeping updated on the progress of reports in your neighborhood.",
      imagePath: 'assets/second.jpg',
    ),
    buildPage(
      title: 'Enhance Citizen Satisfication',
      text:
          "MyReportApp is designed with happiness in mind. As a smart city solution, it not only facilitates efficient issue reporting and monitoring but also rewards engaged citizens with perks from local institutions. Report, monitor, and get rewarded. Join our community of responsible citizens.",
      imagePath: 'assets/third.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myAppState = context.findAncestorStateOfType<_MyAppState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40), // Adjust for top padding
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Logo
                      Image.asset(
                        myAppState?.isDarkMode ?? false
                            ? 'assets/Logo-White.png'
                            : 'assets/Logo.png',
                        height: 48.0,
                        width: 48.0,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                      const SizedBox(width: 10),
                      // Toggle Sun/Moon Icon based on theme mode
                      SvgPicture.asset(
                        myAppState?.isDarkMode ?? false
                            ? 'assets/moon-solid.svg'
                            : 'assets/sun-solid.svg',
                        color: myAppState?.isDarkMode ?? false
                            ? Colors.white
                            : Colors.black,
                        height: 16.0, // Reduced height
                        width: 16.0, // Reduced width
                      ),
                      const SizedBox(width: 6),
                      Transform.scale(
                        scale: 0.6,
                        child: Switch(
                          value: myAppState?.isDarkMode ?? false,
                          onChanged: (value) {
                            myAppState?.toggleTheme();
                          },
                          activeColor: Colors.blue,
                          inactiveThumbColor: Colors.grey.shade400,
                          inactiveTrackColor: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Sign Up Button with navigation to SignUpFormScreen
                      Flexible(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SignUpFormScreen(), // Navigate to SignUpFormScreen
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                            backgroundColor: const Color(0xFFF0F0F0),
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Sign In Button
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                            backgroundColor: Colors.blue,
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
                ],
              ),

              // Center-aligned Welcome Message
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to your reporting assistant',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 15), // Adjust spacing here if necessary

              // Username or Email TextField
              Text(
                'Username or Email:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
                ),
                style: TextStyle(
                  fontSize: 14,
                  height: 1.2,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0), // Reduced padding to lessen the space
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero), // No additional padding
                    ),
                    child: Text(
                      'Forgot username?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),

              // Password TextField with visibility toggle
              Text(
                'Password:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              TextField(
                obscureText: !_isPasswordVisible, // Toggle visibility
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 10.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Change icon based on visibility state
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 20,
                    minWidth: 40,
                  ),
                ),
                style: TextStyle(
                  fontSize: 14,
                  height: 1.2,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                  ),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  Text(
                    'Remember Me',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 10.0),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Image display
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      20.0), // Adjust the radius as needed
                  child: Image.asset(
                    'assets/Main.jpg',
                    height: 350,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),

              // Adding the sliding section after the image
              const SizedBox(height: 20), // Adjust the spacing
              buildSlidingSection(),

              // Footer section
              const SizedBox(height: 30), // Add spacing above the footer
              // Footer section within _MyHomePageState class
              Center(
                child: Column(
                  children: [
                    Text(
                      'ReportCycle © 2023-2024',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Wrap(
                          spacing: 15, // Reduced space between each link
                          runSpacing: 5, // Reduced vertical space between rows
                          alignment:
                              WrapAlignment.center, // Center align all links
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text('About'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Accessibility'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('User Agreement'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Privacy Policy'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Cookie Policy'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Copyright Policy'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Brand Policy'),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: Colors.blue,
        onTap: (index) {},
      ),
    );
  }

  static Widget buildPage({
    required String title,
    required String text,
    required String imagePath,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title (appears first)
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent, // Red title text
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Spacing between title and image

            // Image (appears second)
            ClipOval(
              child: Image.asset(
                imagePath,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            const SizedBox(height: 20), // Spacing between image and text

            // Remaining text (appears last)
            Text(
              text,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSlidingSection() {
    return Container(
      // Adding a background color to match the style in your image
      decoration: BoxDecoration(
        color: const Color(
            0xFFF0F4FF), // Use a light background color similar to the image
      ),
      child: Column(
        children: [
          SizedBox(
            height: 450, // Adjust height based on your content
            child: PageView(
              controller: _pageController,
              children: _pages,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
          const SizedBox(height: 20), // Space between content and dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? Colors.blue
                      : Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

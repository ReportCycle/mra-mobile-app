import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'services/auth_service.dart'; // Import AuthService
import 'sign_up_form_screen.dart';
import 'about_screen.dart';
import 'accessibility_page.dart';
import 'privacy_policy_page.dart';
import 'cookie_policy_page.dart';
import 'copyright_policy_page.dart';
import 'brand_policy_page.dart';
import 'UserAgreementPage.dart';
import 'package:flutter/cupertino.dart';
import 'sign_in.dart';

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
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
          ),
        ),
      ),
      home: const SplashScreen(), // Start with SplashScreen
    );
  }
}

// Modernized and Accessible Splash Screen with Circular Loader
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation for the splash screen
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeats the circular progress animation

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Navigate to the Home Page after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                const MyHomePage(title: 'Report Cycle Home Page')),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular loader around the logo
            SizedBox(
              height: 200, // Adjust to fit around the logo
              width: 200,
              child: CircularProgressIndicator(
                valueColor: _controller.drive(ColorTween(
                  begin: CupertinoColors.systemGrey,
                  end: CupertinoColors.activeBlue,
                )),
                strokeWidth: 4, // Thickness of the circle
              ),
            ),
            // Faded logo inside the circular loader
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/Logo.png', // Replace with your logo asset
                height: 150, // Adjust size as needed
                width: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Home Screen Widget
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
  int _selectedIndex = 0;

  bool _isPasswordVisible = false;
  String _errorMessage = ''; // Error message state

  final AuthService _authService = AuthService(); // Create AuthService instance
  final TextEditingController _usernameController =
      TextEditingController(); // Username controller
  final TextEditingController _passwordController =
      TextEditingController(); // Password controller

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      buildPage(
        title: 'Empower your Community',
        text: "Spot issues? Report instantly with MyReportApp!",
        imagePath: 'assets/first.jpg',
      ),
      buildPage(
        title: 'Engage With Organizations',
        text: "Take action in your community with MyReportApp.",
        imagePath: 'assets/second.jpg',
      ),
      buildPage(
        title: 'Enhance Citizen Satisfaction',
        text: "MyReportApp is designed with happiness in mind.",
        imagePath: 'assets/third.jpg',
      ),
    ];

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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method to handle Sign In
  Future<void> _handleSignIn() async {
    String usernameOrEmail = _usernameController.text.trim();
    String password = _passwordController.text;

    // Call the login method from AuthService
    final result = await _authService.loginUser(usernameOrEmail, password);

    if (result['success']) {
      // Handle successful login
      final data = result['data'];
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const MyHomePage(
              title: 'Home Page'), // Replace with your home screen widget
        ),
      );
    } else {
      // Update error message based on response
      setState(() {
        _errorMessage = result['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final myAppState = context.findAncestorStateOfType<_MyAppState>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Report Cycle',
          style: TextStyle(
            color: myAppState?.isDarkMode ?? false
                ? CupertinoColors.white
                : CupertinoColors.black,
          ),
        ),
        trailing: CupertinoSwitch(
          value: myAppState?.isDarkMode ?? false,
          onChanged: (value) {
            myAppState?.toggleTheme();
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Logo and Sign Up/Sign In buttons
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Modernized logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      myAppState?.isDarkMode ?? false
                          ? 'assets/Logo-White.png'
                          : 'assets/Logo.png',
                      height: 60.0,
                      width: 60.0,
                      semanticLabel: 'Report Cycle Logo',
                    ),
                  ),
                  CupertinoButton.filled(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const SignUpFormScreen(),
                        ),
                      );
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    borderRadius: BorderRadius.circular(8.0),
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ),
            // Error Message Display
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemRed,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(CupertinoIcons.exclamationmark_circle_fill,
                          color: CupertinoColors.white),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Scrollable content below
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Message
                      Text(
                        'Welcome to your reporting assistant',
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle
                            .copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: myAppState?.isDarkMode ?? false
                                  ? CupertinoColors.white
                                  : CupertinoColors.activeBlue,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Sign in to your account',
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .textStyle
                            .copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: myAppState?.isDarkMode ?? false
                                  ? CupertinoColors.systemGrey
                                  : CupertinoColors.systemGrey,
                            ),
                        textAlign:
                            TextAlign.left, // Aligns the text to the left
                      ),
                      const SizedBox(height: 20),
                      // Username or Email Text Field
                      CupertinoTextField(
                        controller: _usernameController, // Controller added
                        placeholder: 'Username or Email',
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: myAppState?.isDarkMode ?? false
                              ? CupertinoColors.systemGrey
                              : CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        style: TextStyle(
                          color: myAppState?.isDarkMode ?? false
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            'Forgot username?',
                            style: TextStyle(
                              color: CupertinoColors.activeBlue,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Password Text Field
                      CupertinoTextField(
                        controller: _passwordController, // Controller added
                        placeholder: 'Password',
                        obscureText: !_isPasswordVisible,
                        suffix: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash,
                            color: myAppState?.isDarkMode ?? false
                                ? CupertinoColors.white
                                : CupertinoColors.systemGrey,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: myAppState?.isDarkMode ?? false
                              ? CupertinoColors.systemGrey
                              : CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        style: TextStyle(
                          color: myAppState?.isDarkMode ?? false
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: CupertinoColors.activeBlue,
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Sign In Button
                      Center(
                        child: CupertinoButton.filled(
                          onPressed: _handleSignIn,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          borderRadius: BorderRadius.circular(10.0),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Main Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'assets/Main.jpg',
                          height: 350,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 30),
                      buildSlidingSection(myAppState?.isDarkMode ?? false),
                      const SizedBox(height: 20),
                      buildFooterLinks(context),
                    ],
                  ),
                ),
              ),
            ),
            buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  static Widget buildPage({
    required String title,
    required String text,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.activeBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ClipOval(
            child: Image.asset(
              imagePath,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Sliding section for additional pages
  Widget buildSlidingSection(bool isDarkMode) {
    return Container(
      color: isDarkMode
          ? CupertinoColors.darkBackgroundGray
          : CupertinoColors.systemGrey6,
      child: Column(
        children: [
          SizedBox(
            height: 450,
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
          const SizedBox(height: 20),
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
                      ? CupertinoColors.activeBlue
                      : isDarkMode
                          ? CupertinoColors.systemGrey
                          : CupertinoColors.inactiveGray,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Footer links widget following Apple's design guidelines
  Widget buildFooterLinks(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Center(
          child: Column(
            children: [
              Text(
                'ReportCycle © 2023-2024',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
              ),
              const SizedBox(height: 15),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const AboutPage()),
                          );
                        },
                        child: const Text(
                          'About',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const AccessibilityPage()),
                          );
                        },
                        child: const Text(
                          'Accessibility',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const PrivacyPolicyPage()),
                          );
                        },
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const CookiePolicyPage()),
                          );
                        },
                        child: const Text(
                          'Cookie Policy',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const CopyrightPolicyPage()),
                          );
                        },
                        child: const Text(
                          'Copyright Policy',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const BrandPolicyPage()),
                          );
                        },
                        child: const Text(
                          'Brand Policy',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                    const UserAgreementPage()),
                          );
                        },
                        child: const Text(
                          'User Agreement',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  // Build bottom navigation bar
  Widget buildBottomNavBar() {
    return CupertinoTabBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.news),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.ticket),
          label: 'Tickets',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.qrcode),
          label: 'QR Codes',
        ),
      ],
    );
  }
}

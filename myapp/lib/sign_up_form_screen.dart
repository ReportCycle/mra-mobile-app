import 'dart:math';
import 'package:flutter/cupertino.dart';

class SignUpFormScreen extends StatefulWidget {
  const SignUpFormScreen({super.key});

  @override
  _SignUpFormScreenState createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  bool isDarkMode = false;
  bool isPasswordVisible = false;
  bool isRepeatPasswordVisible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  // Random Username and Password Generator
  void generateRandomCredentials() {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    String randomUsername = List.generate(8, (index) {
      return characters[Random().nextInt(characters.length)];
    }).join('');

    const passwordChars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#\$%^&*()';
    String randomPassword = List.generate(12, (index) {
      return passwordChars[Random().nextInt(passwordChars.length)];
    }).join('');

    usernameController.text = randomUsername;
    passwordController.text = randomPassword;
    repeatPasswordController.text = randomPassword;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
        barBackgroundColor:
            isDarkMode ? CupertinoColors.black : CupertinoColors.systemGrey6,
      ),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context); // Custom back action
            },
            child: Icon(
              CupertinoIcons.back, // Using Cupertino back icon
              color: isDarkMode
                  ? CupertinoColors.white
                  : CupertinoColors.activeBlue,
            ),
          ),
          middle: Text(
            'Create Account',
            style: TextStyle(
              color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
              fontSize: 20,
            ),
          ),
          trailing: CupertinoSwitch(
            value: isDarkMode,
            onChanged: (bool value) {
              toggleTheme();
            },
          ),
          backgroundColor: isDarkMode
              ? CupertinoColors.systemGrey.withOpacity(0.5)
              : CupertinoColors.systemGrey6,
          border: null,
        ),
        child: SafeArea(
          child: CupertinoScrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  // Main Header
                  Text(
                    'Create Your Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode
                          ? CupertinoColors.white
                          : CupertinoColors.activeBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join our community and experience smart city solutions!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode
                          ? CupertinoColors.systemGrey
                          : CupertinoColors.systemGrey2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Username Field with Random Generator Icon (aligned inside)
                  _buildModernCupertinoTextField(
                    placeholder: 'Username',
                    isDarkMode: isDarkMode,
                    isPassword: false,
                    controller: usernameController,
                    suffix: GestureDetector(
                      onTap: generateRandomCredentials,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(CupertinoIcons.shuffle,
                            color: CupertinoColors.activeBlue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Display Name Field
                  _buildModernCupertinoTextField(
                    placeholder: 'Display Name (Optional)',
                    isDarkMode: isDarkMode,
                    isPassword: false,
                  ),
                  const SizedBox(height: 16),
                  // Email Field
                  _buildModernCupertinoTextField(
                    placeholder: 'Email',
                    isDarkMode: isDarkMode,
                    isPassword: false,
                  ),
                  const SizedBox(height: 16),
                  // Password Field with Show/Hide Icon (aligned inside)
                  _buildModernCupertinoTextField(
                    placeholder: 'Password',
                    isDarkMode: isDarkMode,
                    isPassword: !isPasswordVisible,
                    controller: passwordController,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          isPasswordVisible
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Repeat Password Field with Show/Hide Icon (aligned inside)
                  _buildModernCupertinoTextField(
                    placeholder: 'Repeat Password',
                    isDarkMode: isDarkMode,
                    isPassword: !isRepeatPasswordVisible,
                    controller: repeatPasswordController,
                    suffix: GestureDetector(
                      onTap: () {
                        setState(() {
                          isRepeatPasswordVisible = !isRepeatPasswordVisible;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          isRepeatPasswordVisible
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Sign Up Button
                  CupertinoButton.filled(
                    onPressed: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: const Text('Agree & Sign Up'),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: CupertinoButton(
                      child: const Text(
                        'Already have an account? Sign in',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Cupertino Text Field with Suffix Icon for Username/Password
  Widget _buildModernCupertinoTextField({
    required String placeholder,
    required bool isDarkMode,
    required bool isPassword,
    TextEditingController? controller,
    Widget? suffix,
  }) {
    return CupertinoTextField(
      controller: controller,
      obscureText: isPassword,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      placeholder: placeholder,
      placeholderStyle: TextStyle(
        color: isDarkMode
            ? CupertinoColors.systemGrey
            : CupertinoColors.systemGrey3,
      ),
      style: TextStyle(
        color: isDarkMode ? CupertinoColors.white : CupertinoColors.black,
        fontSize: 18,
      ),
      suffix: suffix, // Suffix icon aligned within the input field
      decoration: BoxDecoration(
        color: isDarkMode
            ? CupertinoColors.darkBackgroundGray
            : CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

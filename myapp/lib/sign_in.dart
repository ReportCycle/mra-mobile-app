import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _authService = AuthService(); // Create AuthService instance
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Method to handle Sign In
  Future<void> _handleSignIn() async {
    String usernameOrEmail = _usernameController.text.trim();
    String password = _passwordController.text;

    // Call the login method from AuthService
    final result = await _authService.loginUser(usernameOrEmail, password);

    // Handle login success or failure
    if (result['success']) {
      final data = result['data'];

      // Display detailed information in an alert dialog
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Login Successful'),
          content: Column(
            children: [
              Text('Welcome back, ${data['displayName']}!'),
              SizedBox(height: 10),
              Text('Token: ${data['token']}'),
              Text('Expiration: ${data['exp']}'),
              Text('User ID: ${data['userId']}'),
              Text('Profile Picture URL: ${data['profilePictureUrl']}'),
              Text('Is Private Picture: ${data['isPrivatePicture']}'),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Navigate to the next screen here
              },
            ),
          ],
        ),
      );
    } else {
      // Handle login failure with a message
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text('Login Failed'),
          content: Text(result['message']),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Sign In'),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username Field
            CupertinoTextField(
              controller: _usernameController,
              placeholder: 'Username or Email',
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            SizedBox(height: 10),

            // Password Field
            CupertinoTextField(
              controller: _passwordController,
              placeholder: 'Password',
              obscureText: !_isPasswordVisible,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(10.0),
              ),
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
                ),
              ),
            ),
            SizedBox(height: 20),

            // Sign In Button
            CupertinoButton.filled(
              onPressed: _handleSignIn,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              borderRadius: BorderRadius.circular(10.0),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

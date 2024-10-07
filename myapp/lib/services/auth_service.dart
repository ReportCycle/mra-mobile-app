import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String _baseUrl = 'https://auth.reportcycle.com';

  // Method to handle user login
  Future<Map<String, dynamic>> loginUser(
      String usernameOrEmail, String password) async {
    final String apiUrl = '$_baseUrl/v1/login';

    Map<String, String> body = {
      "usernameOrEmail": usernameOrEmail,
      "password": password,
    };

    try {
      // Log the request details for debugging purposes
      print('Attempting login...');
      print('URL: $apiUrl');
      print('Request Headers: Content-Type: application/json');
      print('Request Body: ${jsonEncode(body)}');

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      // Log the response details for debugging purposes
      print('Response Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Body: ${response.body}');

      // Check for various status codes and return appropriate messages
      switch (response.statusCode) {
        case 200:
          // Successful login
          print('Login successful!');
          return {
            'success': true,
            'data': jsonDecode(response.body),
          };

        case 400:
          // Validation error
          final errors = jsonDecode(response.body)['errors'];
          String errorMessages = errors.map((error) => error['msg']).join(', ');
          return {
            'success': false,
            'errorType': 'validation',
            'message': errorMessages,
          };

        case 401:
          // Unauthorized - Invalid credentials
          return {
            'success': false,
            'errorType': 'unauthorized',
            'message': 'Username or password is incorrect.',
          };

        case 429:
          // Too many requests
          return {
            'success': false,
            'errorType': 'rate_limit',
            'message':
                'Too many requests from this IP, please try again after some time.',
          };

        case 500:
          // Internal server error
          return {
            'success': false,
            'errorType': 'server_error',
            'message':
                'An internal server error occurred. Please try again later.',
          };

        default:
          // Unexpected status code
          return {
            'success': false,
            'errorType': 'unexpected',
            'message': 'An unexpected error occurred. Please try again.',
          };
      }
    } catch (error) {
      // Handle any network or unexpected errors
      print('An error occurred during login: $error');
      return {
        'success': false,
        'errorType': 'network',
        'message':
            'A network error occurred. Please check your connection and try again.',
      };
    }
  }
}

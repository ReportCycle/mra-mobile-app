import 'package:flutter/material.dart';

Widget buildFooter() {
  return Column(
    children: [
      const Text(
        'ReportCycle © 2023-2024',
        style: TextStyle(fontSize: 12),
      ),
      const SizedBox(height: 10),
      LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            spacing: 15,
            runSpacing: 5,
            alignment: WrapAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // Add navigation or functionality here
                },
                child: const Text('About'), // Constant Text
              ),
              TextButton(
                onPressed: () {
                  // Add navigation or functionality here
                },
                child: const Text('Accessibility'), // Constant Text
              ),
              TextButton(
                onPressed: () {
                  // Add navigation or functionality here
                },
                child: const Text('User Agreement'), // Constant Text
              ),
              TextButton(
                onPressed: () {
                  // Add navigation or functionality here
                },
                child: const Text('Privacy Policy'), // Constant Text
              ),
              TextButton(
                onPressed: () {
                  // Add navigation or functionality here
                },
                child: const Text('Cookie Policy'), // Constant Text
              ),
              TextButton(
                onPressed: () {
                  // Add navigation or functionality here
                },
                child: const Text('Copyright Policy'), // Constant Text
              ),
              TextButton(
                onPressed: () {
                  // Add navigation or functionality here
                },
                child: const Text('Brand Policy'), // Constant Text
              ),
            ],
          );
        },
      ),
    ],
  );
}

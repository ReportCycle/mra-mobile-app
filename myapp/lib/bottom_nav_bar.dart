
import 'package:flutter/material.dart';

Widget buildBottomNavigationBar() {
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
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    onTap: (index) {
      // Handle navigation between pages
    },
  );
}

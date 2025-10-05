import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 40,
          ),
          const SizedBox(width: 10),
          const Text(
            'Football Fraternity Co, Ltd.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      elevation: 0,
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.notifications),
      //     onPressed: () {},
      //   ),
      //   IconButton(
      //     icon: const Icon(Icons.account_circle),
      //     onPressed: () {
      //       Navigator.pushNamed(context, '/profile');
      //     },
      //   ),
      // ],
    );
  }
}
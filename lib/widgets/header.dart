import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/responsive.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: (Responsive.isDesktop(context) || Responsive.isTablet(context)) ? 40 : 30,
          ),
          SizedBox(width: (Responsive.isDesktop(context) || Responsive.isTablet(context)) ? 10 : 5),
          Text(
            'Football Fraternity Co, Ltd',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: (Responsive.isDesktop(context) || Responsive.isTablet(context)) ? 20 : 16,
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
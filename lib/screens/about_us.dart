import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Football Fraternity Co, Ltd.',
              style: AppStyles.heading1,
            ),
            const SizedBox(height: 20),
            const Text(
              'Football Fraternity Co, Ltd. is a premier sports management and legal consultancy firm specializing in football. '
              'We provide comprehensive services to footballers, clubs, and other stakeholders in the football industry.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Text(
              'Our Mission',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            const Text(
              'To provide exceptional legal and management services to football professionals, '
              'ensuring their careers are protected and their potential maximized.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Text(
              'Our Vision',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            const Text(
              'To be the leading football management and legal consultancy firm in the region, '
              'recognized for our professionalism, integrity, and commitment to our clients.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Text(
              'Our Team',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            const Text(
              'Our team consists of experienced legal professionals, former footballers, '
              'and sports management experts who are passionate about the game and dedicated to our clients.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Why Choose Us?',
                    style: AppStyles.heading2,
                  ),
                  const SizedBox(height: 10),
                  const ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Specialized football legal expertise'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Personalized management services'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Proven track record with footballers'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.check_circle, color: Colors.green),
                    title: Text('Transparent and ethical practices'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Services',
              style: AppStyles.heading1,
            ),
            const SizedBox(height: 20),
            const Text(
              'Football Fraternity Co, Ltd. offers comprehensive services to football professionals and clubs.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.gavel, size: 40, color: AppColors.primary),
                      title: Text(
                        'Legal Consultancy',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text('Expert advice on football contracts and regulations'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.people, size: 40, color: AppColors.primary),
                      title: Text(
                        'Footballers Management',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text('Comprehensive career management for professional footballers'),
                    ),
                    const Divider(),
                    const ListTile(
                      leading: Icon(Icons.assignment, size: 40, color: AppColors.primary),
                      title: Text(
                        'Contract Negotiation',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text('Professional representation in contract discussions'),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/legal-services');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'View All Services',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Request a Service',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildServiceAction(
                  context,
                  'Consultancy',
                  Icons.gavel,
                  '/legal-services/consultancy',
                ),
                _buildServiceAction(
                  context,
                  'Representation',
                  Icons.people,
                  '/legal-services/representation',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceAction(
      BuildContext context, String title, IconData icon, String route) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: AppColors.primary),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
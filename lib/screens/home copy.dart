import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Football Fraternity',
            style: AppStyles.heading1,
          ),
          const SizedBox(height: 10),
          const Text(
            'Your trusted partner for football management and legal services',
          ),
          const SizedBox(height: 30),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quick Actions',
                        style: AppStyles.heading2,
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _buildActionCard(
                        context,
                        Icons.people,
                        'Footballers',
                        AppColors.primary,
                        '/footballers',
                      ),
                      _buildActionCard(
                        context,
                        Icons.assignment,
                        'Contracts',
                        Colors.orange,
                        '/contracts',
                      ),
                      _buildActionCard(
                        context,
                        Icons.gavel,
                        'Legal Cases',
                        Colors.purple,
                        '/cases',
                      ),
                      _buildActionCard(
                        context,
                        Icons.calendar_today,
                        'Appointments',
                        Colors.teal,
                        '/appointments',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Recent Activities',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.assignment),
            ),
            title: const Text('New contract signed with John Doe'),
            subtitle: const Text('2 hours ago'),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.gavel),
            ),
            title: const Text('Case update: Contract dispute with City FC'),
            subtitle: const Text('1 day ago'),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.calendar_today),
            ),
            title: const Text('Upcoming appointment with Legal Officer'),
            subtitle: const Text('Tomorrow at 10:00 AM'),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
      BuildContext context, IconData icon, String title, Color color, String route) {
    return Card(
      elevation: 2,
      color: color.withOpacity(0.1),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColors.primary.withOpacity(0.8),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                ),
                const SizedBox(height: 10),
                Text(
                  'Football Fraternity',
                  style: AppStyles.heading2.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  'Management System',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildMenuSection(
            title: 'Dashboard',
            icon: Icons.dashboard,
            onTap: () => _navigateTo(context, '/'),
          ),
          _buildMenuSection(
            title: 'Footballers',
            icon: Icons.people,
            onTap: () => _navigateTo(context, '/footballers'),
          ),
          _buildMenuSection(
            title: 'Contracts',
            icon: Icons.assignment,
            onTap: () => _navigateTo(context, '/contracts'),
          ),
          _buildMenuSection(
            title: 'Legal Cases',
            icon: Icons.gavel,
            onTap: () => _navigateTo(context, '/cases'),
          ),
          _buildMenuSection(
            title: 'Appointments',
            icon: Icons.calendar_today,
            onTap: () => _navigateTo(context, '/appointments'),
          ),
          _buildMenuSection(
            title: 'Documents',
            icon: Icons.insert_drive_file,
            onTap: () => _navigateTo(context, '/documents'),
          ),
          _buildMenuSection(
            title: 'Messages',
            icon: Icons.message,
            onTap: () => _navigateTo(context, '/messages'),
          ),
          const Divider(),
          _buildMenuSection(
            title: 'Services',
            icon: Icons.work,
            onTap: () => _navigateTo(context, '/services'),
          ),
          _buildMenuSection(
            title: 'About Us',
            icon: Icons.info,
            onTap: () => _navigateTo(context, '/about-us'),
          ),
          const Divider(),
          _buildMenuSection(
            title: 'Profile',
            icon: Icons.person,
            onTap: () => _navigateTo(context, '/profile'),
          ),
          _buildMenuSection(
            title: 'Settings',
            icon: Icons.settings,
            onTap: () {},
          ),
          _buildMenuSection(
            title: 'Logout',
            icon: Icons.logout,
            onTap: () {
              // Implement logout
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }
}
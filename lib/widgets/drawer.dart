import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Football Fraternity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.blue
            ),
            title: const Text('About Us'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/about-us');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.work,
              color: Colors.blue
            ),
            title: const Text('Services'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/services');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.contact_phone,
              color: Colors.blue
            ),
            title: const Text('Our Contacts'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/contacts');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.message,
              color: Colors.blue
            ),
            title: const Text('Messages'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/messages');
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Footballers Management',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.people,
              color: Colors.green,
            ),
            title: const Text('Footballers'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/footballers');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.assignment,
              color: Colors.green
            ),
            title: const Text('Contracts'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/contracts');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.gavel,
              color: Colors.green
            ),
            title: const Text('Legal Cases'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/cases');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.calendar_today,
              color: Colors.green
            ),
            title: const Text('Appointments'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/appointments');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.attach_file,
              color: Colors.green,
            ),
            title: const Text('Documents'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/documents');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: const Text('Logout'),
            onTap: () {
              // Implement logout functionality
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
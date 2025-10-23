import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int userId = 0;

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
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.blue
            ),
            title: const Text('About Us'),
            onTap: () {
              context.go('/about-us');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.work,
              color: Colors.blue
            ),
            title: const Text('Services'),
            onTap: () {
              context.go('/services');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.contact_phone,
              color: Colors.blue
            ),
            title: const Text('Our Contacts'),
            onTap: () {
              context.go('/contacts');
            },
          ),
          if(userId != 0)
          ListTile(
            leading: const Icon(
              Icons.message,
              color: Colors.blue
            ),
            title: const Text('Messages'),
            onTap: () {
              context.go('/messages');
            },
          ),
          if(userId != 0)
          Column(
            children: [
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
                  context.go('/footballers');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.assignment,
                  color: Colors.green
                ),
                title: const Text('Contracts'),
                onTap: () {
                  context.go('/contracts');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.gavel,
                  color: Colors.green
                ),
                title: const Text('Legal Cases'),
                onTap: () {
                  context.go('/cases');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.calendar_today,
                  color: Colors.green
                ),
                title: const Text('Appointments'),
                onTap: () {
                  context.go('/appointments');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.attach_file,
                  color: Colors.green,
                ),
                title: const Text('Documents'),
                onTap: () {
                  context.go('/documents');
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
          )
        ],
      ),
    );
  }
}
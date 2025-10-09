import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:football_fraternity/widgets/drawer.dart';
import 'package:football_fraternity/widgets/header.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  Widget _buildDesktopNavBar(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 80 : 40,
        vertical: 15,
      ),
      child: Row(
        children: [
          const Spacer(),
          _buildNavLink(context, 'Home', '/'),
          _buildNavLink(context, 'About Us', '/about-us'),
          _buildNavLink(context, 'Services', '/services'),
          _buildNavLink(context, 'Contacts', '/contacts'),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String text, String route) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 20 : 15,
      ),
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.isDesktop(context) ? 18 : 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceList() {
    return const Column(
      children: [
        ListTile(
          leading: Icon(Icons.gavel, size: 40, color: AppColors.primary),
          title: Text(
            'Legal Consultancy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text('Expert advice on football contracts and regulations'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.people, size: 40, color: AppColors.primary),
          title: Text(
            'Footballers Management',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text('Comprehensive career management for professional footballers'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.assignment, size: 40, color: AppColors.primary),
          title: Text(
            'Contract Negotiation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text('Professional representation in contract discussions'),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Services',
            style: AppStyles.heading1,
          ),
          const SizedBox(height: 20),
          const Text(
            'Football Fraternity Co, Ltd. offers comprehensive services to football professionals and clubs.',
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 40),
          
          // Desktop layout with services on left and actions on right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Services List - takes 2/3 of space
              Expanded(
                flex: 2,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        _buildServiceList(),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/legal-services');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'View All Services',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 40),
              
              // Service Actions - takes 1/3 of space
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request a Service',
                      style: AppStyles.heading2,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        _buildServiceActionCard(
                          context,
                          'Consultancy',
                          Icons.gavel,
                          '/legal-services/consultancy',
                        ),
                        const SizedBox(height: 16),
                        _buildServiceActionCard(
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Services',
            style: AppStyles.heading1,
          ),
          const SizedBox(height: 16),
          const Text(
            'Football Fraternity Co, Ltd. offers comprehensive services to football professionals and clubs.',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 24),
          
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildServiceList(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/legal-services');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'View All Services',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          const Text(
            'Request a Service',
            style: AppStyles.heading2,
          ),
          const SizedBox(height: 16),
          
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: Responsive.isTablet(context) ? 3 : 2,
            childAspectRatio: Responsive.isTablet(context) ? 1.2 : 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
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
    );
  }

  Widget _buildServiceActionCard(
      BuildContext context, String title, IconData icon, String route) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: AppColors.primary),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Icon(Icons.arrow_forward, size: 20, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceAction(
      BuildContext context, String title, IconData icon, String route) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: AppColors.primary),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) _buildDesktopNavBar(context),
            
            // Responsive layout
            if (Responsive.isDesktop(context)) 
              _buildDesktopLayout(context)
            else 
              _buildMobileLayout(context),
          ],
        ),
      ),
    );
  }
}
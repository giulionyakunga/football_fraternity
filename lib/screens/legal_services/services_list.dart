import 'package:flutter/material.dart';
import 'package:football_fraternity/models/service.dart';
import 'package:football_fraternity/widgets/service_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class LegalServicesListScreen extends StatelessWidget {
  const LegalServicesListScreen({super.key});

  final List<Service> services = const [
    Service(
      id: '1',
      title: 'Legal Consultancy',
      description: 'Expert advice on football contracts, transfers, and disputes',
      icon: 'legal',
      features: [
        'Contract review and analysis',
        'Transfer advice',
        'Dispute resolution guidance',
        'Compliance with regulations',
      ],
      formRoute: '/legal-services/consultancy',
    ),
    Service(
      id: '2',
      title: 'Legal Representation',
      description: 'Professional representation in negotiations and legal proceedings',
      icon: 'gavel',
      features: [
        'Contract negotiations',
        'Dispute resolution',
        'Tribunal representation',
        'Mediation services',
      ],
      formRoute: '/legal-services/representation',
    ),
    Service(
      id: '3',
      title: 'Footballers Management',
      description: 'Comprehensive management services for professional footballers',
      icon: 'people',
      features: [
        'Contract management',
        'Career planning',
        'Financial advisory',
        'Image rights management',
      ],
      formRoute: '/legal-services/footballer_management_form',
    ),
    Service(
      id: '4',
      title: 'Contract Drafting',
      description: 'Professional drafting and review of football-related contracts',
      icon: 'description',
      features: [
        'Player contracts',
        'Sponsorship agreements',
        'Transfer documents',
        'Endorsement deals',
      ],
      formRoute: '/legal-services/consultancy',
    ),
    Service(
      id: '5',
      title: 'Dispute Resolution',
      description: 'Specialized resolution of football-related disputes and conflicts',
      icon: 'balance',
      features: [
        'Arbitration proceedings',
        'Mediation services',
        'Disciplinary hearings',
        'Appeal processes',
      ],
      formRoute: '/legal-services/representation',
    ),
    Service(
      id: '6',
      title: 'Regulatory Compliance',
      description: 'Ensuring compliance with football governing body regulations',
      icon: 'policy',
      features: [
        'FIFA regulations',
        'League compliance',
        'Agent regulations',
        'Financial fair play',
      ],
      formRoute: '/legal-services/consultancy',
    ),
  ];

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Center(
            child: Column(
              children: [
                Text(
                  'Our Legal Services',
                  style: AppStyles.heading1.copyWith(
                    fontSize: 42,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Comprehensive legal solutions tailored for the football industry',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),

          // Services Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1.1,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return ServiceCard(service: services[index]);
            },
          ),
          const SizedBox(height: 40),

          // Call to Action Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.9),
                  AppColors.primary.withOpacity(0.7),
                ],
              ),
              // borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  'Need Custom Legal Assistance?',
                  style: AppStyles.heading2.copyWith(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Contact us for personalized legal solutions tailored to your specific needs in the football industry.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to contact page
                    context.go('/contacts');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Get In Touch',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Legal Services',
                style: AppStyles.heading1.copyWith(
                  fontSize: 32,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Comprehensive legal solutions tailored for the football industry',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 80,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Services List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return ServiceCard(service: services[index]);
            },
          ),
          const SizedBox(height: 30),

          // Call to Action Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.9),
                  AppColors.primary.withOpacity(0.7),
                ],
              ),
              // borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  'Need Custom Legal Assistance?',
                  style: AppStyles.heading2.copyWith(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Contact us for personalized legal solutions tailored to your specific needs.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to contact page
                    context.go('/contacts');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Get In Touch',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Center(
            child: Column(
              children: [
                Text(
                  'Our Legal Services',
                  style: AppStyles.heading1.copyWith(
                    fontSize: 36,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Comprehensive legal solutions tailored for the football industry',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  width: 90,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Services Grid for Tablet
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.9,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return ServiceCard(service: services[index]);
            },
          ),
          const SizedBox(height: 40),

          // Call to Action Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withOpacity(0.9),
                  AppColors.primary.withOpacity(0.7),
                ],
              ),
              // borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  'Need Custom Legal Assistance?',
                  style: AppStyles.heading2.copyWith(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Contact us for personalized legal solutions tailored to your specific needs in the football industry.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to contact page
                    context.go('/contacts');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Get In Touch',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our Legal Services',
          style: TextStyle(
            fontSize: Responsive.isDesktop(context) ? 20 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: !Responsive.isDesktop(context),
      ),
      body: Responsive.isDesktop(context)
          ? _buildDesktopLayout(context)
          : Responsive.isTablet(context)
              ? _buildTabletLayout(context)
              : _buildMobileLayout(context),
    );
  }
}
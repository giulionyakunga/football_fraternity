import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:football_fraternity/widgets/drawer.dart';
import 'package:football_fraternity/widgets/header.dart';
import 'package:go_router/go_router.dart';


class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  int userId = 0;

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
          if(userId != 0)
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
        onPressed: () => context.go(route),
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

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Center(
            child: Column(
              children: [
                Text(
                  'About Football Fraternity Co, Ltd.',
                  style: AppStyles.heading1.copyWith(
                    fontSize: 36,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 800,
                  child: Text(
                    'Football Fraternity Co, Ltd. is a premier sports management and legal consultancy firm specializing in football. '
                    'We provide comprehensive services to footballers, clubs, and other stakeholders in the football industry.',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),

          // Mission and Vision Side by Side
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInfoCard(
                  context,
                  Icons.flag,
                  'Our Mission',
                  'To provide exceptional legal and management services to football professionals, '
                  'ensuring their careers are protected and their potential maximized.',
                  Colors.blue[700]!,
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: _buildInfoCard(
                  context,
                  Icons.visibility,
                  'Our Vision',
                  'To be the leading football management and legal consultancy firm in the region, '
                  'recognized for our professionalism, integrity, and commitment to our clients.',
                  Colors.green[700]!,
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),

          // Team Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Our Team',
                      style: AppStyles.heading2.copyWith(fontSize: 28),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Our team consists of experienced legal professionals, former footballers, '
                      'and sports management experts who are passionate about the game and dedicated to our clients.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildTeamMember(
                      'Legal Experts',
                      'Specialized football lawyers with years of experience in contract law and dispute resolution',
                      Icons.gavel,
                    ),
                    _buildTeamMember(
                      'Former Footballers',
                      'Ex-professional players who understand the industry from the inside',
                      Icons.sports_soccer,
                    ),
                    _buildTeamMember(
                      'Management Professionals',
                      'Experienced managers dedicated to player career development',
                      Icons.people,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 1,
                child: _buildWhyChooseUs(context),
              ),
            ],
          ),
          const SizedBox(height: 60),

          // Values Section
          Center(
            child: Column(
              children: [
                Text(
                  'Our Core Values',
                  style: AppStyles.heading2.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildValueItem(
                      Icons.security,
                      'Integrity',
                      'We maintain the highest ethical standards in all our dealings',
                    ),
                    const SizedBox(width: 20),
                    _buildValueItem(
                      Icons.school,
                      'Expertise',
                      'Deep knowledge of football law and industry practices',
                    ),
                    const SizedBox(width: 20),
                    _buildValueItem(
                      Icons.people,
                      'Client Focus',
                      'Your success and satisfaction are our top priorities',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isTablet(context) ? 40 : 20,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Text(
            'About Football Fraternity Co, Ltd.',
            style: AppStyles.heading1.copyWith(
              fontSize: Responsive.isTablet(context) ? 28 : 24,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Football Fraternity Co, Ltd. is a premier sports management and legal consultancy firm specializing in football. '
            'We provide comprehensive services to footballers, clubs, and other stakeholders in the football industry.',
            style: TextStyle(
              fontSize: Responsive.isTablet(context) ? 16 : 15,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),

          // Mission
          _buildInfoCard(
            context,
            Icons.flag,
            'Our Mission',
            'To provide exceptional legal and management services to football professionals, '
            'ensuring their careers are protected and their potential maximized.',
            Colors.blue[700]!,
          ),
          const SizedBox(height: 30),

          // Vision
          _buildInfoCard(
            context,
            Icons.visibility,
            'Our Vision',
            'To be the leading football management and legal consultancy firm in the region, '
            'recognized for our professionalism, integrity, and commitment to our clients.',
            Colors.green[700]!,
          ),
          const SizedBox(height: 40),

          // Team Section
          Text(
            'Our Team',
            style: AppStyles.heading2.copyWith(
              fontSize: Responsive.isTablet(context) ? 24 : 22,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Our team consists of experienced legal professionals, former footballers, '
            'and sports management experts who are passionate about the game and dedicated to our clients.',
            style: TextStyle(
              fontSize: Responsive.isTablet(context) ? 16 : 15,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),

          // Team Members
          _buildTeamMember(
            'Legal Experts',
            'Specialized football lawyers with years of experience in contract law and dispute resolution',
            Icons.gavel,
          ),
          _buildTeamMember(
            'Former Footballers',
            'Ex-professional players who understand the industry from the inside',
            Icons.sports_soccer,
          ),
          _buildTeamMember(
            'Management Professionals',
            'Experienced managers dedicated to player career development',
            Icons.people,
          ),
          const SizedBox(height: 40),

          // Why Choose Us
          _buildWhyChooseUs(context),
          const SizedBox(height: 40),

          // Values Section
          Text(
            'Our Core Values',
            style: AppStyles.heading2.copyWith(
              fontSize: Responsive.isTablet(context) ? 24 : 22,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              _buildValueItem(
                Icons.security,
                'Integrity',
                'We maintain the highest ethical standards in all our dealings',
              ),
              const SizedBox(height: 20),
              _buildValueItem(
                Icons.school,
                'Expertise',
                'Deep knowledge of football law and industry practices',
              ),
              const SizedBox(height: 20),
              _buildValueItem(
                Icons.people,
                'Client Focus',
                'Your success and satisfaction are our top priorities',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String title, String content, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.isDesktop(context) ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(
                fontSize: Responsive.isDesktop(context) ? 16 : 15,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueItem(IconData icon, String title, String description) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyChooseUs(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber[700],
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  'Why Choose Us?',
                  style: AppStyles.heading2.copyWith(
                    fontSize: Responsive.isDesktop(context) ? 28 : 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildFeatureItem(
              'Specialized football legal expertise',
              'Deep understanding of football-specific legal challenges',
            ),
            _buildFeatureItem(
              'Personalized management services',
              'Tailored approach for each client\'s unique needs',
            ),
            _buildFeatureItem(
              'Proven track record with footballers',
              'Successful representation of numerous professional players',
            ),
            _buildFeatureItem(
              'Transparent and ethical practices',
              'Clear communication and honest advice always',
            ),
            _buildFeatureItem(
              'Comprehensive career support',
              'End-to-end management from contracts to career planning',
            ),
            _buildFeatureItem(
              'Industry connections',
              'Strong network within football clubs and associations',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green[600],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
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
            Responsive.isDesktop(context)
                ? _buildDesktopLayout(context)
                : _buildMobileLayout(context),
          ],
        ),
      ),
    );
  }
}
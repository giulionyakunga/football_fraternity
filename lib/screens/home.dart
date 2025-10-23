import 'package:flutter/material.dart';
import 'package:football_fraternity/screens/services.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int userId = 0;
  final List<String> slideImages = [
    'assets/images/stadium1.jpg',
    'assets/images/stadium2.jpg',
    'assets/images/stadium3.jpg',
  ];
  int _currentSlide = 0;
  late Timer _timer;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentSlide = (_currentSlide + 1) % slideImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

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
            onPressed: () => context.go('/profile'),
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
    return Column(
      children: [
        // Hero Section with Slideshow
        SizedBox(
          height: 600,
          child: _buildSlideshow(),
        ),
        
        // Main Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
          child: Column(
            children: [
              // Quick Actions Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildQuickActions(context),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 1,
                    child: _buildRecentActivities(),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              
              // Features Section
              _buildFeaturesSection(),
              const SizedBox(height: 60),
              
              // Stats Section
              _buildStatsSection(),
            ],
          ),
        ),

        const SizedBox(height: 100),
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
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Hero Section with Slideshow
        SizedBox(
          height: Responsive.isMobile(context) ? 400 : 500,
          child: _buildSlideshow(),
        ),
        
        // Main Content
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isTablet(context) ? 40 : 20,
            vertical: 30,
          ),
          child: Column(
            children: [
              _buildQuickActions(context),
              const SizedBox(height: 40),
              _buildRecentActivities(),
              const SizedBox(height: 40),
              _buildFeaturesSection(),
              const SizedBox(height: 40),
              _buildStatsSection(),
            ],
          ),
        ),
        const SizedBox(height: 50),
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
      ],
    );
  }

  Widget _buildSlideshow() {
    return Stack(
      children: [
        // Slide Images
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Container(
            key: ValueKey<String>(slideImages[_currentSlide]),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(slideImages[_currentSlide]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
        ),
        
        // Welcome text
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Football Fraternity',
                  style: AppStyles.heading1.copyWith(
                    color: Colors.white,
                    fontSize: Responsive.isDesktop(context) ? 56 : 
                             Responsive.isTablet(context) ? 42 : 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: Responsive.isDesktop(context) ? 800 : 
                         Responsive.isTablet(context) ? 600 : double.infinity,
                  child: Text(
                    'Your trusted partner for football management and legal services',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Responsive.isDesktop(context) ? 24 : 
                               Responsive.isTablet(context) ? 20 : 18,
                      height: 1.5,
                      fontWeight: FontWeight.w300,
                      shadows: [
                        Shadow(
                          blurRadius: 5,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go('/services'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.isDesktop(context) ? 32 : Responsive.isTablet(context) ? 32 : 16,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        'Explore Our Services',
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context) ? 18 : Responsive.isTablet(context) ? 16 : 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: Responsive.isDesktop(context) ? 20 : Responsive.isTablet(context) ? 20 : 10),
                    OutlinedButton(
                      onPressed: () => context.go('/contacts'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.isDesktop(context) ? 32 : Responsive.isTablet(context) ? 32 : 16,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context) ? 18 : Responsive.isTablet(context) ? 16 : 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        // Slide indicators
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              slideImages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: _currentSlide == index ? 30 : 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _currentSlide == index
                      ? AppColors.primary
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quick Actions',
                  style: AppStyles.heading2.copyWith(
                    fontSize: Responsive.isDesktop(context) ? 28 : 24,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: Responsive.isDesktop(context) ? 4 : Responsive.isTablet(context) ? 3 : 1,
              childAspectRatio: Responsive.isDesktop(context) ? 0.7 : Responsive.isTablet(context) ? 0.9 : 1.1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildActionCard(
                  context,
                  Icons.people,
                  'Footballers',
                  (userId == 0) ? 'See our player profiles and careers' : 'Manage player profiles and careers',
                  AppColors.primary,
                  '/footballers',
                ),
                // _buildActionCard(
                //   context,
                //   Icons.assignment,
                //   'Contracts',
                //   'Handle contract negotiations',
                //   Colors.orange[700]!,
                //   '/contracts',
                // ),
                // _buildActionCard(
                //   context,
                //   Icons.gavel,
                //   'Legal Cases',
                //   'Track legal proceedings',
                //   Colors.purple[700]!,
                //   '/cases',
                // ),
                // _buildActionCard(
                //   context,
                //   Icons.calendar_today,
                //   'Appointments',
                //   'Schedule meetings',
                //   Colors.teal[700]!,
                //   '/appointments',
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivities() {
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
            Text(
              'Recent Activities',
              style: AppStyles.heading2.copyWith(
                fontSize: Responsive.isDesktop(context) ? 28 : 24,
              ),
            ),
            const SizedBox(height: 20),
            _buildActivityItem(
              Icons.assignment_turned_in,
              'New contract signed with Ladack Chasambi',
              '6 months ago',
              Colors.green,
            ),
            _buildActivityItem(
              Icons.assignment_turned_in,
              'New contract signed with Muhsin Malima',
              '6 months ago',
              Colors.green,
            ),
            _buildActivityItem(
              Icons.gavel,
              'Case update: Contract dispute with KMC FC',
              '9 months ago',
              Colors.orange,
            ),
            _buildActivityItem(
              Icons.people,
              'New player registration: Cyprian Kipenye',
              '1 year ago',
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(IconData icon, String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[400],
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Column(
      children: [
        Text(
          'Why Choose Football Fraternity?',
          style: AppStyles.heading2.copyWith(
            fontSize: Responsive.isDesktop(context) ? 32 : 28,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'Comprehensive football management and legal services tailored to your needs',
          style: TextStyle(
            fontSize: Responsive.isDesktop(context) ? 18 : 16,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: Responsive.isDesktop(context) ? 3 : 
                         Responsive.isTablet(context) ? 2 : 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildFeatureCard(
              Icons.security,
              'Legal Expertise',
              'Specialized football law professionals with years of experience',
            ),
            _buildFeatureCard(
              Icons.people,
              'Player Management',
              'Comprehensive career management for professional footballers',
            ),
            _buildFeatureCard(
              Icons.trending_up,
              'Career Growth',
              'Strategic planning for long-term player development',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: (Responsive.isDesktop(context) || Responsive.isTablet(context)) ? const EdgeInsets.all(40) : const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: (Responsive.isDesktop(context) || Responsive.isTablet(context)) ?
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('50+', 'Players Managed'),
          _buildStatItem('100+', 'Contracts Signed'),
          _buildStatItem('25+', 'Legal Cases'),
          if (Responsive.isDesktop(context)) 
            _buildStatItem('5+', 'Years Experience'),
        ],
      ) :
      Column(
        children: [          
          _buildStatItem2('50+', 'Players Managed'),
          _buildStatItem2('100+', 'Contracts Signed'),
          _buildStatItem2('25+', 'Legal Cases'),
          _buildStatItem2('5+', 'Years Experience'),
        ],
      )
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem2(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(value, label),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String description) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
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

  Widget _buildActionCard(
      BuildContext context, IconData icon, String title, String subtitle, Color color, String route) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          context.go(route);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
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
      appBar: null,
      drawer: null,
      body: Stack(
        children: [
          // Scrollable main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              // Add top padding equal to navbar height so content doesn't hide under it
              padding: EdgeInsets.only(top: Responsive.isDesktop(context) ? 60 : 0),
              child: Responsive.isDesktop(context)
                  ? _buildDesktopLayout(context)
                  : _buildMobileLayout(context),
            ),
          ),

          // Fixed desktop navbar at top
          if (Responsive.isDesktop(context))
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildDesktopNavBar(context),
            ),
        ],
      ),
    );
  }

}
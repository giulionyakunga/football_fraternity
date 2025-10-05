import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      drawer: null,
      body: Column(
        children: [
          if (Responsive.isDesktop(context)) _buildDesktopNavBar(context),
          
          // Fixed height for slideshow
          SizedBox(
            height: Responsive.isMobile(context) ? 300 : 500,
            child: _buildSlideshow(),
          ),
          
          // Main content area with proper scrolling
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuickActions(context),
                    const SizedBox(height: 30),
                    _buildActivityList(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
        
        // Dark overlay
        Container(color: Colors.black.withOpacity(0.4)),
        
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
                    fontSize: Responsive.isMobile(context) ? 32 : 48,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Your trusted partner for football management and legal services',
                  style: AppStyles.heading2.copyWith(
                    color: Colors.white,
                    fontSize: Responsive.isMobile(context) ? 18 : 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/services'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Explore Our Services',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Slide indicators
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              slideImages.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
              crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
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
    );
  }

  Widget _buildDesktopNavBar(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 40,
          ),
          const Spacer(),
          _buildNavLink(context, 'Home', '/'),
          _buildNavLink(context, 'About Us', '/about-us'),
          _buildNavLink(context, 'Services', '/services'),
          _buildNavLink(context, 'Contact', '/contact'),
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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Football Fraternity 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(context, Icons.home, 'Home', '/'),
          _buildDrawerItem(context, Icons.info, 'About Us', '/about-us'),
          _buildDrawerItem(context, Icons.work, 'Services', '/services'),
          _buildDrawerItem(context, Icons.contact_phone, 'Contact', '/contact'),
          const Divider(),
          _buildDrawerItem(context, Icons.people, 'Footballers', '/footballers'),
          _buildDrawerItem(context, Icons.assignment, 'Contracts', '/contracts'),
          _buildDrawerItem(context, Icons.gavel, 'Legal Cases', '/cases'),
          _buildDrawerItem(context, Icons.calendar_today, 'Appointments', '/appointments'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String text, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(text),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildActivityList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activities',
          style: AppStyles.heading2,
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.assignment),
          ),
          title: const Text('New contract signed with Kibu Denis'),
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
          title: const Text('Case update: Contract dispute with KMC FC'),
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
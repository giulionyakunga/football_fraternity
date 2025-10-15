import 'package:flutter/material.dart';
import 'package:football_fraternity/models/footballer.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class FootballerDetailScreen extends StatelessWidget {
  const FootballerDetailScreen({super.key});

  final Footballer footballer = const Footballer(
    id: 1,
    fullName: 'Kibu Denis',
    position: 'Forward',
    club: 'Simba FC',
    nationality: 'Tanzanian',
    age: 25,
    contractStatus: 'Active',
    imageUrl: 'assets/images/profile_placeholder.png',
  );

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - Profile and Quick Actions
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(footballer.imageUrl),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          footballer.fullName,
                          style: AppStyles.heading1.copyWith(
                            fontSize: 28,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            footballer.position,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildStatusChip(footballer.contractStatus),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/footballers/form');
                            },
                            icon: const Icon(Icons.edit, size: 20),
                            label: const Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/contracts/detail');
                            },
                            icon: const Icon(Icons.assignment, size: 20),
                            label: const Text('View Contract'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: BorderSide(color: AppColors.primary),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildQuickStats(context),
              ],
            ),
          ),

          const SizedBox(width: 40),

          // Right Column - Detailed Information
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Personal Information
                Card(
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
                              Icons.person,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Personal Information',
                              style: AppStyles.heading2.copyWith(fontSize: 22),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildDesktopInfoGrid(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Performance Stats
                Card(
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
                              Icons.leaderboard,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Performance Stats',
                              style: AppStyles.heading2.copyWith(fontSize: 22),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildPerformanceGrid(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Contract Details
                Card(
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
                              Icons.assignment,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Contract Details',
                              style: AppStyles.heading2.copyWith(fontSize: 22),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildContractDetails(),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/contracts/detail');
                            },
                            icon: const Icon(Icons.description, size: 20),
                            label: const Text('View Full Contract Document'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
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
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isTablet(context) ? 30 : 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: Responsive.isTablet(context) ? 60 : 50,
                    backgroundImage: AssetImage(footballer.imageUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    footballer.fullName,
                    style: AppStyles.heading1.copyWith(
                      fontSize: Responsive.isTablet(context) ? 24 : 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      footballer.position,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildStatusChip(footballer.contractStatus),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Quick Stats
          _buildQuickStats(context),
          const SizedBox(height: 20),

          // Personal Information
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Personal Information',
                        style: AppStyles.heading2.copyWith(
                          fontSize: Responsive.isTablet(context) ? 20 : 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildMobileInfoList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Performance Stats
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.leaderboard,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Performance Stats',
                        style: AppStyles.heading2.copyWith(
                          fontSize: Responsive.isTablet(context) ? 20 : 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildPerformanceGrid(context),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Contract Details
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Contract Details',
                        style: AppStyles.heading2.copyWith(
                          fontSize: Responsive.isTablet(context) ? 20 : 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildContractDetails(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/contracts/detail');
                      },
                      icon: const Icon(Icons.description, size: 18),
                      label: const Text('View Full Contract'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDesktopInfoGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      crossAxisSpacing: 20,
      mainAxisSpacing: 15,
      children: [
        _buildInfoItem('Club', footballer.club, Icons.sports_soccer),
        _buildInfoItem('Nationality', footballer.nationality, Icons.flag),
        _buildInfoItem('Age', '${footballer.age} years', Icons.cake),
        _buildInfoItem('Contract Status', footballer.contractStatus, Icons.assignment_turned_in),
      ],
    );
  }

  Widget _buildMobileInfoList() {
    return Column(
      children: [
        _buildInfoItem('Club', footballer.club, Icons.sports_soccer),
        const SizedBox(height: 12),
        _buildInfoItem('Nationality', footballer.nationality, Icons.flag),
        const SizedBox(height: 12),
        _buildInfoItem('Age', '${footballer.age} years', Icons.cake),
        const SizedBox(height: 12),
        _buildInfoItem('Contract Status', footballer.contractStatus, Icons.assignment_turned_in),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 16, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: Responsive.isDesktop(context) ? 4 : 2,
      childAspectRatio: Responsive.isDesktop(context) ? 1 : 1.2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildStatCard('Matches', '24', Icons.event),
        _buildStatCard('Goals', '15', Icons.sports_score),
        _buildStatCard('Assists', '8', Icons.assistant),
        _buildStatCard('Rating', '7.8', Icons.star),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQuickStatItem('24', 'Matches'),
            _buildQuickStatItem('15', 'Goals'),
            _buildQuickStatItem('8', 'Assists'),
            if (Responsive.isDesktop(context)) _buildQuickStatItem('7.8', 'Rating'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildContractDetails() {
    return Column(
      children: [
        _buildContractItem('Current Club', 'Simba FC'),
        const SizedBox(height: 12),
        _buildContractItem('Contract Start', 'January 1, 2023'),
        const SizedBox(height: 12),
        _buildContractItem('Contract End', 'December 31, 2025'),
        const SizedBox(height: 12),
        _buildContractItem('Salary', '\$10,000 / month'),
        const SizedBox(height: 12),
        _buildContractItem('Contract Type', 'Professional'),
      ],
    );
  }

  Widget _buildContractItem(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'active':
        statusColor = Colors.green;
        break;
      case 'expiring':
        statusColor = Colors.orange;
        break;
      case 'without club':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: statusColor,
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
          'Footballer Details',
          style: TextStyle(
            fontSize: Responsive.isDesktop(context) ? 20 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: !Responsive.isDesktop(context),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, size: 22),
            onPressed: () {
              // Navigator.pushNamed(context, '/footballers/form');
            },
            tooltip: 'Edit Profile',
          ),
          if (Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(Icons.share, size: 22),
              onPressed: () {
                // Share functionality
              },
              tooltip: 'Share Profile',
            ),
        ],
      ),
      body: Responsive.isDesktop(context) 
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }
}
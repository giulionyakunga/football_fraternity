import 'package:flutter/material.dart';
import 'package:football_fraternity/models/case.dart';
import 'package:football_fraternity/widgets/case_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class CasesListScreen extends StatelessWidget {
  CasesListScreen({super.key});

  final List<LegalCase> cases = [
    LegalCase(
      id: '1',
      title: 'Contract Dispute Resolution',
      description: 'Dispute over image rights and commercial agreements with City FC',
      status: 'In Progress',
      clientId: '1',
      clientName: 'Kibu Denis',
      legalOfficerId: '1',
      legalOfficerName: 'Sarah Johnson',
      createdAt: DateTime(2023, 5, 10),
      updatedAt: DateTime(2023, 10, 15),
      priority: 'High',
    ),
    LegalCase(
      id: '2',
      title: 'International Transfer Negotiation',
      description: 'Negotiating international transfer terms with United FC including salary and bonuses',
      status: 'Pending',
      clientId: '2',
      clientName: 'Yazid Alpha',
      legalOfficerId: '1',
      legalOfficerName: 'Sarah Johnson',
      createdAt: DateTime(2023, 6, 15),
      updatedAt: DateTime(2023, 9, 20),
      priority: 'Medium',
    ),
    LegalCase(
      id: '3',
      title: 'Contract Termination Dispute',
      description: 'Unlawful termination case against former club, seeking compensation',
      status: 'Active',
      clientId: '3',
      clientName: 'John Bocco',
      legalOfficerId: '2',
      legalOfficerName: 'Michael Brown',
      createdAt: DateTime(2023, 7, 22),
      updatedAt: DateTime(2023, 11, 5),
      priority: 'High',
    ),
    LegalCase(
      id: '4',
      title: 'Sponsorship Agreement Review',
      description: 'Review and negotiation of new sponsorship deal with sports brand',
      status: 'Completed',
      clientId: '4',
      clientName: 'Mbwana Samatta',
      legalOfficerId: '3',
      legalOfficerName: 'Emily Davis',
      createdAt: DateTime(2023, 4, 5),
      updatedAt: DateTime(2023, 8, 30),
      priority: 'Medium',
    ),
    LegalCase(
      id: '5',
      title: 'Image Rights Protection',
      description: 'Protecting player image rights from unauthorized commercial use',
      status: 'In Progress',
      clientId: '5',
      clientName: 'Thomas Ulimwengu',
      legalOfficerId: '1',
      legalOfficerName: 'Sarah Johnson',
      createdAt: DateTime(2023, 8, 12),
      updatedAt: DateTime(2023, 12, 1),
      priority: 'High',
    ),
    LegalCase(
      id: '6',
      title: 'Loan Agreement Finalization',
      description: 'Finalizing loan agreement terms with European club',
      status: 'Pending',
      clientId: '6',
      clientName: 'David Mwantika',
      legalOfficerId: '2',
      legalOfficerName: 'Michael Brown',
      createdAt: DateTime(2023, 9, 18),
      updatedAt: DateTime(2023, 11, 25),
      priority: 'Low',
    ),
  ];

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Legal Cases Management',
                    style: AppStyles.heading1.copyWith(
                      fontSize: 36,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage all legal cases and client representations',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              _buildStatsOverview(),
            ],
          ),
          const SizedBox(height: 40),

          // Controls Section
          _buildControlsSection(context),
          const SizedBox(height: 30),

          // Cases Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.3,
              ),
              itemCount: cases.length,
              itemBuilder: (context, index) {
                return CaseCard(legalCase: cases[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isTablet(context) ? 30 : 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Text(
            'Legal Cases',
            style: AppStyles.heading1.copyWith(
              fontSize: Responsive.isTablet(context) ? 28 : 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage all legal cases and client representations',
            style: TextStyle(
              fontSize: Responsive.isTablet(context) ? 16 : 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),

          // Mobile Stats
          _buildMobileStats(),
          const SizedBox(height: 20),

          // Controls Section
          _buildControlsSection(context),
          const SizedBox(height: 20),

          // Cases List
          Expanded(
            child: ListView.builder(
              itemCount: cases.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: CaseCard(legalCase: cases[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    final activeCases = cases.where((c) => c.status == 'Active' || c.status == 'In Progress').length;
    final pendingCases = cases.where((c) => c.status == 'Pending').length;
    final completedCases = cases.where((c) => c.status == 'Completed').length;
    final highPriorityCases = cases.where((c) => c.priority == 'High').length;

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            _buildStatItem(cases.length.toString(), 'Total Cases', Icons.gavel),
            const SizedBox(width: 30),
            _buildStatItem(activeCases.toString(), 'Active', Icons.timeline, Colors.blue),
            const SizedBox(width: 30),
            _buildStatItem(pendingCases.toString(), 'Pending', Icons.pending, Colors.orange),
            const SizedBox(width: 30),
            _buildStatItem(highPriorityCases.toString(), 'High Priority', Icons.warning, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileStats() {
    final activeCases = cases.where((c) => c.status == 'Active' || c.status == 'In Progress').length;
    final pendingCases = cases.where((c) => c.status == 'Pending').length;

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
            _buildStatItem(cases.length.toString(), 'Total', Icons.gavel),
            _buildStatItem(activeCases.toString(), 'Active', Icons.timeline, Colors.blue),
            _buildStatItem(pendingCases.toString(), 'Pending', Icons.pending, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon, [Color? color]) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (color ?? AppColors.primary).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color ?? AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black87,
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

  Widget _buildControlsSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Search Field
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search cases...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Filter Button
            PopupMenuButton<String>(
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.filter_list, color: Colors.white, size: 20),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'all',
                  child: Row(
                    children: [
                      Icon(Icons.all_inclusive, size: 20),
                      SizedBox(width: 8),
                      Text('All Cases'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'active',
                  child: Row(
                    children: [
                      Icon(Icons.timeline, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Text('Active Cases'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'pending',
                  child: Row(
                    children: [
                      Icon(Icons.pending, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text('Pending Review'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'completed',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text('Completed'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'high',
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Text('High Priority'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'medium',
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text('Medium Priority'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'low',
                  child: Row(
                    children: [
                      Icon(Icons.low_priority, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text('Low Priority'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Sort Button
            PopupMenuButton<String>(
              icon: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.sort, color: Colors.black54, size: 20),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'date',
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Date'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'priority',
                  child: Row(
                    children: [
                      Icon(Icons.priority_high, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Priority'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'status',
                  child: Row(
                    children: [
                      Icon(Icons.info, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Status'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'client',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Client'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // New Case Button (Desktop)
            if (Responsive.isDesktop(context))
              ElevatedButton.icon(
                onPressed: () {
                  // Navigator.pushNamed(context, '/cases/create');
                },
                icon: const Icon(Icons.add, size: 20),
                label: const Text('New Case'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Navigator.pushNamed(context, '/cases/create');
      },
      backgroundColor: AppColors.primary,
      elevation: 4,
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Legal Cases',
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
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigator.pushNamed(context, '/cases/create');
              },
              tooltip: 'New Case',
            ),
        ],
      ),
      body: Responsive.isDesktop(context) 
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
      floatingActionButton: Responsive.isDesktop(context) ? null : _buildFloatingActionButton(),
    );
  }
}
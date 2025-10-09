import 'package:flutter/material.dart';
import 'package:football_fraternity/models/contract.dart';
import 'package:football_fraternity/widgets/contract_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class ContractsListScreen extends StatelessWidget {
  ContractsListScreen({super.key});

  final List<Contract> contracts = [
    Contract(
      id: '1',
      footballerId: '1',
      footballerName: 'Kibu Denis',
      club: 'Simba FC',
      startDate: DateTime(2023, 1, 1),
      endDate: DateTime(2025, 12, 31),
      salary: 10000,
      status: 'Active',
      terms: [
        '2-year contract',
        'Performance bonuses',
        'Image rights agreement',
        'Medical insurance included',
      ],
    ),
    Contract(
      id: '2',
      footballerId: '2',
      footballerName: 'Yazid Alpha',
      club: 'Yanga FC',
      startDate: DateTime(2022, 6, 1),
      endDate: DateTime(2023, 12, 31),
      salary: 8000,
      status: 'Expiring',
      terms: [
        '1.5-year contract',
        'Goal bonuses',
        'Accommodation provided',
      ],
    ),
    Contract(
      id: '3',
      footballerId: '3',
      footballerName: 'John Bocco',
      club: 'Simba FC',
      startDate: DateTime(2024, 1, 1),
      endDate: DateTime(2026, 12, 31),
      salary: 15000,
      status: 'Active',
      terms: [
        '3-year contract',
        'Captain bonus',
        'Commercial rights',
        'Family accommodation',
      ],
    ),
    Contract(
      id: '4',
      footballerId: '4',
      footballerName: 'Mbwana Samatta',
      club: 'Free Agent',
      startDate: DateTime(2022, 1, 1),
      endDate: DateTime(2023, 6, 30),
      salary: 0,
      status: 'Expired',
      terms: [
        'Previous contract ended',
        'Seeking new opportunities',
      ],
    ),
    Contract(
      id: '5',
      footballerId: '5',
      footballerName: 'Thomas Ulimwengu',
      club: 'Young Africans SC',
      startDate: DateTime(2023, 3, 1),
      endDate: DateTime(2024, 6, 30),
      salary: 7000,
      status: 'Active',
      terms: [
        '1-year extension',
        'Performance clauses',
        'International bonus',
      ],
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
                    'Contracts Management',
                    style: AppStyles.heading1.copyWith(
                      fontSize: 36,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage all player contracts and agreements',
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

          // Contracts Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.4,
              ),
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                return ContractCard(contract: contracts[index]);
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
            'Contracts Management',
            style: AppStyles.heading1.copyWith(
              fontSize: Responsive.isTablet(context) ? 28 : 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage all player contracts and agreements',
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

          // Contracts List
          Expanded(
            child: ListView.builder(
              itemCount: contracts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ContractCard(contract: contracts[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    final activeContracts = contracts.where((c) => c.status == 'Active').length;
    final expiringContracts = contracts.where((c) => c.status == 'Expiring').length;
    final expiredContracts = contracts.where((c) => c.status == 'Expired').length;
    final totalValue = contracts.fold<double>(0, (sum, c) => sum + c.salary);

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            _buildStatItem(contracts.length.toString(), 'Total Contracts', Icons.assignment),
            const SizedBox(width: 30),
            _buildStatItem(activeContracts.toString(), 'Active', Icons.check_circle, Colors.green),
            const SizedBox(width: 30),
            _buildStatItem(expiringContracts.toString(), 'Expiring', Icons.warning, Colors.orange),
            const SizedBox(width: 30),
            _buildStatItem('\$${totalValue ~/ 1000}K', 'Monthly', Icons.attach_money, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileStats() {
    final activeContracts = contracts.where((c) => c.status == 'Active').length;
    final expiringContracts = contracts.where((c) => c.status == 'Expiring').length;

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
            _buildStatItem(contracts.length.toString(), 'Total', Icons.assignment),
            _buildStatItem(activeContracts.toString(), 'Active', Icons.check_circle, Colors.green),
            _buildStatItem(expiringContracts.toString(), 'Expiring', Icons.warning, Colors.orange),
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
                  hintText: 'Search contracts...',
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
                      Text('All Contracts'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'active',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text('Active Contracts'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'expiring',
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text('Expiring Soon'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'expired',
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Text('Expired'),
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
                  value: 'salary',
                  child: Row(
                    children: [
                      Icon(Icons.attach_money, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Salary'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'player',
                  child: Row(
                    children: [
                      Icon(Icons.person, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Player'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'club',
                  child: Row(
                    children: [
                      Icon(Icons.emoji_events, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Club'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Add Contract Button
            if (Responsive.isDesktop(context))
              ElevatedButton.icon(
                onPressed: () {
                  // Navigator.pushNamed(context, '/contracts/form');
                },
                icon: const Icon(Icons.add, size: 20),
                label: const Text('New Contract'),
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
        // Navigator.pushNamed(context, '/contracts/form');
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
          'Contracts Management',
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
                // Navigator.pushNamed(context, '/contracts/form');
              },
              tooltip: 'Add New Contract',
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
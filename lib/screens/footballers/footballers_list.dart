import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:football_fraternity/env.dart';
import 'package:football_fraternity/models/footballer.dart';
import 'package:football_fraternity/widgets/footballer_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';


class FootballersListScreen extends StatefulWidget {
  const FootballersListScreen({super.key});

  @override
  State<FootballersListScreen> createState() => _FootballersListScreenState();
}

class _FootballersListScreenState extends State<FootballersListScreen> {
  final ScrollController _scrollController = ScrollController();
  int userId = 0;
  List<Footballer> footballers = [];

  @override
  void initState() {
    super.initState();
    _fetchFootballers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

   Future<void> _fetchFootballers() async {
    try {
      final Uri uri = Uri.parse('${backend_url}api/footballers/');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final newItems = jsonList.map((json) => Footballer.fromJson(json)).toList();
        setState(() {
          footballers = newItems;
        });
      }
    }  on SocketException catch (e) {
      debugPrint('Network error occurred:');
      debugPrint('- Exception type: ${e.runtimeType}');
      debugPrint('- Message: ${e.message}');
      
      if (e.osError != null) {
        debugPrint('  - Error number (errno): ${e.osError!.errorCode}');
        debugPrint('  - OS message: ${e.osError!.message}');
      }
    }
  }

  Widget _buildDesktopLayout() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
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
                      (userId == 0) ? 'Our Footballers' : 'Footballers Management',
                      style: AppStyles.heading1.copyWith(
                        fontSize: 36,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                     Text(
                      (userId == 0) ? 'We manage the following football players and their contracts' : 'Manage your football players and their contracts',
                      style: const TextStyle(
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

            // Search and Filters
            // _buildSearchAndFilters(),
            // const SizedBox(height: 30),

            // Grid View for Desktop
            GridView.builder(
              shrinkWrap: true, // Important for nested scrollable content
              physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.85,
              ),
              itemCount: footballers.length,
              itemBuilder: (context, index) {
                return FootballerCard(footballer: footballers[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Text(
              (userId == 0) ? 'Our Footballers' : 'Footballers Management',
              style: AppStyles.heading1.copyWith(
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              (userId == 0) ? 'We manage the following football players and their contracts' :'Manage your football players and their contracts',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // Stats Overview for Mobile
            _buildMobileStats(),
            const SizedBox(height: 20),

            // Search and Filters
            // _buildSearchAndFilters(),
            // const SizedBox(height: 20),

            // List View for Mobile
            ListView.builder(
              shrinkWrap: true, // Important for nested scrollable content
              physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
              itemCount: footballers.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: FootballerCard(footballer: footballers[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  int countFootballersByContractStatus(List<Footballer> footballers, String contractStatus) {
    return footballers.where((footballer) => footballer.contractStatus == contractStatus).length;
  }

  Widget _buildStatsOverview() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _buildStatItem('${footballers.length}', 'Total Players', Icons.people),
            const SizedBox(width: 30),
            _buildStatItem('${countFootballersByContractStatus(footballers, "Active")}', 'Active Contracts', Icons.assignment_turned_in),
           const SizedBox(width: 30),
            _buildStatItem('${countFootballersByContractStatus(footballers, "Expired")}', 'Expired', Icons.warning),
            const SizedBox(width: 30),
            _buildStatItem('${countFootballersByContractStatus(footballers, "Free Agent")}', 'Free Agents', Icons.person_outline),
            const SizedBox(width: 30),
            _buildStatItem('${countFootballersByContractStatus(footballers, "On Loan")}', 'On Loan', Icons.free_breakfast),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileStats() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('${footballers.length}', 'Total Players', Icons.people),
                _buildStatItem('${countFootballersByContractStatus(footballers, "Active")}', 'Active Contracts', Icons.assignment_turned_in),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('${countFootballersByContractStatus(footballers, "Expired")}', 'Expired', Icons.warning),
                _buildStatItem('${countFootballersByContractStatus(footballers, "Free Agent")}', 'Free Agents', Icons.person_outline),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
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

  Widget _buildSearchAndFilters() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Search Field
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search footballers...',
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
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.filter_list, color: Colors.white, size: 20),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'all',
                  child: Text('All Players'),
                ),
                const PopupMenuItem(
                  value: 'active',
                  child: Text('Active Contracts'),
                ),
                const PopupMenuItem(
                  value: 'expiring',
                  child: Text('Expiring Soon'),
                ),
                const PopupMenuItem(
                  value: 'free',
                  child: Text('Free Agents'),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Sort Button
            PopupMenuButton<String>(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.sort, color: Colors.black54, size: 20),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'name',
                  child: Text('Sort by Name'),
                ),
                const PopupMenuItem(
                  value: 'club',
                  child: Text('Sort by Club'),
                ),
                const PopupMenuItem(
                  value: 'contract',
                  child: Text('Sort by Contract'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.go('/footballers/form');
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
          (userId == 0) ? 'Our Footballers' : 'Footballers Management',
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
          ? _buildDesktopLayout()
          : _buildMobileLayout(),
      floatingActionButton: (userId == 0) ? null : _buildFloatingActionButton(context),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:football_fraternity/models/footballer.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';

class FootballerDetailScreen extends StatelessWidget {
  const FootballerDetailScreen({super.key});

  final Footballer footballer = const Footballer(
    id: '1',
    name: 'Kibu Denis',
    position: 'Forward',
    club: 'Simba FC',
    nationality: 'Tanzanian',
    age: 25,
    contractStatus: 'Active',
    imageUrl: 'assets/images/profile_placeholder.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Footballer Details'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/footballers/form');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(footballer.imageUrl),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                footballer.name,
                style: AppStyles.heading1,
              ),
            ),
            Center(
              child: Text(
                footballer.position,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Personal Information',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            _buildInfoRow('Club', footballer.club),
            _buildInfoRow('Nationality', footballer.nationality),
            _buildInfoRow('Age', footballer.age.toString()),
            _buildInfoRow('Contract Status', footballer.contractStatus),
            const SizedBox(height: 30),
            const Text(
              'Performance Stats',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard('Matches', '24'),
                _buildStatCard('Goals', '15'),
                _buildStatCard('Assists', '8'),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Contract Details',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            _buildInfoRow('Current Club', 'City FC'),
            _buildInfoRow('Contract Start', '01/01/2023'),
            _buildInfoRow('Contract End', '31/12/2025'),
            _buildInfoRow('Salary', '\$10,000/month'),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/contracts/detail');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'View Full Contract',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
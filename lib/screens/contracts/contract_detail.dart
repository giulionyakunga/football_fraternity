import 'package:flutter/material.dart';
import 'package:football_fraternity/models/contract.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';

class ContractDetailScreen extends StatelessWidget {
  ContractDetailScreen({super.key});

  final Contract contract = Contract(
    id: '1',
    footballerId: '1',
    club: 'KMC FC',
    startDate: DateTime(2023, 1, 1),
    endDate: DateTime(2025, 12, 31),
    salary: 10000,
    status: 'Active',
    terms: [
      '2-year contract',
      'Performance bonuses',
      'Image rights agreement',
      'Medical coverage',
      'Annual salary review',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contract Details'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contract #${contract.id}',
              style: AppStyles.heading1,
            ),
            const SizedBox(height: 20),
            _buildInfoRow('Footballer ID', contract.footballerId),
            _buildInfoRow('Club', contract.club),
            _buildInfoRow('Start Date',
                '${contract.startDate.day}/${contract.startDate.month}/${contract.startDate.year}'),
            _buildInfoRow('End Date',
                '${contract.endDate.day}/${contract.endDate.month}/${contract.endDate.year}'),
            _buildInfoRow('Salary', '\$${contract.salary}/month'),
            _buildInfoRow('Status', contract.status),
            const SizedBox(height: 30),
            Text(
              'Contract Terms',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: contract.terms
                  .map((term) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• '),
                            Expanded(child: Text(term)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 30),
            Text(
              'Contract Documents',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Contract Agreement.pdf'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  // Implement download
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Addendum 1.pdf'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  // Implement download
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement renew contract
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Renew Contract'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement terminate contract
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Terminate'),
                  ),
                ),
              ],
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
}
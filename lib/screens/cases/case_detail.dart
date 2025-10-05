import 'package:flutter/material.dart';
import 'package:football_fraternity/models/case.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';

class CaseDetailScreen extends StatelessWidget {
  final LegalCase legalCase;

  const CaseDetailScreen({super.key, required this.legalCase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              legalCase.title,
              style: AppStyles.heading1,
            ),
            const SizedBox(height: 10),
            Chip(
              label: Text(
                legalCase.status,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: _getStatusColor(legalCase.status),
            ),
            const SizedBox(height: 30),
            _buildDetailRow('Case ID', legalCase.id),
            _buildDetailRow('Opened On',
                '${legalCase.createdAt.day}/${legalCase.createdAt.month}/${legalCase.createdAt.year}'),
            if (legalCase.updatedAt != null)
              _buildDetailRow('Last Updated',
                  '${legalCase.updatedAt!.day}/${legalCase.updatedAt!.month}/${legalCase.updatedAt!.year}'),
            _buildDetailRow('Legal Officer', 'LO-${legalCase.legalOfficerId}'),
            const SizedBox(height: 30),
            Text(
              'Case Description',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            Text(legalCase.description),
            const SizedBox(height: 30),
            Text(
              'Case Documents',
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
              leading: const Icon(Icons.description),
              title: const Text('Evidence.docx'),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  // Implement download
                },
              ),
            ),
            const SizedBox(height: 30),
            if (legalCase.status != 'Closed')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement update case
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Update Case'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.blue;
      case 'in progress':
        return Colors.orange;
      case 'closed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
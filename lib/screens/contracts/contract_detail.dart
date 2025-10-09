import 'package:flutter/material.dart';
import 'package:football_fraternity/models/contract.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class ContractDetailScreen extends StatelessWidget {
  ContractDetailScreen({super.key});

  final Contract contract = Contract(
    id: '1',
    footballerId: '1',
    footballerName: 'Kibu Denis',
    club: 'KMC FC',
    startDate: DateTime(2023, 1, 1),
    endDate: DateTime(2025, 12, 31),
    salary: 10000,
    status: 'Active',
    terms: [
      '2-year professional contract',
      'Performance-based bonuses',
      'Image rights agreement included',
      'Comprehensive medical coverage',
      'Annual salary review and adjustment',
      'Accommodation and transportation provided',
      'International match bonuses',
      'Goal and assist incentives',
    ],
  );

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - Contract Overview and Actions
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
                        // Contract Header
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.assignment,
                                color: AppColors.primary,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contract #${contract.id}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      contract.club,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Status and Duration
                        _buildStatusSection(),
                        const SizedBox(height: 25),
                        
                        // Quick Actions
                        _buildActionButtons(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Financial Summary
                _buildFinancialSummary(context),
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
                        _buildSectionHeader(context, 'Contract Details', Icons.description),
                        const SizedBox(height: 20),
                        _buildDesktopDetailsGrid(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Contract Terms
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
                        _buildSectionHeader(context, 'Contract Terms & Conditions', Icons.list_alt),
                        const SizedBox(height: 20),
                        _buildTermsList(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Documents Section
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
                        _buildSectionHeader(context, 'Contract Documents', Icons.folder),
                        const SizedBox(height: 20),
                        _buildDocumentsList(),
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
          // Contract Header
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contract #${contract.id}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '${contract.footballerName} - ${contract.club}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildStatusSection(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Financial Summary
          _buildFinancialSummary(context),
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
                  _buildSectionHeader(context, 'Contract Details', Icons.description),
                  const SizedBox(height: 16),
                  _buildMobileDetailsList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Contract Terms
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
                  _buildSectionHeader(context, 'Contract Terms', Icons.list_alt),
                  const SizedBox(height: 16),
                  _buildTermsList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Documents
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
                  _buildSectionHeader(context, 'Documents', Icons.folder),
                  const SizedBox(height: 16),
                  _buildDocumentsList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Action Buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (contract.status.toLowerCase()) {
      case 'active':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = 'Active Contract';
        break;
      case 'expiring':
        statusColor = Colors.orange;
        statusIcon = Icons.warning;
        statusText = 'Expiring Soon';
        break;
      case 'expired':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusText = 'Expired';
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
        statusText = contract.status;
    }

    final now = DateTime.now();
    final totalDays = contract.endDate.difference(contract.startDate).inDays;
    final daysPassed = now.difference(contract.startDate).inDays;
    final progress = daysPassed / totalDays;

    return Column(
      children: [
        // Status Chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: statusColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(statusIcon, size: 16, color: statusColor),
              const SizedBox(width: 8),
              Text(
                statusText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Contract Progress
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contract Progress',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${contract.startDate.day}/${contract.startDate.month}/${contract.startDate.year}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '${contract.endDate.day}/${contract.endDate.month}/${contract.endDate.year}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFinancialSummary(BuildContext context) {
    final annualSalary = contract.salary * 12;
    final contractDuration = contract.endDate.difference(contract.startDate).inDays / 365;
    final totalValue = annualSalary * contractDuration;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Financial Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFinancialItem('Monthly', '\$${contract.salary}'),
                _buildFinancialItem('Annual', '\$${annualSalary.toStringAsFixed(0)}'),
                if (Responsive.isDesktop(context))
                  _buildFinancialItem('Total Value', '\$${totalValue.toStringAsFixed(0)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopDetailsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3,
      crossAxisSpacing: 20,
      mainAxisSpacing: 15,
      children: [
        _buildDetailItem('Footballer', contract.footballerName, Icons.person),
        _buildDetailItem('Club', contract.club, Icons.emoji_events),
        _buildDetailItem('Start Date', _formatDate(contract.startDate), Icons.calendar_today),
        _buildDetailItem('End Date', _formatDate(contract.endDate), Icons.event_available),
        _buildDetailItem('Monthly Salary', '\$${contract.salary}', Icons.attach_money),
        _buildDetailItem('Contract Type', 'Professional', Icons.assignment),
      ],
    );
  }

  Widget _buildMobileDetailsList() {
    return Column(
      children: [
        _buildDetailItem('Footballer', contract.footballerName, Icons.person),
        const SizedBox(height: 12),
        _buildDetailItem('Club', contract.club, Icons.emoji_events),
        const SizedBox(height: 12),
        _buildDetailItem('Start Date', _formatDate(contract.startDate), Icons.calendar_today),
        const SizedBox(height: 12),
        _buildDetailItem('End Date', _formatDate(contract.endDate), Icons.event_available),
        const SizedBox(height: 12),
        _buildDetailItem('Monthly Salary', '\$${contract.salary}', Icons.attach_money),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
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

  Widget _buildTermsList() {
    return Column(
      children: contract.terms
          .map((term) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[600],
                      size: 16,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        term,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDocumentsList() {
    final documents = [
      {'name': 'Contract Agreement.pdf', 'size': '2.4 MB', 'date': 'Jan 1, 2023'},
      {'name': 'Addendum 1 - Image Rights.pdf', 'size': '1.1 MB', 'date': 'Feb 15, 2023'},
      {'name': 'Medical Coverage Details.pdf', 'size': '0.8 MB', 'date': 'Jan 1, 2023'},
      {'name': 'Performance Bonus Structure.pdf', 'size': '1.5 MB', 'date': 'Mar 10, 2023'},
    ];

    return Column(
      children: documents
          .map((doc) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red[600],
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '${doc['size']!} • ${doc['date']!}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.download,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      onPressed: () {
                        // Implement download
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      onPressed: () {
                        // Implement view
                      },
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement renew contract
                  },
                  icon: const Icon(Icons.autorenew, size: 20),
                  label: const Text('Renew Contract'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Implement edit contract
                  },
                  icon: const Icon(Icons.edit, size: 20),
                  label: const Text('Edit Contract'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Implement terminate contract
                  },
                  icon: const Icon(Icons.cancel, size: 20),
                  label: const Text('Terminate'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement renew contract
                  },
                  icon: const Icon(Icons.autorenew, size: 18),
                  label: const Text('Renew Contract'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Implement edit contract
                      },
                      icon: const Icon(Icons.edit, size: 18),
                      label: const Text('Edit'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Implement terminate contract
                      },
                      icon: const Icon(Icons.cancel, size: 18),
                      label: const Text('Terminate'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: Responsive.isDesktop(context) ? 20 : 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contract Details',
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
            icon: const Icon(Icons.share, size: 22),
            onPressed: () {
              // Share contract
            },
            tooltip: 'Share Contract',
          ),
          IconButton(
            icon: const Icon(Icons.print, size: 22),
            onPressed: () {
              // Print contract
            },
            tooltip: 'Print Contract',
          ),
        ],
      ),
      body: Responsive.isDesktop(context) 
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:football_fraternity/models/case.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class CaseDetailScreen extends StatelessWidget {
  final LegalCase legalCase;

  const CaseDetailScreen({super.key, required this.legalCase});

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - Case Overview and Quick Actions
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
                        // Case Header
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.gavel,
                                color: AppColors.primary,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Case #${legalCase.id}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      legalCase.title,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Status and Priority
                        _buildStatusSection(),
                        const SizedBox(height: 25),
                        
                        // Quick Actions
                        _buildActionButtons(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Case Timeline
                _buildCaseTimeline(),
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
                // Case Details
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
                        _buildSectionHeader(context, 'Case Details', Icons.description),
                        const SizedBox(height: 20),
                        _buildDesktopDetailsGrid(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Case Description
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
                        _buildSectionHeader(context, 'Case Description', Icons.subject),
                        const SizedBox(height: 16),
                        Text(
                          legalCase.description,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Case Documents
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
                        _buildSectionHeader(context, 'Case Documents', Icons.folder),
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
          // Case Header
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
                        Icons.gavel,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Case #${legalCase.id}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              legalCase.title,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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

          // Case Timeline
          _buildCaseTimeline(),
          const SizedBox(height: 20),

          // Case Details
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
                  _buildSectionHeader(context, 'Case Details', Icons.description),
                  const SizedBox(height: 16),
                  _buildMobileDetailsList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Case Description
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
                  _buildSectionHeader(context, 'Description', Icons.subject),
                  const SizedBox(height: 12),
                  Text(
                    legalCase.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
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
    Color statusColor = _getStatusColor(legalCase.status);
    IconData statusIcon;
    String statusText;

    switch (legalCase.status.toLowerCase()) {
      case 'open':
        statusIcon = Icons.lock_open;
        statusText = 'Open';
        break;
      case 'in progress':
        statusIcon = Icons.timeline;
        statusText = 'In Progress';
        break;
      case 'closed':
        statusIcon = Icons.check_circle;
        statusText = 'Closed';
        break;
      case 'active':
        statusIcon = Icons.play_arrow;
        statusText = 'Active';
        break;
      case 'pending':
        statusIcon = Icons.pending;
        statusText = 'Pending';
        break;
      case 'completed':
        statusIcon = Icons.verified;
        statusText = 'Completed';
        break;
      default:
        statusIcon = Icons.help;
        statusText = legalCase.status;
    }

    Color priorityColor;
    String priorityText;
    
    switch (legalCase.priority?.toLowerCase()) {
      case 'high':
        priorityColor = Colors.red;
        priorityText = 'High Priority';
        break;
      case 'medium':
        priorityColor = Colors.orange;
        priorityText = 'Medium Priority';
        break;
      case 'low':
        priorityColor = Colors.green;
        priorityText = 'Low Priority';
        break;
      default:
        priorityColor = Colors.grey;
        priorityText = 'No Priority';
    }

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
        const SizedBox(height: 12),

        // Priority Chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: priorityColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: priorityColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flag, size: 14, color: priorityColor),
              const SizedBox(width: 6),
              Text(
                priorityText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: priorityColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCaseTimeline() {
    final timelineEvents = [
      {'date': legalCase.createdAt, 'event': 'Case Opened', 'icon': Icons.create},
      if (legalCase.updatedAt != null)
        {'date': legalCase.updatedAt!, 'event': 'Last Updated', 'icon': Icons.update},
    ];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timeline, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Case Timeline',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: timelineEvents
                  .map((event) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                event['icon'] as IconData,
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event['event'] as String,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    _formatDate(event['date'] as DateTime),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
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
        _buildDetailItem('Case ID', legalCase.id, Icons.numbers),
        _buildDetailItem('Client', legalCase.clientName ?? 'Client ${legalCase.clientId}', Icons.person),
        _buildDetailItem('Legal Officer', legalCase.legalOfficerName ?? 'Officer ${legalCase.legalOfficerId}', Icons.badge),
        _buildDetailItem('Opened Date', _formatDate(legalCase.createdAt), Icons.calendar_today),
        if (legalCase.updatedAt != null)
          _buildDetailItem('Last Updated', _formatDate(legalCase.updatedAt!), Icons.update),
        _buildDetailItem('Priority', legalCase.priority ?? 'Not Set', Icons.flag),
      ],
    );
  }

  Widget _buildMobileDetailsList() {
    return Column(
      children: [
        _buildDetailItem('Case ID', legalCase.id, Icons.numbers),
        const SizedBox(height: 12),
        _buildDetailItem('Client', legalCase.clientName ?? 'Client ${legalCase.clientId}', Icons.person),
        const SizedBox(height: 12),
        _buildDetailItem('Legal Officer', legalCase.legalOfficerName ?? 'Officer ${legalCase.legalOfficerId}', Icons.badge),
        const SizedBox(height: 12),
        _buildDetailItem('Opened Date', _formatDate(legalCase.createdAt), Icons.calendar_today),
        if (legalCase.updatedAt != null) ...[
          const SizedBox(height: 12),
          _buildDetailItem('Last Updated', _formatDate(legalCase.updatedAt!), Icons.update),
        ],
        const SizedBox(height: 12),
        _buildDetailItem('Priority', legalCase.priority ?? 'Not Set', Icons.flag),
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

  Widget _buildDocumentsList() {
    final documents = [
      {'name': 'Contract Agreement.pdf', 'size': '2.4 MB', 'type': 'Contract', 'date': 'Jan 15, 2023'},
      {'name': 'Evidence Collection.docx', 'size': '1.1 MB', 'type': 'Evidence', 'date': 'Feb 20, 2023'},
      {'name': 'Legal Correspondence.pdf', 'size': '0.8 MB', 'type': 'Correspondence', 'date': 'Mar 5, 2023'},
      {'name': 'Court Filing Documents.pdf', 'size': '3.2 MB', 'type': 'Court', 'date': 'Apr 12, 2023'},
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
                            '${doc['type']!} • ${doc['size']!} • ${doc['date']!}',
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
                    // Implement update case
                  },
                  icon: const Icon(Icons.edit, size: 20),
                  label: const Text('Update Case'),
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
                    // Implement add document
                  },
                  icon: const Icon(Icons.attach_file, size: 20),
                  label: const Text('Add Document'),
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
              if (legalCase.status != 'Closed' && legalCase.status != 'Completed')
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Implement close case
                    },
                    icon: const Icon(Icons.check_circle, size: 20),
                    label: const Text('Close Case'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green,
                      side: const BorderSide(color: Colors.green),
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
                    // Implement update case
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Update Case'),
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
                        // Implement add document
                      },
                      icon: const Icon(Icons.attach_file, size: 18),
                      label: const Text('Add Document'),
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
                  if (legalCase.status != 'Closed' && legalCase.status != 'Completed')
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Implement close case
                        },
                        icon: const Icon(Icons.check_circle, size: 18),
                        label: const Text('Close'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green,
                          side: const BorderSide(color: Colors.green),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.blue;
      case 'in progress':
      case 'active':
        return Colors.orange;
      case 'closed':
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Case Details',
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
              // Share case details
            },
            tooltip: 'Share Case',
          ),
          IconButton(
            icon: const Icon(Icons.print, size: 22),
            onPressed: () {
              // Print case details
            },
            tooltip: 'Print Case',
          ),
        ],
      ),
      body: Responsive.isDesktop(context) 
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }
}
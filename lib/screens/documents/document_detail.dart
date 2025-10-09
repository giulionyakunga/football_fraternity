import 'package:flutter/material.dart';
import 'package:football_fraternity/models/document.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class DocumentDetailScreen extends StatelessWidget {
  final Document document;

  const DocumentDetailScreen({super.key, required this.document});

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - Document Preview and Quick Actions
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
                        // Document Icon
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: _getDocumentColor(document.type).withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _getDocumentColor(document.type).withOpacity(0.3),
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            _getDocumentIcon(document.type),
                            size: 50,
                            color: _getDocumentColor(document.type),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Status
                        _buildStatusChip(document.status),
                        const SizedBox(height: 20),
                        
                        // Quick Info
                        _buildQuickInfo(context),
                        const SizedBox(height: 25),
                        
                        // Action Buttons
                        _buildActionButtons(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Related Documents
                _buildRelatedDocuments(),
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
                // Document Header
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
                        Text(
                          document.title,
                          style: AppStyles.heading1.copyWith(
                            fontSize: 28,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getDocumentTypeLabel(document.type),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Document Details
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
                        _buildSectionHeader(context, 'Document Information', Icons.info),
                        const SizedBox(height: 20),
                        _buildDesktopDetailsGrid(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Description
                if (document.description != null && document.description!.isNotEmpty)
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
                          _buildSectionHeader(context, 'Description', Icons.description),
                          const SizedBox(height: 16),
                          Text(
                            document.description!,
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
          // Document Header
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Document Icon and Title
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _getDocumentColor(document.type).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getDocumentIcon(document.type),
                          size: 28,
                          color: _getDocumentColor(document.type),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              document.title,
                              style: AppStyles.heading1.copyWith(
                                fontSize: Responsive.isTablet(context) ? 22 : 20,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _getDocumentTypeLabel(document.type),
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
                  _buildStatusChip(document.status),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Quick Info
          _buildQuickInfo(context),
          const SizedBox(height: 20),

          // Document Details
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
                  _buildSectionHeader(context, 'Document Details', Icons.info),
                  const SizedBox(height: 16),
                  _buildMobileDetailsList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Description
          if (document.description != null && document.description!.isNotEmpty)
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
                    _buildSectionHeader(context, 'Description', Icons.description),
                    const SizedBox(height: 12),
                    Text(
                      document.description!,
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

          // Action Buttons
          _buildActionButtons(context),
          const SizedBox(height: 20),

          // Related Documents
          _buildRelatedDocuments(),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color statusColor = _getStatusColor(status);
    IconData statusIcon;
    String statusText;

    switch (status.toLowerCase()) {
      case 'verified':
        statusIcon = Icons.verified;
        statusText = 'Verified';
        break;
      case 'pending':
        statusIcon = Icons.pending;
        statusText = 'Pending Review';
        break;
      case 'rejected':
        statusIcon = Icons.cancel;
        statusText = 'Rejected';
        break;
      default:
        statusIcon = Icons.help;
        statusText = status;
    }

    return Container(
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
    );
  }

  Widget _buildQuickInfo(BuildContext context) {
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
            _buildQuickInfoItem(Icons.calendar_today, 'Uploaded', document.date),
            _buildQuickInfoItem(Icons.storage, 'Size', document.size),
            if (Responsive.isDesktop(context))
              _buildQuickInfoItem(Icons.person, 'Uploader', document.uploadedBy),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
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
        _buildDetailItem('Document Type', document.type, Icons.description),
        _buildDetailItem('Upload Date', document.date, Icons.calendar_today),
        _buildDetailItem('File Size', document.size, Icons.storage),
        _buildDetailItem('Uploaded By', document.uploadedBy, Icons.person),
        _buildDetailItem('File Format', _getFileFormat(document.title), Icons.insert_drive_file),
        _buildDetailItem('Last Modified', document.date, Icons.update),
      ],
    );
  }

  Widget _buildMobileDetailsList() {
    return Column(
      children: [
        _buildDetailItem('Document Type', document.type, Icons.description),
        const SizedBox(height: 12),
        _buildDetailItem('Upload Date', document.date, Icons.calendar_today),
        const SizedBox(height: 12),
        _buildDetailItem('File Size', document.size, Icons.storage),
        const SizedBox(height: 12),
        _buildDetailItem('Uploaded By', document.uploadedBy, Icons.person),
        const SizedBox(height: 12),
        _buildDetailItem('File Format', _getFileFormat(document.title), Icons.insert_drive_file),
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

  Widget _buildActionButtons(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement download
                  },
                  icon: const Icon(Icons.download, size: 20),
                  label: const Text('Download Document'),
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
                    // Implement preview
                  },
                  icon: const Icon(Icons.visibility, size: 20),
                  label: const Text('Preview'),
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
              if (document.status == 'Pending')
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Implement delete
                    },
                    icon: const Icon(Icons.delete, size: 20),
                    label: const Text('Delete'),
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
                    // Implement download
                  },
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Download Document'),
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
                        // Implement preview
                      },
                      icon: const Icon(Icons.visibility, size: 18),
                      label: const Text('Preview'),
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
                  if (document.status == 'Pending')
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Implement delete
                        },
                        icon: const Icon(Icons.delete, size: 18),
                        label: const Text('Delete'),
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

  Widget _buildRelatedDocuments() {
    // Mock related documents
    final relatedDocs = [
      {'title': 'Contract Agreement.pdf', 'type': 'Contract', 'date': 'Jan 15, 2023'},
      {'title': 'Medical Report.pdf', 'type': 'Medical', 'date': 'Feb 1, 2023'},
      {'title': 'ID Verification.pdf', 'type': 'Identification', 'date': 'Jan 10, 2023'},
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
                Icon(Icons.link, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Related Documents',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              children: relatedDocs
                  .map((doc) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getDocumentIcon(doc['type']!),
                              color: _getDocumentColor(doc['type']!),
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doc['title']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${doc['type']!} • ${doc['date']!}',
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
                                Icons.visibility,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              onPressed: () {
                                // View related document
                              },
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'verified':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getDocumentColor(String type) {
    switch (type.toLowerCase()) {
      case 'contract':
        return Colors.blue;
      case 'medical':
        return Colors.green;
      case 'identification':
        return Colors.purple;
      case 'financial':
        return Colors.orange;
      case 'legal':
        return Colors.red;
      default:
        return AppColors.primary;
    }
  }

  IconData _getDocumentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'contract':
        return Icons.assignment;
      case 'medical':
        return Icons.medical_services;
      case 'identification':
        return Icons.badge;
      case 'financial':
        return Icons.attach_money;
      case 'legal':
        return Icons.gavel;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _getDocumentTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'contract':
        return 'Contract Document';
      case 'medical':
        return 'Medical Report';
      case 'identification':
        return 'Identification Document';
      case 'financial':
        return 'Financial Statement';
      case 'legal':
        return 'Legal Document';
      default:
        return 'Document';
    }
  }

  String _getFileFormat(String title) {
    if (title.toLowerCase().contains('.pdf')) return 'PDF';
    if (title.toLowerCase().contains('.doc')) return 'Word Document';
    if (title.toLowerCase().contains('.jpg') || title.toLowerCase().contains('.png')) return 'Image';
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Document Details',
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
              // Share document
            },
            tooltip: 'Share Document',
          ),
          IconButton(
            icon: const Icon(Icons.print, size: 22),
            onPressed: () {
              // Print document
            },
            tooltip: 'Print Document',
          ),
        ],
      ),
      body: Responsive.isDesktop(context) 
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }
}
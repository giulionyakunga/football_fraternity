import 'package:flutter/material.dart';
import 'package:football_fraternity/models/document.dart';
import 'package:football_fraternity/widgets/document_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class DocumentsListScreen extends StatelessWidget {
  const DocumentsListScreen({super.key});

  final List<Document> documents = const [
    Document(
      id: '1',
      title: 'Contract Agreement - Kibu Denis',
      type: 'Contract',
      date: '2023-05-15',
      size: '2.5 MB',
      status: 'Verified',
      url: '',
      uploadedBy: 'Admin User',
    ),
    Document(
      id: '2',
      title: 'Player Registration Form',
      type: 'Registration',
      date: '2023-06-20',
      size: '1.8 MB',
      status: 'Pending',
      url: '',
      uploadedBy: 'Manager',
    ),
    Document(
      id: '3',
      title: 'Medical Examination Report',
      type: 'Medical',
      date: '2023-07-10',
      size: '3.2 MB',
      status: 'Verified',
      url: '',
      uploadedBy: 'Medical Team',
    ),
    Document(
      id: '4',
      title: 'ID Verification Document',
      type: 'Identification',
      date: '2023-04-05',
      size: '1.5 MB',
      status: 'Verified',
      url: '',
      uploadedBy: 'Admin User',
    ),
    Document(
      id: '5',
      title: 'Transfer Certificate',
      type: 'Transfer',
      date: '2023-08-15',
      size: '2.1 MB',
      status: 'Pending',
      url: '',
      uploadedBy: 'Legal Team',
    ),
    Document(
      id: '6',
      title: 'Financial Agreement',
      type: 'Financial',
      date: '2023-03-22',
      size: '4.7 MB',
      status: 'Verified',
      url: '',
      uploadedBy: 'Finance Department',
    ),
    Document(
      id: '7',
      title: 'Performance Report Q3',
      type: 'Report',
      date: '2023-09-30',
      size: '2.8 MB',
      status: 'Rejected',
      url: '',
      uploadedBy: 'Analytics Team',
    ),
    Document(
      id: '8',
      title: 'Insurance Policy Document',
      type: 'Insurance',
      date: '2023-02-14',
      size: '5.1 MB',
      status: 'Verified',
      url: '',
      uploadedBy: 'HR Department',
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
                    'Document Management',
                    style: AppStyles.heading1.copyWith(
                      fontSize: 36,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage all player documents and agreements',
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

          // Documents Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 0.9,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return DocumentCard(document: documents[index]);
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
            'Document Management',
            style: AppStyles.heading1.copyWith(
              fontSize: Responsive.isTablet(context) ? 28 : 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage all player documents and agreements',
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

          // Documents List
          Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: DocumentCard(document: documents[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    final verifiedCount = documents.where((doc) => doc.status == 'Verified').length;
    final pendingCount = documents.where((doc) => doc.status == 'Pending').length;
    final rejectedCount = documents.where((doc) => doc.status == 'Rejected').length;
    final totalSize = _calculateTotalSize();

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            _buildStatItem(documents.length.toString(), 'Total Documents', Icons.folder),
            const SizedBox(width: 30),
            _buildStatItem(verifiedCount.toString(), 'Verified', Icons.verified, Colors.green),
            const SizedBox(width: 30),
            _buildStatItem(pendingCount.toString(), 'Pending', Icons.pending, Colors.orange),
            const SizedBox(width: 30),
            _buildStatItem(totalSize, 'Total Size', Icons.storage, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileStats() {
    final verifiedCount = documents.where((doc) => doc.status == 'Verified').length;
    final pendingCount = documents.where((doc) => doc.status == 'Pending').length;

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
            _buildStatItem(documents.length.toString(), 'Total', Icons.folder),
            _buildStatItem(verifiedCount.toString(), 'Verified', Icons.verified, Colors.green),
            _buildStatItem(pendingCount.toString(), 'Pending', Icons.pending, Colors.orange),
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
                  hintText: 'Search documents...',
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
                      Text('All Documents'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'verified',
                  child: Row(
                    children: [
                      Icon(Icons.verified, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text('Verified'),
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
                  value: 'rejected',
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Text('Rejected'),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'contract',
                  child: Row(
                    children: [
                      Icon(Icons.assignment, size: 20),
                      SizedBox(width: 8),
                      Text('Contracts'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'medical',
                  child: Row(
                    children: [
                      Icon(Icons.medical_services, size: 20),
                      SizedBox(width: 8),
                      Text('Medical'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'registration',
                  child: Row(
                    children: [
                      Icon(Icons.app_registration, size: 20),
                      SizedBox(width: 8),
                      Text('Registration'),
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
                  value: 'name',
                  child: Row(
                    children: [
                      Icon(Icons.title, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Name'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'size',
                  child: Row(
                    children: [
                      Icon(Icons.storage, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Size'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'type',
                  child: Row(
                    children: [
                      Icon(Icons.category, size: 20),
                      SizedBox(width: 8),
                      Text('Sort by Type'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Upload Button (Desktop)
            if (Responsive.isDesktop(context))
              ElevatedButton.icon(
                onPressed: () {
                  // Navigator.pushNamed(context, '/documents/upload');
                },
                icon: const Icon(Icons.upload, size: 20),
                label: const Text('Upload Document'),
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
        // Navigator.pushNamed(context, '/documents/upload');
      },
      backgroundColor: AppColors.primary,
      elevation: 4,
      child: const Icon(Icons.upload, color: Colors.white, size: 28),
    );
  }

  String _calculateTotalSize() {
    double totalMB = 0;
    for (var doc in documents) {
      final sizeValue = double.tryParse(doc.size.split(' ')[0]) ?? 0;
      totalMB += sizeValue;
    }
    
    if (totalMB >= 1000) {
      return '${(totalMB / 1000).toStringAsFixed(1)} GB';
    } else {
      return '${totalMB.toStringAsFixed(1)} MB';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Document Management',
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
              icon: const Icon(Icons.upload),
              onPressed: () {
                // Navigator.pushNamed(context, '/documents/upload');
              },
              tooltip: 'Upload Document',
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
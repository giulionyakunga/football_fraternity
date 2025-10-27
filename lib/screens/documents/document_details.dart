import 'package:flutter/material.dart';
import 'package:football_fraternity/env.dart';
import 'package:football_fraternity/models/document.dart';
import 'package:football_fraternity/services/storage_service.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:html' as html; // Add this import



class DocumentDetailsScreen extends StatefulWidget {
  final Document document;
  const DocumentDetailsScreen({super.key, required this.document});

  @override
  State<DocumentDetailsScreen> createState() => _DocumentDetailsScreenState(); 
}

class _DocumentDetailsScreenState extends State<DocumentDetailsScreen> {
  late Document document;
  int userId = 0;
  late final StorageService _storageService;


   @override
  void initState() {
    super.initState();
    _initializeServices();
    document = widget.document;
  }

  Future<void> _initializeServices() async {
    final prefs = await SharedPreferences.getInstance();
    _storageService = StorageService(prefs);
    _loadUserProfile();
  }

  void _loadUserProfile() {
    final profile = _storageService.getUserProfile();
    if (profile != null) {
      setState(() {
        userId = profile.id;
      });
    }
  }

  // Future<void> _fetchDocument(String documentName) async {
  //   try {
  //     final Uri uri = Uri.parse('${backend_url}api/document/$documentName');
  //     final response = await http.get(uri);

  //     if (response.statusCode == 200) {
  //       // Get the documents directory
  //       final directory = await getApplicationDocumentsDirectory();
        
  //       // Create file path
  //       final filePath = '${directory.path}/$documentName';
  //       final file = File(filePath);
        
  //       // Write the file
  //       await file.writeAsBytes(response.bodyBytes);
        
  //       // Optional: Show success message
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Document downloaded successfully: $filePath'),
  //           ),
  //         );
  //       }
        
  //       debugPrint('Document downloaded to: $filePath');
  //     } else {
  //       throw Exception('Failed to download document: ${response.statusCode}');
  //     }
  //   } on SocketException catch (e) {
  //     debugPrint('Network error occurred:');
  //     debugPrint('- Exception type: ${e.runtimeType}');
  //     debugPrint('- Message: ${e.message}');
      
  //     if (e.osError != null) {
  //       debugPrint('  - Error number (errno): ${e.osError!.errorCode}');
  //       debugPrint('  - OS message: ${e.osError!.message}');
  //     }
      
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Network error: Please check your internet connection'),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     debugPrint('Error downloading document: $e');
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error downloading document: $e'),
  //         ),
  //       );
  //     }
  //   }
  // }

  Future<void> _fetchDocument(String documentName) async {
    try {
      final Uri uri = Uri.parse('${backend_url}api/document/$documentName');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // Create a blob from the response bytes
        final blob = html.Blob([response.bodyBytes]);
        
        // Create an object URL from the blob
        final url = html.Url.createObjectUrlFromBlob(blob);
        
        // Create a temporary anchor element to trigger download
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', documentName)
          ..style.display = 'none';
        
        // Add to DOM, click, and remove
        html.document.body?.append(anchor);
        anchor.click();
        anchor.remove(); // Use remove() instead of removeChild()
        
        // Clean up the object URL
        html.Url.revokeObjectUrl(url);
        
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Download started: $documentName'),
            ),
          );
        }
        
        debugPrint('Document download triggered: $documentName');
      } else {
        throw Exception('Failed to download document: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      debugPrint('Network error occurred: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Network error: Please check your internet connection'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error downloading document: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading document: $e'),
          ),
        );
      }
    }
  }

   Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
                              color: _getDocumentColor(document.documentType).withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _getDocumentColor(document.documentType).withOpacity(0.3),
                                width: 3,
                              ),
                            ),
                            child: Icon(
                              _getDocumentIcon(document.documentType),
                              size: 50,
                              color: _getDocumentColor(document.documentType),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Status
                          _buildStatusChip(document.fileType, document.fileName),
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
                            _getDocumentTypeLabel(document.documentType),
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
        )
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
                          color: _getDocumentColor(document.documentType).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getDocumentIcon(document.documentType),
                          size: 28,
                          color: _getDocumentColor(document.documentType),
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
                              _getDocumentTypeLabel(document.documentType),
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
                  _buildStatusChip(document.fileType, document.fileName),
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
        ],
      ),
    );
  }

  Widget _buildStatusChip(String fileType, String fileName) {
    Color statusColor = _getStatusColor(fileName);
    IconData statusIcon;
    String statusText;

    switch (fileType.toLowerCase()) {
      case 'pdf':
        statusIcon = Icons.picture_as_pdf;
        statusText = 'PDF';
        break;
      case 'word':
        statusIcon = Icons.wordpress;
        statusText = 'DOCX';
        break;
      case 'xlsx':
        statusIcon = Icons.one_x_mobiledata;
        statusText = 'XLSC';
        break;
      default:
        statusIcon = Icons.help;
        statusText = "Other";
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

  String _formatDateTime(DateTime date) {
    return '${_formatDate(date)} ${_formatTime(date)}';
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour < 12 ? 'AM' : 'PM';
    return '$hour:${date.minute.toString().padLeft(2, '0')} $period';
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
            _buildQuickInfoItem(Icons.calendar_today, 'Uploaded', _formatDateTime(document.createdAt)),
            _buildQuickInfoItem(Icons.storage, 'Size', document.size),
            if (Responsive.isDesktop(context))
              _buildQuickInfoItem(Icons.person, 'Uploader', "Admin"),
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
        _buildDetailItem('Type', document.documentType, Icons.description),
        _buildDetailItem('Name', document.fileName, Icons.file_copy),
        _buildDetailItem('Upload Date', _formatDateTime(document.createdAt), Icons.calendar_today),
        _buildDetailItem('File Size', document.size, Icons.storage),
        _buildDetailItem('Uploaded By', "Admin", Icons.person),
        _buildDetailItem('File Format', _getFileFormat(document.fileName), Icons.insert_drive_file),
        _buildDetailItem('Last Modified', _formatDateTime(document.createdAt), Icons.update),
      ],
    );
  }

  Widget _buildMobileDetailsList() {
    return Column(
      children: [
        _buildDetailItem('Type', document.documentType, Icons.description),
        const SizedBox(height: 12),
        _buildDetailItem('Name', document.fileName, Icons.file_copy),
        const SizedBox(height: 12),
        _buildDetailItem('Upload Date', _formatDateTime(document.createdAt), Icons.calendar_today),
        const SizedBox(height: 12),
        _buildDetailItem('File Size', document.size, Icons.storage),
        const SizedBox(height: 12),
        _buildDetailItem('Uploaded By', "Admin", Icons.person),
        const SizedBox(height: 12),
        _buildDetailItem('File Format', _getFileFormat(document.fileName), Icons.insert_drive_file),
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
                    _fetchDocument(document.fileUrl);
                  },
                  icon: const Icon(
                    Icons.download, 
                    size: 20,
                    color: Colors.white
                  ),
                  label: const Text(
                    'Download Document',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
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
              // Expanded(
              //   child: OutlinedButton.icon(
              //     onPressed: () {
              //       // Implement preview
              //     },
              //     icon: const Icon(Icons.visibility, size: 20),
              //     label: const Text('Preview'),
              //     style: OutlinedButton.styleFrom(
              //       foregroundColor: AppColors.primary,
              //       side: BorderSide(color: AppColors.primary),
              //       padding: const EdgeInsets.symmetric(vertical: 16),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _fetchDocument(document.fileUrl);
                  },
                  icon: const Icon(
                    Icons.download, 
                    size: 18,
                    color: Colors.white
                  ),
                  label: const Text(
                    'Download Document',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
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
              // Row(
              //   children: [
              //     Expanded(
              //       child: OutlinedButton.icon(
              //         onPressed: () {
              //           // Implement preview
              //         },
              //         icon: const Icon(Icons.visibility, size: 18),
              //         label: const Text('Preview'),
              //         style: OutlinedButton.styleFrom(
              //           foregroundColor: AppColors.primary,
              //           side: BorderSide(color: AppColors.primary),
              //           padding: const EdgeInsets.symmetric(vertical: 14),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
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

  Color _getStatusColor(String fileName) {
    if (fileName.toLowerCase().contains('.pdf')) return Colors.red;
    if (fileName.toLowerCase().contains('.xlsx')) return Colors.green;
    if (fileName.toLowerCase().contains('.docx')) return Colors.blue;
    if (fileName.toLowerCase().contains('.jpg') || fileName.toLowerCase().contains('.png')) return Colors.orange;
    return Colors.grey;
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
    if (title.toLowerCase().contains('.docx')) return 'DOCX';
    if (title.toLowerCase().contains('.xlsx')) return 'Excel Sheet';
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
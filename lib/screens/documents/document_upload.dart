import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:football_fraternity/env.dart';
import 'package:football_fraternity/services/storage_service.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';


class DocumentUploadScreen extends StatefulWidget { 
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  int userId = 0;
  late final StorageService _storageService;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _type = 'Contract';
  String base64File = "";
  String? fileType;
  String? fileName;
  bool _isLoading = false;

    @override
  void initState() {
    super.initState();
    _initializeServices();
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


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _uploadDocument() async { 

    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      'user_id': userId,
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),      
      'document_type': _type,
      'file_type': fileType,
      'file_name': fileName,
      'file': base64File,
    };

    try {
      setState(() => _isLoading = true);

      final Uri uri = Uri.parse('${backend_url}api/upload_document');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        if (response.body == "Document uploaded successfully!") {
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Document uploaded successfully'),
              backgroundColor: Colors.green[600],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.body)),
          );
        }
      } else if (response.statusCode == 302) {
        _handleHTTPRedirect();
      } else {
        if(response.statusCode == 413){
          _showSnackBar('Request failed: file is Too Large');
        } else {
          _showSnackBar('Request failed: ${response.statusCode}');
        }
      }
    } on SocketException catch (e) {
        debugPrint('Network error occurred:');
        debugPrint('- Exception type: ${e.runtimeType}');
        debugPrint('- Message: ${e.message}');
        
        if (e.osError != null) {
          debugPrint('  - Error number (errno): ${e.osError!.errorCode}');
          debugPrint('  - OS message: ${e.osError!.message}');
        }

        _handleSocketException(e);
      } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleHTTPRedirect() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connection Error'),
        content: const Text('Could not connect to the server. Please check your internet connection.'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  void _handleSocketException(SocketException e) {
    if (e.osError?.errorCode == 7 || e.osError?.errorCode == 101 || e.osError?.errorCode == 111) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Connection Error'),
          content: const Text('Could not connect to the server. Please check your internet connection.'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    } else {
      _showSnackBar('Connection Error: ${e.message}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }



  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column - Upload Guidelines
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
                          // Upload Icon
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.3),
                                width: 3,
                              ),
                            ),
                            child: Icon(
                              Icons.cloud_upload,
                              size: 40,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Upload Document',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Supported formats: PDF, DOC, DOCX, JPG, PNG',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 25),
                          _buildUploadGuidelines(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildFileRequirements(),
                ],
              ),
            ),

            const SizedBox(width: 40),

            // Right Column - Upload Form
            Expanded(
              flex: 2,
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload New Document',
                          style: AppStyles.heading1.copyWith(
                            fontSize: 28,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Fill in the document details and select the file to upload',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Document Information Section
                        _buildSectionHeader('Document Information', Icons.description),
                        const SizedBox(height: 20),
                        _buildDesktopFormGrid(),

                        const SizedBox(height: 30),

                        // File Upload Section
                        _buildSectionHeader('File Upload', Icons.attach_file),
                        const SizedBox(height: 20),
                        _buildFileUploadSection(),

                        const SizedBox(height: 40),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  context.go('/documents');
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.grey[700],
                                  side: BorderSide(color: Colors.grey[400]!),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _uploadDocument,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 2,
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : const Text(
                                        'Upload Document',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isTablet(context) ? 30 : 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.cloud_upload,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Upload New Document',
                    style: AppStyles.heading1.copyWith(
                      fontSize: Responsive.isTablet(context) ? 24 : 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Supported formats: PDF, DOC, DOCX, JPG, PNG',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Document Information', Icons.description),
                    const SizedBox(height: 16),
                    _buildMobileFormFields(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('File Upload', Icons.attach_file),
                    const SizedBox(height: 16),
                    _buildFileUploadSection(),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _uploadDocument,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Upload Document',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          context.go('/documents');
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                          side: BorderSide(color: Colors.grey[400]!),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildFileRequirements(),
        ],
      ),
    );
  }

  Widget _buildDesktopFormGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: [
        _buildFormField(
          'Document Title *',
          'Enter document title',
          _titleController,
          Icons.title,
        ),
        _buildDocumentTypeDropdown(),
        const SizedBox(height: 16),
        _buildDescriptionField(_descriptionController),
      ],
    );
  }

  Widget _buildMobileFormFields() {
    return Column(
      children: [
        _buildFormField(
          'Document Title *',
          'Enter document title',
          _titleController,
          Icons.title,
        ),
        const SizedBox(height: 16),
        _buildDocumentTypeDropdown(),
        const SizedBox(height: 16),
        _buildDescriptionField(_descriptionController),
      ],
    );
  }

  Widget _buildFormField(
    String label,
    String hint,
    TextEditingController controller,
    IconData icon,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${label}';
        }
        return null;
      },
    );
  }

  Widget _buildDocumentTypeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Document Type *',
        prefixIcon: Icon(Icons.category, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      value: _type,
      items: const [
        DropdownMenuItem(
          value: 'Contract',
          child: Text('Contract Agreement'),
        ),
        DropdownMenuItem(
          value: 'Registration',
          child: Text('Player Registration'),
        ),
        DropdownMenuItem(
          value: 'Medical',
          child: Text('Medical Report'),
        ),
        DropdownMenuItem(
          value: 'Identification',
          child: Text('Identification'),
        ),
        DropdownMenuItem(
          value: 'Financial',
          child: Text('Financial Document'),
        ),
        DropdownMenuItem(
          value: 'Legal',
          child: Text('Legal Document'),
        ),
        DropdownMenuItem(
          value: 'Insurance',
          child: Text('Insurance Policy'),
        ),
        DropdownMenuItem(
          value: 'Other',
          child: Text('Other Document'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _type = value!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select document type';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Description (Optional)',
        hintText: 'Enter document description...',
        prefixIcon: Icon(Icons.description, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      maxLines: 3,
    );
  }

  Widget _buildFileUploadSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.insert_drive_file,
              size: 48,
              color: fileName != null ? AppColors.primary : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              fileName ?? 'No file selected',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: fileName != null ? Colors.black87 : Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Maximum file size: 10MB',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();

                  if (result != null && result.files.isNotEmpty) {
                    PlatformFile platformFile = result.files.first;
                    
                    List<int> bytes;
                    
                    if (kIsWeb) {
                      // For web - use the bytes directly from platformFile
                      bytes = platformFile.bytes!;
                    } else {
                      // For mobile/desktop - read from file path
                      File file = File(platformFile.path!);
                      bytes = await file.readAsBytes();
                    }

                    setState(() {
                      fileType = lookupMimeType(platformFile.name) ?? 'application/octet-stream';
                      fileName = platformFile.name;
                      base64File = base64Encode(bytes);
                    });

                    debugPrint('File selected: $fileName, Size: ${bytes.length} bytes');
                  } else {
                    debugPrint('No file selected');
                  }
                } catch (e) {
                  debugPrint('Error picking file: $e');
                  // Show error to user if needed
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error selecting file: $e'),
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.attach_file, size: 20),
              label: Text( (fileName != null) ? 'Selected: $fileName' : 'Choose Files'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey[400]!),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildUploadGuidelines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Guidelines',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        _buildGuidelineItem('Ensure file is clear and readable'),
        _buildGuidelineItem('PDF format preferred for contracts'),
        _buildGuidelineItem('Maximum file size: 10MB'),
        _buildGuidelineItem('Name files descriptively'),
        _buildGuidelineItem('Verify document authenticity'),
      ],
    );
  }

  Widget _buildFileRequirements() {
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
                Icon(Icons.info, color: Colors.blue[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  'File Requirements',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildFileTypeChip('PDF'),
                _buildFileTypeChip('DOC'),
                _buildFileTypeChip('DOCX'),
                _buildFileTypeChip('JPG'),
                _buildFileTypeChip('PNG'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green[600], size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileTypeChip(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Text(
        '.$type',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Document',
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
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(),
    );
  }
}
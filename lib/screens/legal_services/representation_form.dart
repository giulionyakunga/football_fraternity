import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:football_fraternity/env.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

class RepresentationFormScreen extends StatefulWidget {
  const RepresentationFormScreen({super.key});

  @override
  State<RepresentationFormScreen> createState() => _RepresentationFormScreenState();
}

class _RepresentationFormScreenState extends State<RepresentationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _caseTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _opposingPartyController = TextEditingController();
  String _caseType = 'Contract Dispute';

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _submitted = false;
  String base64File = "";
  String base64File1 = "";
  String base64File2 = "";
  String? fileType;
  String? fileType1;
  String? fileType2;
  String? fileName;
  String? fileName1;
  String? fileName2;

  Future<void> _submitRequest() async { 

    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      'name': _nameController.text.trim(),
      'phone_number': _phoneNumberController.text.trim(),
      'email': _emailController.text.trim(),
      'case_title': _caseTitleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'opposing_party': _opposingPartyController.text.trim(),
      'service_type': 'Legal Representation',
      'case_type': _caseType,
      'file_type': fileType,
      'file_type1': fileType1,
      'file_type2': fileType2,
      'file_name': fileName,
      'file_name1': fileName1,
      'file_name2': fileName2,
      'file': base64File,
      'file1': base64File1,
      'file2': base64File2,
    };

    try {
      setState(() => _isLoading = true);

      final Uri uri = Uri.parse('${backend_url}api/submit_request');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        if (response.body == "Request submitted successfully!") {
          setState(() {
            _submitted = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Representation request submitted successfully'),
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

  Widget _buildDesktopLayout() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side - Information and benefits
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 40, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.people,
                              size: 60,
                              color: AppColors.primary,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Legal Representation',
                              style: AppStyles.heading1.copyWith(
                                fontSize: 28,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Get professional legal representation for your football-related matters. Our experienced team will fight for your rights and ensure the best possible outcome.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 30),
                            _buildFeatureItem(
                              Icons.security,
                              'Expert Representation',
                              'Experienced lawyers specializing in football law',
                            ),
                            _buildFeatureItem(
                              Icons.work,
                              'Case Management',
                              'Comprehensive handling of your legal matter',
                            ),
                            _buildFeatureItem(
                              Icons.timeline,
                              'Regular Updates',
                              'Stay informed with progress reports',
                            ),
                            _buildFeatureItem(
                              Icons.attach_money,
                              'Cost-Effective',
                              'Transparent pricing with no hidden fees',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Right side - Form
            Expanded(
              flex: 1,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: _buildFormContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isTablet(context) ? 40 : 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(
              Icons.people,
              size: 50,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Legal Representation Request',
              style: AppStyles.heading1.copyWith(
                fontSize: Responsive.isTablet(context) ? 24 : 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Professional legal representation for football matters',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _buildFormContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!Responsive.isDesktop(context)) ...[
            const SizedBox(height: 10),
          ],

          // Name
          Text(
            'Name',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isDesktop(context) ? 16 : 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter your name',
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
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: Responsive.isDesktop(context) ? 18 : 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Phone Number
          Text(
            'Phone Number',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isDesktop(context) ? 16 : 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _phoneNumberController,
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
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
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: Responsive.isDesktop(context) ? 18 : 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Email
          Text(
            'Email',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isDesktop(context) ? 16 : 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'Enter your email',
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
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: Responsive.isDesktop(context) ? 18 : 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          
          // Case Type
          Text(
            'Case Type2 *',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isDesktop(context) ? 16 : 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _caseType,
            decoration: InputDecoration(
              hintText: 'Select your case type',
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
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: Responsive.isDesktop(context) ? 18 : 16,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Contract Dispute',
                child: Text('Contract Dispute'),
              ),
              DropdownMenuItem(
                value: 'Footballer Management',
                child: Text('Footballer Management'),
              ),
              DropdownMenuItem(
                value: 'Transfer Negotiation',
                child: Text('Transfer Negotiation'),
              ),
              DropdownMenuItem(
                value: 'Disciplinary Matter',
                child: Text('Disciplinary Matter'),
              ),
              DropdownMenuItem(
                value: 'Salary Dispute',
                child: Text('Salary Dispute'),
              ),
              DropdownMenuItem(
                value: 'Image Rights',
                child: Text('Image Rights'),
              ),
              DropdownMenuItem(
                value: 'Termination Issue',
                child: Text('Termination Issue'),
              ),
              DropdownMenuItem(
                value: 'Other',
                child: Text('Other'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _caseType = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a case type';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Case Title
          Text(
            'Case Title *',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isDesktop(context) ? 16 : 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _caseTitleController,
            decoration: InputDecoration(
              hintText: 'e.g., Contract Termination Dispute with FC United',
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
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: Responsive.isDesktop(context) ? 18 : 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a case title';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Opposing Party
          Text(
            'Opposing Party *',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isDesktop(context) ? 16 : 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _opposingPartyController,
            decoration: InputDecoration(
              hintText: 'e.g., Club Name, Association, or Individual',
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
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: Responsive.isDesktop(context) ? 18 : 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the opposing party';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Case Details
          Text(
            'Case Details *',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isDesktop(context) ? 16 : 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              hintText: 'Describe your case in detail including timeline, key events, and desired outcome...',
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
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            maxLines: Responsive.isDesktop(context) ? 6 : 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please describe your case';
              }
              if (value.length < 30) {
                return 'Please provide more details (at least 30 characters)';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),

          // Supporting Documents
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey[300]!),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_file,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Supporting Documents',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Responsive.isDesktop(context) ? 16 : 15,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Upload relevant documents such as contracts, correspondence, evidence, or any supporting materials (PDF, DOC, Images)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          // Implement file picker
                          FilePickerResult? result = await FilePicker.platform.pickFiles();

                          if (result != null) {
                            // Get the selected file
                            PlatformFile platformFile = result.files.first;
                            File file = File(platformFile.path!);

                            setState(() {
                              // Get the file's MIME type based on its extension
                              fileType = lookupMimeType(platformFile.path!);
                              fileName = platformFile.name;
                              fileType ??= 'application/octet-stream';
                            });

                            // Read the file as bytes
                            List<int> bytes = await file.readAsBytes();

                            setState(() {
                              // Encode the file as a base64 string (for non-web, you may use this)
                              base64File = base64Encode(bytes);
                            });
                          } else {
                            // Handle the case when the user cancels the file picker
                            debugPrint('No file selected');
                          }
                        },
                        icon: const Icon(Icons.attach_file, size: 20),
                        label: Text( (fileName != null) ? 'Selected: $fileName' : 'Upload Contract'),
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
                      ElevatedButton.icon(
                        onPressed: () async {
                          // Implement file picker
                          FilePickerResult? result = await FilePicker.platform.pickFiles();

                          if (result != null) {
                            // Get the selected file
                            PlatformFile platformFile = result.files.first;
                            File file = File(platformFile.path!);

                            setState(() {
                              // Get the file's MIME type based on its extension
                              fileType1 = lookupMimeType(platformFile.path!);
                              fileName1 = platformFile.name;
                              fileType1 ??= 'application/octet-stream';
                            });

                            // Read the file as bytes
                            List<int> bytes = await file.readAsBytes();

                            setState(() {
                              // Encode the file as a base64 string (for non-web, you may use this)
                              base64File1 = base64Encode(bytes);
                            });
                          } else {
                            // Handle the case when the user cancels the file picker
                            debugPrint('No file selected');
                          }
                        },
                        icon: const Icon(Icons.attach_file, size: 20),
                        label: Text( (fileName1 != null) ? 'Selected: $fileName1' : 'Upload Correspondence'),
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

                      ElevatedButton.icon(
                        onPressed: () async {
                          // Implement file picker
                          FilePickerResult? result = await FilePicker.platform.pickFiles();

                          if (result != null) {
                            // Get the selected file
                            PlatformFile platformFile = result.files.first;
                            File file = File(platformFile.path!);

                            setState(() {
                              // Get the file's MIME type based on its extension
                              fileType2 = lookupMimeType(platformFile.path!);
                              fileName2 = platformFile.name;
                              fileType2 ??= 'application/octet-stream';
                            });

                            // Read the file as bytes
                            List<int> bytes = await file.readAsBytes();

                            setState(() {
                              // Encode the file as a base64 string (for non-web, you may use this)
                              base64File2 = base64Encode(bytes);
                            });
                          } else {
                            // Handle the case when the user cancels the file picker
                            debugPrint('No file selected');
                          }
                        },
                        icon: const Icon(Icons.attach_file, size: 20),
                        label: Text( (fileName2 != null) ? 'Selected: $fileName2' : 'Upload Evidence'),
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitted ? null : () {
                if (_formKey.currentState!.validate()) {
                  // Submit request
                  _submitRequest();
                }
              },
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: _submitted ? AppColors.success : AppColors.primary,
                backgroundColor: _submitted ? AppColors.success : AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              child: _isLoading ? const CircularProgressIndicator() :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send, size: 20, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    _submitted ? 'Request Submitted' : 'Submit Representation Request',
                    style: TextStyle(
                      fontSize: Responsive.isDesktop(context) ? 16 : 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'We will review your case and contact you within 24 hours',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Legal Representation',
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
      body: SingleChildScrollView(
        padding: Responsive.isDesktop(context) 
            ? const EdgeInsets.symmetric(vertical: 40, horizontal: 20)
            : EdgeInsets.zero,
        child: Responsive.isDesktop(context)
            ? _buildDesktopLayout()
            : _buildMobileLayout(),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _caseTitleController.dispose();
    _descriptionController.dispose();
    _opposingPartyController.dispose();
    super.dispose();
  }
}
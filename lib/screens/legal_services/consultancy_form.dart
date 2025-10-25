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

class ConsultancyFormScreen extends StatefulWidget {
  const ConsultancyFormScreen({super.key});

  @override
  State<ConsultancyFormScreen> createState() => _ConsultancyFormScreenState();
}

class _ConsultancyFormScreenState extends State<ConsultancyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _consultancyType = 'Contract Review';
  bool _isLoading = false;
  bool _submitted = false;
  String base64File = "";
  String? fileType;
  String? fileName;
  
  Future<void> _submitRequest() async { 

    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      'name': _nameController.text.trim(),
      'phone_number': _phoneNumberController.text.trim(),
      'email': _emailController.text.trim(),
      'subject': _subjectController.text.trim(),
      'description': _descriptionController.text.trim(),
      'service_type': 'Legal Consultancy',
      'consultancy_type': _consultancyType,
      'file_type': fileType,
      'file_name': fileName,
      'file': base64File,
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
              content: const Text('Consultancy request submitted successfully'),
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
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Information
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.gavel,
                          size: 60,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Legal Consultancy Request',
                          style: AppStyles.heading1.copyWith(
                            fontSize: 28,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Get expert legal advice for your football career. Our experienced team will review your contracts, provide transfer advice, and help resolve disputes.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildInfoItem(
                          Icons.check_circle,
                          'Expert Contract Review',
                          'Thorough analysis of your football contracts',
                        ),
                        _buildInfoItem(
                          Icons.check_circle,
                          'Transfer Guidance',
                          'Professional advice on player transfers',
                        ),
                        _buildInfoItem(
                          Icons.check_circle,
                          'Dispute Resolution',
                          'Help with football-related legal disputes',
                        ),
                      ],
                    ),
                  ),
                ),

                // Vertical divider
                Container(
                  width: 1,
                  height: 500,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),

                // Right side - Form
                Expanded(
                  flex: 1,
                  child: _buildFormContent(),
                ),
              ],
            ),
          ),
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
          Center(
            child: Icon(
              Icons.gavel,
              size: 50,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Legal Consultancy Request',
              style: AppStyles.heading1.copyWith(
                fontSize: Responsive.isTablet(context) ? 24 : 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Get expert legal advice for your football career',
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
          
          // Consultancy Type
          Text(
            'Consultancy Type',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isDesktop(context) ? 16 : 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _consultancyType,
            decoration: InputDecoration(
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
                value: 'Contract Review',
                child: Text('Contract Review'),
              ),
              DropdownMenuItem(
                value: 'Transfer Advice',
                child: Text('Transfer Advice'),
              ),
              DropdownMenuItem(
                value: 'Dispute Resolution',
                child: Text('Dispute Resolution'),
              ),
              DropdownMenuItem(
                value: 'Regulatory Compliance',
                child: Text('Regulatory Compliance'),
              ),
              DropdownMenuItem(
                value: 'Other',
                child: Text('Other'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _consultancyType = value!;
              });
            },
          ),
          const SizedBox(height: 20),
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
                borderSide: BorderSide(color: AppColors.primary, width: 2),
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
                borderSide: BorderSide(color: AppColors.primary, width: 2),
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
          // Subject
          Text(
            'Subject',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Responsive.isDesktop(context) ? 16 : 15,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _subjectController,
            decoration: InputDecoration(
              hintText: 'Enter the subject of your request',
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
                return 'Please enter a subject';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Description
          Text(
            'Detailed Description',
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
              hintText: 'Describe your legal consultancy needs in detail...',
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
                return 'Please enter a description';
              }
              if (value.length < 20) {
                return 'Please provide more details (at least 20 characters)';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),

          // Attachments
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey[300]!),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attach Relevant Documents',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Responsive.isDesktop(context) ? 16 : 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Upload contracts, agreements, or any relevant documents (PDF, DOC, Images)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
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
              Text(
                _submitted ? 'Request Submitted' : 'Submit Consultancy Request',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Responsive.isDesktop(context) ? 18 : 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 20,
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
                  subtitle,
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
          'Request Legal Consultancy',
          style: TextStyle(
            fontSize: Responsive.isDesktop(context) ? 20 : 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: Responsive.isDesktop(context) 
            ? const EdgeInsets.symmetric(vertical: 40)
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
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
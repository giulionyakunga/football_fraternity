import 'package:flutter/material.dart';
import 'package:football_fraternity/env.dart';
import 'package:football_fraternity/models/footballer.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:go_router/go_router.dart';


class FootballerForm2Screen extends StatefulWidget {
  final Footballer footballer;

  const FootballerForm2Screen({super.key, required this.footballer});

  @override
  State<FootballerForm2Screen> createState() => _FootballerForm2ScreenState();
}

class _FootballerForm2ScreenState extends State<FootballerForm2Screen> {
  int userId = 0;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey _imagePickerKey = GlobalKey();
  final _fullNameController = TextEditingController();
  final _positionController = TextEditingController();
  final _clubController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _ageController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _salaryController = TextEditingController();
  final _contractStartController = TextEditingController();
  final _contractEndController = TextEditingController();
  final _matchesController = TextEditingController();
  final _goalsController = TextEditingController();
  final _assistsController = TextEditingController();
  final _ratingController = TextEditingController();
  String _contractStatus = 'Active';
  XFile? _footballerImage;
  Uint8List? _webImageBytes;
  String? fileType;
  bool _isLoading = false;
  bool _isEditing = true;
  final ScrollController _scrollController = ScrollController();

   @override
  void initState() {
    super.initState();
   
    _fullNameController.text = widget.footballer.fullName;
    _positionController.text = widget.footballer.position;
    _clubController.text = widget.footballer.club;
    _nationalityController.text = widget.footballer.nationality;
    _ageController.text = '${widget.footballer.age}';
    _dateOfBirthController.text = widget.footballer.dateOfBirth != null ? DateFormat('yyyy-MM-dd').format(widget.footballer.dateOfBirth!) : '';
    _heightController.text = '${widget.footballer.height}';
    _weightController.text = '${widget.footballer.weight}';
    _salaryController.text = widget.footballer.salary;
    _contractStatus = widget.footballer.contractStatus;
    _contractStartController.text = widget.footballer.contractStart != null ? DateFormat('yyyy-MM-dd').format(widget.footballer.contractStart!) : '';
    _contractEndController.text = widget.footballer.contractEnd != null ? DateFormat('yyyy-MM-dd').format(widget.footballer.contractEnd!) : '';
    _matchesController.text = '${widget.footballer.matches}';
    _goalsController.text = '${widget.footballer.goals}';
    _assistsController.text = '${widget.footballer.assists}';
    _ratingController.text = '${widget.footballer.rating}';
  }

  Future<DateTime?> _selectDate(BuildContext context, DateTime initialDate) async {
    DateTime fiftyYearsAgo = DateTime.now().subtract(const Duration(days: 45 * 365)); // 50 years ago

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: fiftyYearsAgo,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      return picked;
    } else {
      return DateTime.now();
    }
  }

  Widget _buildDatePicker(TextEditingController controller, String text, DateTime initialDate) {
    return TextButton.icon(
      onPressed: () async {
        DateTime? picked = await _selectDate(context, initialDate);
        String formattedDate = DateFormat('yyyy-MM-dd').format(picked!);
        // Assign to the controller's text
        setState(() {
          controller.text = formattedDate;
        });
      },
      icon: Icon(Icons.calendar_today, color: Colors.blue[800]),
      label: Text(
        controller.text.isEmpty
            ? text
            : controller.text,
        style: TextStyle(
          color: controller.text.isEmpty ? Colors.grey[600] : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          color: controller.text.isEmpty ? Colors.grey[400]! : Colors.blue[800]!,
          width: 1.5,
        ),
        backgroundColor: Colors.grey[200],
      ),
    );
  }

  Future<void> _pickImage() async {
  final ImagePicker picker = ImagePicker();
  try {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      String? mimeType;
      String fileExtension;

      if (kIsWeb) {
        // On web, use `image.name` instead of `image.path`
        fileExtension = path.extension(image.name).toLowerCase();
        mimeType = lookupMimeType(image.name);

        // Read image as bytes for web
        final bytes = await image.readAsBytes();
        _webImageBytes = bytes;
      } else {
        fileExtension = path.extension(image.path).toLowerCase();
        mimeType = lookupMimeType(image.path);
      }

      if (mimeType == null || !mimeType.startsWith('image/')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid file type. Please select a valid image.')),
        );
        return;
      }

      if (fileExtension != '.png' && fileExtension != '.jpg' && fileExtension != '.jpeg') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unsupported image format. Only PNG and JPEG are allowed.')),
        );
        return;
      }

      setState(() {
        _footballerImage = image;
        fileType = fileExtension;
      });
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }
}


  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - Profile Image and Quick Info
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
                        Stack(
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary.withOpacity(0.3),
                                  width: 3,
                                ),
                              ),
                              child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: _footballerImage == null
                                      ? AssetImage('assets/images/footballer.png') as ImageProvider
                                      : FileImage(File(_footballerImage!.path)),
                                ),
                              ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt,
                                      color: Colors.white, size: 20),
                                  onPressed: () {
                                    // Implement image picker
                                    _pickImage();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Profile Photo',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Recommended: 500x500 px',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildFormTips(),
              ],
            ),
          ),

          const SizedBox(width: 40),

          // Right Column - Form Fields
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
                        _isEditing ? 'Edit Footballer' : 'Add New Footballer',
                        style: AppStyles.heading1.copyWith(
                          fontSize: 28,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fill in the details below to ${_isEditing ? 'update' : 'add'} the footballer',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Personal Information Section
                      _buildSectionHeader('Personal Information', Icons.person),
                      const SizedBox(height: 2),
                      _buildDesktopFormGrid(),

                      const SizedBox(height: 3),

                      // Contract Information Section
                      _buildSectionHeader('Contract Details', Icons.assignment),
                      const SizedBox(height: 2),
                      _buildContractDetails(),

                      const SizedBox(height: 3),

                      // Contract Information Section
                      _buildSectionHeader('Performance Details', Icons.assignment),
                      const SizedBox(height: 2),
                      _buildPerformanceDetails(),

                      const SizedBox(height: 4),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                context.go('/footballers');
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _saveFootballer();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 2,
                              ),
                              child: _isLoading ? const CircularProgressIndicator() :
                              Text(
                                _isEditing ? 'Update Footballer' : 'Add Footballer',
                                style: const TextStyle(
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
                  Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _footballerImage == null
                              ? AssetImage('assets/images/footballer.png') as ImageProvider
                              : FileImage(File(_footballerImage!.path)),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 16),
                            onPressed: () {
                              // Implement image picker
                              _pickImage();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isEditing ? 'Edit Footballer' : 'Add New Footballer',
                    style: AppStyles.heading1.copyWith(
                      fontSize: Responsive.isTablet(context) ? 24 : 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fill in the footballer details',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
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
                    _buildSectionHeader('Personal Information', Icons.person),
                    const SizedBox(height: 16),
                    _buildMobileFormFields(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Contract Details', Icons.assignment),
                    const SizedBox(height: 16),
                    _buildContractDetails(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Performance Details', Icons.assignment),
                    const SizedBox(height: 16),
                    _buildPerformanceDetails(),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveFootballer();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          _isEditing ? 'Update Footballer' : 'Add Footballer',
                          style: const TextStyle(
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
                          context.go('/footballers');
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
        ],
      ),
    );
  }

  Widget _buildDesktopFormGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 5.0,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildFormField(_fullNameController, 'Full Name', Icons.person, true),
        _buildFormField(_positionController, 'Position', Icons.sports_soccer, true),
        _buildFormField(_clubController, 'Club', Icons.emoji_events, true),
        _buildFormField(_nationalityController, 'Nationality', Icons.flag, true),
        _buildFormField(_ageController, 'Age', Icons.cake, true, keyboardType: TextInputType.number),
        _buildDatePicker(_dateOfBirthController,  'Select Date Of Birth', DateTime.now().subtract(const Duration(days: 20 * 365))),
        _buildFormField2(_heightController, 'Height (m)', Icons.height, false, keyboardType: TextInputType.number),
        _buildFormField2(_weightController, 'Weight (kg)', Icons.scale, false, keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildMobileFormFields() {
    return Column(
      children: [
        _buildFormField(_fullNameController, 'Full Name', Icons.person, true),
        const SizedBox(height: 16),
        _buildFormField(_positionController, 'Position', Icons.sports_soccer, true),
        const SizedBox(height: 16),
        _buildFormField(_clubController, 'Club', Icons.emoji_events, true),
        const SizedBox(height: 16),
        _buildFormField(_nationalityController, 'Nationality', Icons.flag, true),
        const SizedBox(height: 16),
        _buildFormField(_ageController, 'Age', Icons.cake, true, keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildDatePicker(_dateOfBirthController,  'Select Date Of Birth', DateTime.now().subtract(const Duration(days: 20 * 365))),
        const SizedBox(height: 16),
        _buildFormField2(_heightController, 'Height (m)', Icons.height, false, keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildFormField2(_weightController, 'Weight (kg)', Icons.scale, false, keyboardType: TextInputType.number),
        
      ],
    );
  }

  Widget _buildContractDetails() {
    return Column(
      children: [
        if (Responsive.isDesktop(context)) ...[
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 5.0,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildDatePicker(_contractStartController,  'Select Contract Start Date', DateTime.now().subtract(const Duration(days: 1 * 365))),
              _buildDatePicker(_contractEndController,  'Select Contract End Date', DateTime.now().add(const Duration(days: 1 * 365))),
              _buildFormField(_salaryController, 'Salary', Icons.attach_money, false, keyboardType: TextInputType.number),
              _buildContractStatusDropdown(),
            ],
          ),
        ] else ...[
          _buildDatePicker(_contractStartController,  'Select Contract Start Date', DateTime.now().subtract(const Duration(days: 1 * 365))),
          const SizedBox(height: 16),
          _buildDatePicker(_contractEndController,  'Select Contract End Date', DateTime.now().add(const Duration(days: 1 * 365))),
          const SizedBox(height: 16),
          _buildFormField(_salaryController, 'Salary', Icons.attach_money, false, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          _buildContractStatusDropdown(),
        ],
      ],
    );
  }

  Widget _buildPerformanceDetails() {
    return Column(
      children: [
        if (Responsive.isDesktop(context)) ...[
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 5.0,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildFormField(_matchesController, 'Matches', Icons.event, false, keyboardType: TextInputType.number),
              _buildFormField(_goalsController, 'Goals', Icons.sports_soccer, false, keyboardType: TextInputType.number),
              _buildFormField(_assistsController, 'Assists', Icons.accessibility, false, keyboardType: TextInputType.number),
              _buildFormField2(_ratingController, 'Rating', Icons.star, false, keyboardType: TextInputType.number),
            ],
          ),
        ] else ...[
          _buildFormField(_matchesController, 'Matches', Icons.event, false, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          _buildFormField(_goalsController, 'Goals', Icons.sports_soccer, false, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          _buildFormField(_assistsController, 'Assists', Icons.accessibility, false, keyboardType: TextInputType.number),
          const SizedBox(height: 16),
          _buildFormField2(_ratingController, 'Rating', Icons.star, false, keyboardType: TextInputType.number),
        ],
      ],
    );
  }

    Widget _buildFormField(TextEditingController controller, String label, IconData icon, bool isRequired,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: '$label${isRequired ? ' *' : ''}',
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
      keyboardType: keyboardType,
      validator: 
        isRequired ? (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if ((label == 'Age' || label == 'Height' || label == 'Weight' || label == 'Matches' || label == 'Goals' || label == 'Assists' || label == 'Rating') && int.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        }
        : (value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          if ((label == 'Age' || label == 'Height' || label == 'Weight' || label == 'Matches' || label == 'Goals' || label == 'Assists' || label == 'Rating') && int.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
    );
  }

  Widget _buildFormField2(
    TextEditingController controller, 
    String label, 
    IconData icon, 
    bool isRequired,
    {TextInputType keyboardType = TextInputType.text}
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: '$label${isRequired ? ' *' : ''}',
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
      keyboardType: keyboardType,
      validator: 
        isRequired ? (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if ((label == 'Height' || label == 'Weight' || label == 'Rating') && int.tryParse(value) == null) {
            final doubleValue = double.tryParse(value);
            if (doubleValue == null) {
              return 'Please enter a valid number';
            }
          }
          return null;
        }
        : (value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          if ((label == 'Height' || label == 'Weight' || label == 'Rating') && int.tryParse(value) == null) {
            final doubleValue = double.tryParse(value);
            if (doubleValue == null) {
              return 'Please enter a valid number 2';
            }
          }
          return null;
        },
    );
  }

  Widget _buildContractStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: _contractStatus,
      decoration: InputDecoration(
        labelText: 'Contract Status *',
        prefixIcon: Icon(Icons.assignment_turned_in, color: AppColors.primary),
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
      items: const [
        DropdownMenuItem(
          value: 'Active',
          child: Text('Active'),
        ),
        DropdownMenuItem(
          value: 'Expired',
          child: Text('Expired'),
        ),
        DropdownMenuItem(
          value: 'Negotiating',
          child: Text('Negotiating'),
        ),
        DropdownMenuItem(
          value: 'Terminated',
          child: Text('Terminated'),
        ),
        DropdownMenuItem(
          value: 'On Loan',
          child: Text('On Loan'),
        ),
        DropdownMenuItem(
          value: 'Free Agent',
          child: Text('Free Agent'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _contractStatus = value!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select contract status';
        }
        return null;
      },
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

  Widget _buildFormTips() {
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
                Icon(Icons.lightbulb, color: Colors.amber[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  'Form Tips',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTipItem('Ensure all required fields (*) are filled'),
            _buildTipItem('Use official player names'),
            _buildTipItem('Verify contract dates accuracy'),
            _buildTipItem('Upload a clear profile photo'),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String text) {
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
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveFootballer() async {
    // if (_footballerImage == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Please select footballer picture')),
    //   );
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Scrollable.ensureVisible(
    //       _imagePickerKey.currentContext!,
    //       duration: const Duration(milliseconds: 500),
    //       curve: Curves.easeInOut,
    //     );
    //   });
    //   return;
    // }

    final Map<String, dynamic> requestBody = {
      'user_id': userId,
      'id': widget.footballer.id,
      'full_name': _fullNameController.text.trim(),
      'position': _positionController.text.trim(),
      'club': _clubController.text.trim(),
      'nationality': _nationalityController.text.trim(),
      'age': int.parse(_ageController.text.trim()),
      'date_of_birth': _dateOfBirthController.text.trim(),
      'height': double.parse(_heightController.text.trim()),
      'weight': double.parse(_weightController.text.trim()),
      'salary': _salaryController.text.trim(),
      'contract_start': _contractStartController.text.trim(),
      'contract_end': _contractEndController.text.trim(),
      'contract_status': _contractStatus,
      'matches': double.parse(_matchesController.text.trim()),
      'goals': double.parse(_goalsController.text.trim()),
      'assists': double.parse(_assistsController.text.trim()),
      'rating': double.parse(_ratingController.text.trim()),
      if (fileType != null) 'file_type': fileType,
      if (_footballerImage != null) 'footballer_image': kIsWeb ? _webImageBytes : base64Encode(await File(_footballerImage!.path).readAsBytes()), 
    };

    try {
      setState(() => _isLoading = true);

      final Uri uri = Uri.parse('${backend_url}api/update_footballer');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        if (response.body == "Footballer updated successfully!") {
          // widget.refreshMethod();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Footballer ${_isEditing ? 'updated' : 'added'} successfully'),
              backgroundColor: Colors.green[600],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );

          context.go('/footballers');

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.body)),
          );
        }
      } else if (response.statusCode == 302) {
        _handleHTTPRedirect();
      } else {
        if(response.statusCode == 413){
          _showSnackBar('Request failed: Image is Too Large');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Footballer' : 'Add New Footballer',
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
            controller: _scrollController,
            child: Padding(
              // Add top padding equal to navbar height so content doesn't hide under it
              padding: EdgeInsets.only(top: Responsive.isDesktop(context) ? 80 : 0),
              child: Responsive.isDesktop(context)
                  ? _buildDesktopLayout()
                  : _buildMobileLayout(),
            ),
          ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _positionController.dispose();
    _clubController.dispose();
    _nationalityController.dispose();
    _ageController.dispose();
    _dateOfBirthController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _salaryController.dispose();
    _contractStartController.dispose();
    _contractEndController.dispose();
    _scrollController.dispose();
    _matchesController.dispose();
    _goalsController.dispose();
    _assistsController.dispose();
    _ratingController.dispose();

    super.dispose();
  }
}
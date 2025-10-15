import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class FootballerFormScreen extends StatefulWidget {
  const FootballerFormScreen({super.key});

  @override
  State<FootballerFormScreen> createState() => _FootballerFormScreenState();
}

class _FootballerFormScreenState extends State<FootballerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _clubController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();
  final _contractStartController = TextEditingController();
  final _contractEndController = TextEditingController();
  String _contractStatus = 'Active';
  bool _isEditing = false;

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
                                backgroundImage: const AssetImage(
                                    'assets/images/profile_placeholder.png'),
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
                      const SizedBox(height: 30),

                      // Personal Information Section
                      _buildSectionHeader('Personal Informationz', Icons.person),
                      const SizedBox(height: 20),
                      _buildDesktopFormGrid(),

                      const SizedBox(height: 30),

                      // Contract Information Section
                      _buildSectionHeader('Contract Details', Icons.assignment),
                      const SizedBox(height: 20),
                      _buildContractDetails(),

                      const SizedBox(height: 40),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: const AssetImage(
                              'assets/images/profile_placeholder.png'),
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
                          Navigator.pop(context);
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
      childAspectRatio: 2.5,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: [
        _buildFormField(_nameController, 'Full Name', Icons.person, true),
        _buildFormField(_positionController, 'Position', Icons.sports_soccer, true),
        _buildFormField(_clubController, 'Club', Icons.emoji_events, true),
        _buildFormField(_nationalityController, 'Nationality', Icons.flag, true),
        _buildFormField(_ageController, 'Age', Icons.cake, true,
            keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildMobileFormFields() {
    return Column(
      children: [
        _buildFormField(_nameController, 'Full Name', Icons.person, true),
        const SizedBox(height: 16),
        _buildFormField(_positionController, 'Position', Icons.sports_soccer, true),
        const SizedBox(height: 16),
        _buildFormField(_clubController, 'Club', Icons.emoji_events, true),
        const SizedBox(height: 16),
        _buildFormField(_nationalityController, 'Nationality', Icons.flag, true),
        const SizedBox(height: 16),
        _buildFormField(_ageController, 'Age', Icons.cake, true,
            keyboardType: TextInputType.number),
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
            childAspectRatio: 2.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              _buildFormField(_contractStartController, 'Contract Start', Icons.calendar_today, false),
              _buildFormField(_contractEndController, 'Contract End', Icons.calendar_today, false),
              _buildFormField(_salaryController, 'Salary', Icons.attach_money, false),
              _buildContractStatusDropdown(),
            ],
          ),
        ] else ...[
          _buildFormField(_contractStartController, 'Contract Start', Icons.calendar_today, false),
          const SizedBox(height: 16),
          _buildFormField(_contractEndController, 'Contract End', Icons.calendar_today, false),
          const SizedBox(height: 16),
          _buildFormField(_salaryController, 'Salary', Icons.attach_money, false),
          const SizedBox(height: 16),
          _buildContractStatusDropdown(),
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
      validator: isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              if (label == 'Age' && int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            }
          : null,
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

  void _saveFootballer() {

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
    Navigator.pop(context);
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
      body: Responsive.isDesktop(context) 
          ? _buildDesktopLayout()
          : _buildMobileLayout(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _clubController.dispose();
    _nationalityController.dispose();
    _ageController.dispose();
    _salaryController.dispose();
    _contractStartController.dispose();
    _contractEndController.dispose();
    super.dispose();
  }
}
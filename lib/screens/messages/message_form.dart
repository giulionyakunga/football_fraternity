import 'package:flutter/material.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';

class MessageFormScreen extends StatefulWidget {
  final String? recipientId;

  const MessageFormScreen({super.key, this.recipientId});

  @override
  State<MessageFormScreen> createState() => _MessageFormScreenState();
}

class _MessageFormScreenState extends State<MessageFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedRecipientType = 'Client';
  bool _isSending = false;
  List<String> _attachments = [];

  @override
  void initState() {
    super.initState();
    if (widget.recipientId != null) {
      _recipientController.text = widget.recipientId!;
    }
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - Compose Guidelines and Quick Actions
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
                        // Message Icon
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
                            Icons.email,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Compose Message',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Send professional messages to clients and team members',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        _buildMessageGuidelines(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildQuickContacts(),
              ],
            ),
          ),

          const SizedBox(width: 40),

          // Right Column - Message Form
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
                        'New Message',
                        style: AppStyles.heading1.copyWith(
                          fontSize: 28,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Compose and send a professional message',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Recipient Section
                      _buildSectionHeader('Recipient', Icons.person),
                      const SizedBox(height: 20),
                      _buildDesktopRecipientSection(),

                      const SizedBox(height: 30),

                      // Message Details Section
                      _buildSectionHeader('Message Details', Icons.subject),
                      const SizedBox(height: 20),
                      _buildDesktopMessageGrid(),

                      const SizedBox(height: 30),

                      // Message Content Section
                      _buildSectionHeader('Message Content', Icons.message),
                      const SizedBox(height: 20),
                      _buildMessageContentField(),

                      const SizedBox(height: 30),

                      // Attachments Section
                      _buildSectionHeader('Attachments', Icons.attach_file),
                      const SizedBox(height: 20),
                      _buildAttachmentsSection(),

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
                              onPressed: _isSending ? null : _sendMessage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 2,
                              ),
                              child: _isSending
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      'Send Message',
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
                      Icons.email,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'New Message',
                    style: AppStyles.heading1.copyWith(
                      fontSize: Responsive.isTablet(context) ? 24 : 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Compose and send a message',
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
                    _buildSectionHeader('Recipient', Icons.person),
                    const SizedBox(height: 16),
                    _buildMobileRecipientSection(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Message Details', Icons.subject),
                    const SizedBox(height: 16),
                    _buildMobileMessageFields(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Message Content', Icons.message),
                    const SizedBox(height: 16),
                    _buildMessageContentField(),
                    const SizedBox(height: 24),
                    _buildSectionHeader('Attachments', Icons.attach_file),
                    const SizedBox(height: 16),
                    _buildAttachmentsSection(),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSending ? null : _sendMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isSending
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Send Message',
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
          const SizedBox(height: 20),
          _buildMessageGuidelines(),
        ],
      ),
    );
  }

  Widget _buildDesktopRecipientSection() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: [
        _buildRecipientTypeDropdown(),
        _buildFormField(
          _recipientController,
          'Recipient *',
          'Select or enter recipient',
          Icons.person,
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter recipient';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildMobileRecipientSection() {
    return Column(
      children: [
        _buildRecipientTypeDropdown(),
        const SizedBox(height: 16),
        _buildFormField(
          _recipientController,
          'Recipient *',
          'Select or enter recipient',
          Icons.person,
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter recipient';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDesktopMessageGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 2.5,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: [
        _buildFormField(
          _subjectController,
          'Subject *',
          'Enter message subject',
          Icons.subject,
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a subject';
            }
            return null;
          },
        ),
        _buildPriorityDropdown(),
      ],
    );
  }

  Widget _buildMobileMessageFields() {
    return Column(
      children: [
        _buildFormField(
          _subjectController,
          'Subject *',
          'Enter message subject',
          Icons.subject,
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a subject';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildPriorityDropdown(),
      ],
    );
  }

  Widget _buildFormField(
    TextEditingController controller,
    String label,
    String hint,
    IconData icon,
    String? Function(String?) validator,
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
      validator: validator,
    );
  }

  Widget _buildRecipientTypeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Recipient Type *',
        prefixIcon: Icon(Icons.group, color: AppColors.primary),
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
      value: _selectedRecipientType,
      items: const [
        DropdownMenuItem(
          value: 'Client',
          child: Text('Client'),
        ),
        DropdownMenuItem(
          value: 'Legal Officer',
          child: Text('Legal Officer'),
        ),
        DropdownMenuItem(
          value: 'Management',
          child: Text('Management Team'),
        ),
        DropdownMenuItem(
          value: 'All',
          child: Text('All Contacts'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedRecipientType = value!;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select recipient type';
        }
        return null;
      },
    );
  }

  Widget _buildPriorityDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Priority',
        prefixIcon: Icon(Icons.flag, color: AppColors.primary),
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
      value: 'Normal',
      items: const [
        DropdownMenuItem(
          value: 'Low',
          child: Text('Low Priority'),
        ),
        DropdownMenuItem(
          value: 'Normal',
          child: Text('Normal Priority'),
        ),
        DropdownMenuItem(
          value: 'High',
          child: Text('High Priority'),
        ),
        DropdownMenuItem(
          value: 'Urgent',
          child: Text('Urgent'),
        ),
      ],
      onChanged: (value) {
        // Handle priority change
      },
    );
  }

  Widget _buildMessageContentField() {
    return TextFormField(
      controller: _messageController,
      decoration: InputDecoration(
        labelText: 'Message Content *',
        hintText: 'Type your message here...',
        alignLabelWithHint: true,
        prefixIcon: Icon(Icons.message, color: AppColors.primary),
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
      maxLines: 6,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your message';
        }
        if (value.length < 10) {
          return 'Message should be at least 10 characters long';
        }
        return null;
      },
    );
  }

  Widget _buildAttachmentsSection() {
    return Column(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey[300]!),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  Icons.attach_file,
                  size: 48,
                  color: _attachments.isNotEmpty ? AppColors.primary : Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  _attachments.isNotEmpty 
                      ? '${_attachments.length} file(s) attached' 
                      : 'No attachments',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _attachments.isNotEmpty ? Colors.black87 : Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Maximum file size: 25MB',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _addAttachment,
                      icon: const Icon(Icons.attach_file, size: 18),
                      label: const Text('Add Files'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.grey[400]!),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _addAttachment,
                      icon: const Icon(Icons.image, size: 18),
                      label: const Text('Add Images'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        if (_attachments.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildAttachmentsList(),
        ],
      ],
    );
  }

  Widget _buildAttachmentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attached Files:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        ..._attachments.map((file) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.insert_drive_file, color: AppColors.primary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  file,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                onPressed: () => _removeAttachment(file),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildMessageGuidelines() {
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
                  'Message Guidelines',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildGuidelineItem('Be clear and professional in your communication'),
            _buildGuidelineItem('Include all necessary context and details'),
            _buildGuidelineItem('Use proper formatting for readability'),
            _buildGuidelineItem('Double-check recipient and attachments'),
            _buildGuidelineItem('Keep messages concise but complete'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickContacts() {
    final quickContacts = [
      {'name': 'Kibu Denis', 'type': 'Client'},
      {'name': 'Sarah Johnson', 'type': 'Legal Officer'},
      {'name': 'Management Team', 'type': 'Group'},
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
            Text(
              'Quick Contacts',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: quickContacts
                  .map((contact) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            contact['type'] == 'Client' 
                                ? Icons.person 
                                : contact['type'] == 'Legal Officer' 
                                    ? Icons.badge 
                                    : Icons.group,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        title: Text(
                          contact['name']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          contact['type']!,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        onTap: () {
                          setState(() {
                            _recipientController.text = contact['name']!;
                          });
                        },
                      ))
                  .toList(),
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

  void _addAttachment() {
    // Simulate file selection
    setState(() {
      _attachments.add('contract_document_${_attachments.length + 1}.pdf');
    });
  }

  void _removeAttachment(String file) {
    setState(() {
      _attachments.remove(file);
    });
  }

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      // Simulate sending process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isSending = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Message sent successfully!'),
            backgroundColor: Colors.green[600],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Message',
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
    _recipientController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
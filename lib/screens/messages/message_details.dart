import 'package:flutter/material.dart';
import 'package:football_fraternity/models/message.dart';
import 'package:football_fraternity/services/storage_service.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageDetailsScreen extends StatefulWidget {
  final Message message;
  const MessageDetailsScreen({super.key, required this.message});

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState(); 
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  late Message message;
  int userId = 0;
  late final StorageService _storageService;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    message = widget.message;
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
  
  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column - Message Info and Quick Actions
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
                          // Message Header
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  message.type == 'outgoing' 
                                      ? Icons.outgoing_mail 
                                      : Icons.inbox,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Message #${message.id}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        message.type == 'outgoing' ? 'Outgoing' : 'Incoming',
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
                          ),
                          const SizedBox(height: 20),
                          
                          // Status and Quick Info
                          _buildMessageStatus(),
                          const SizedBox(height: 25),
                          
                          // Quick Actions
                          _buildQuickActions(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Conversation Thread
                  // _buildConversationThread(),
                ],
              ),
            ),

            const SizedBox(width: 40),

            // Right Column - Message Content and Details
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Message Header
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.type == 'outgoing'
                                          ? 'To: Admin'
                                          : 'From: ${message.clientName}',
                                      style: AppStyles.heading1.copyWith(
                                        fontSize: 24,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Phone Number: ${message.phoneNumber}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Email: ${message.email}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _formatDateTime(message.createdAt),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _buildMessageTypeBadge(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Message Content
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
                          _buildSectionHeader(context, 'Message Content', Icons.message),
                          const SizedBox(height: 20),
                          _buildMessageContent(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Message Details
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
                          _buildSectionHeader(context, 'Message Details', Icons.info),
                          const SizedBox(height: 20),
                          _buildDesktopDetailsGrid(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          // Message Header
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
                  Row(
                    children: [
                      Icon(
                        message.type == 'outgoing' 
                            ? Icons.outgoing_mail 
                            : Icons.inbox,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.type == 'outgoing'
                                  ? 'To: Admin'
                                  : 'From: ${message.clientName}',
                              style: AppStyles.heading1.copyWith(
                                fontSize: Responsive.isTablet(context) ? 22 : 20,
                              ),
                            ),
                            Text(
                              'Phone: ${message.phoneNumber}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'Email: ${message.email}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              _formatDateTime(message.createdAt),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildMessageTypeBadge(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildMessageStatus(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Conversation Thread
          // _buildConversationThread(),
          // const SizedBox(height: 20),

          // Message Content
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
                  _buildSectionHeader(context, 'Message', Icons.message),
                  const SizedBox(height: 16),
                  _buildMessageContent(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Message Details
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
                  _buildSectionHeader(context, 'Details', Icons.info),
                  const SizedBox(height: 16),
                  _buildMobileDetailsList(),
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

  Widget _buildMessageStatus() {
    return Column(
      children: [
        // Read Status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: message.isRead ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: message.isRead ? Colors.green.withOpacity(0.3) : Colors.orange.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                message.isRead ? Icons.mark_email_read : Icons.mark_email_unread,
                size: 16,
                color: message.isRead ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                message.isRead ? 'Read' : 'Unread',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: message.isRead ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Delivery Status (for outgoing messages)
        if (message.type == 'outgoing')
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 14, color: Colors.blue),
                const SizedBox(width: 6),
                Text(
                  'Delivered',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildMessageTypeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: message.type == 'outgoing' 
            ? Colors.green.withOpacity(0.1) 
            : Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: message.type == 'outgoing' 
              ? Colors.green.withOpacity(0.3) 
              : Colors.blue.withOpacity(0.3),
        ),
      ),
      child: Text(
        message.type == 'outgoing' ? 'Outgoing' : 'Incoming',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: message.type == 'outgoing' ? Colors.green : Colors.blue,
        ),
      ),
    );
  }

  Widget _buildMessageContent() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Text(
        message.text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          height: 1.6,
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
        _buildDetailItem('Message ID', '${message.id}', Icons.numbers),
        _buildDetailItem('Sender', message.clientName, Icons.person),
        _buildDetailItem('Receiver', 'Admin', Icons.person_outline),
        _buildDetailItem('Sent Date', _formatDate(message.createdAt), Icons.calendar_today),
        _buildDetailItem('Sent Time', _formatTime(message.createdAt), Icons.access_time),
        _buildDetailItem('Message Type', message.type == 'outgoing' ? 'Outgoing' : 'Incoming', Icons.send),
      ],
    );
  }

  Widget _buildMobileDetailsList() {
    return Column(
      children: [
        _buildDetailItem('Message ID', '${message.id}', Icons.numbers),
        const SizedBox(height: 12),
        _buildDetailItem('Sender', message.clientName, Icons.person),
        const SizedBox(height: 12),
        _buildDetailItem('Receiver', 'Admin', Icons.person_outline),
        const SizedBox(height: 12),
        _buildDetailItem('Sent Date', _formatDate(message.createdAt), Icons.calendar_today),
        const SizedBox(height: 12),
        _buildDetailItem('Sent Time', _formatTime(message.createdAt), Icons.access_time),
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

  Widget _buildConversationThread() {
    // Mock conversation history
    final conversationHistory = [
      {'content': 'Hello, I would like to discuss my contract renewal.', 'time': '2 days ago', 'type': 'incoming'},
      {'content': 'Thank you for reaching out. I\'d be happy to help with your contract renewal.', 'time': '1 day ago', 'type': 'outgoing'},
      {'content': 'When would be a good time to schedule a meeting?', 'time': '1 day ago', 'type': 'incoming'},
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
                Icon(Icons.history, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Conversation History',
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
              children: conversationHistory
                  .map((msg) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: msg['type'] == 'outgoing' 
                                        ? Colors.green.withOpacity(0.1) 
                                        : Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    msg['type'] == 'outgoing' ? 'You' : 'Them',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: msg['type'] == 'outgoing' ? Colors.green : Colors.blue,
                                    ),
                                  ),
                                ),
                                Text(
                                  msg['time']!,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              msg['content']!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
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

  Widget _buildQuickActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // Mark as read/unread
            },
            icon: Icon(
              message.isRead ? Icons.mark_email_unread : Icons.mark_email_read,
              size: 18,
            ),
            label: Text(message.isRead ? 'Mark Unread' : 'Mark Read'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // Archive message
            },
            icon: const Icon(Icons.archive, size: 18),
            label: const Text('Archive'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey[700],
              side: BorderSide(color: Colors.grey[400]!),
              padding: const EdgeInsets.symmetric(vertical: 12),
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
                    // Navigator.pushNamed(
                    //   context,
                    //   '/messages/form',
                    //   arguments: {'recipientId': message.senderId},
                    // );
                  },
                  icon: const Icon(Icons.reply, size: 20),
                  label: const Text('Reply to Message'),
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
                    // Forward message
                  },
                  icon: const Icon(Icons.forward, size: 20),
                  label: const Text('Forward'),
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
            ],
          )
        : Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigator.pushNamed(
                    //   context,
                    //   '/messages/form',
                    //   arguments: {'recipientId': message.senderId},
                    // );
                  },
                  icon: const Icon(Icons.reply, size: 18),
                  label: const Text('Reply to Message'),
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
                        // Forward message
                      },
                      icon: const Icon(Icons.forward, size: 18),
                      label: const Text('Forward'),
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
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Archive message
                      },
                      icon: const Icon(Icons.archive, size: 18),
                      label: const Text('Archive'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        side: BorderSide(color: Colors.grey[400]!),
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

  String _formatDateTime(DateTime date) {
    return '${_formatDate(date)} at ${_formatTime(date)}';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Message Details',
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
              // Share message
            },
            tooltip: 'Share Message',
          ),
          IconButton(
            icon: const Icon(Icons.print, size: 22),
            onPressed: () {
              // Print message
            },
            tooltip: 'Print Message',
          ),
        ],
      ),
      body: Responsive.isDesktop(context) 
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }
}
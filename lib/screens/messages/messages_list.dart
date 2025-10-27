import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:football_fraternity/env.dart';
import 'package:football_fraternity/models/message.dart';
import 'package:football_fraternity/services/storage_service.dart';
import 'package:football_fraternity/widgets/drawer.dart';
import 'package:football_fraternity/widgets/message_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  final ScrollController _scrollController = ScrollController();
  int userId = 0;
  late final StorageService _storageService;
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages();
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

  Future<void> _fetchMessages() async {
    try {
      final Uri uri = Uri.parse('${backend_url}api/messages/');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final newItems = jsonList.map((json) => Message.fromJson(json)).toList();
        setState(() {
          messages = newItems;
        });
      }
    }  on SocketException catch (e) {
      debugPrint('Network error occurred:');
      debugPrint('- Exception type: ${e.runtimeType}');
      debugPrint('- Message: ${e.message}');
      
      if (e.osError != null) {
        debugPrint('  - Error number (errno): ${e.osError!.errorCode}');
        debugPrint('  - OS message: ${e.osError!.message}');
      }
    }
  }

  Widget _buildDesktopLayout() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column - Conversations List (unchanged)
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
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Conversations',
                                  style: AppStyles.heading2.copyWith(fontSize: 20),
                                ),
                                _buildUnreadBadge(),
                              ],
                            ),
                            const SizedBox(height: 20),
                            
                            // // Search and Filters
                            // _buildSearchSection(),
                            // const SizedBox(height: 20),
                            
                            // Conversation Filters
                            _buildConversationFilters(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Quick Actions
                    _buildQuickActions(),
                  ],
                ),
              ),


            const SizedBox(width: 24),

            // Right Column - Messages List (FIXED)
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Messages',
                                style: AppStyles.heading1.copyWith(
                                  fontSize: 28,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Communicate with clients and team members',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          _buildStatsOverview(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 500, // Set a fixed height or use MediaQuery
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              child: MessageCard(message: messages[index]),
                            );
                          },
                        ),
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
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isTablet(context) ? 30 : 20,
        vertical: 20,
      ),
      children: [
        // Header Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Messages',
                  style: AppStyles.heading1.copyWith(
                    fontSize: Responsive.isTablet(context) ? 28 : 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Communicate with clients',
                  style: TextStyle(
                    fontSize: Responsive.isTablet(context) ? 16 : 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            _buildUnreadBadge(),
          ],
        ),
        const SizedBox(height: 20),

        // Mobile Stats
        _buildMobileStats(),
        const SizedBox(height: 20),

        // Conversation Filters
        _buildConversationFilters(),
        const SizedBox(height: 20),

        // Messages List as part of the main ListView
        ...messages.map((message) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MessageCard(message: message),
        )).toList(),
      ],
    );
  }

  Widget _buildStatsOverview() {
    final unreadCount = messages.where((m) => !m.isRead).length;
    final incomingCount = messages.where((m) => m.type == 'incoming').length;
    final outgoingCount = messages.where((m) => m.type == 'outgoing').length;

    return Row(
      children: [
        _buildStatItem(messages.length.toString(), 'Total', Icons.message),
        const SizedBox(width: 16),
        _buildStatItem(unreadCount.toString(), 'Unread', Icons.mark_email_unread, Colors.orange),
        const SizedBox(width: 16),
        _buildStatItem(incomingCount.toString(), 'Incoming', Icons.download, Colors.blue),
      ],
    );
  }

  Widget _buildMobileStats() {
    final unreadCount = messages.where((m) => !m.isRead).length;
    final incomingCount = messages.where((m) => m.type == 'incoming').length;

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
            _buildStatItem(messages.length.toString(), 'Total', Icons.message),
            _buildStatItem(unreadCount.toString(), 'Unread', Icons.mark_email_unread, Colors.orange),
            _buildStatItem(incomingCount.toString(), 'Incoming', Icons.download, Colors.blue),
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
            fontSize: 16,
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

  Widget _buildUnreadBadge() {
    final unreadCount = messages.where((m) => !m.isRead).length;
    
    return Badge(
      backgroundColor: Colors.red,
      label: Text(unreadCount.toString()),
      isLabelVisible: unreadCount > 0,
      child: Icon(
        Icons.notifications,
        color: Colors.grey[600],
        size: 24,
      ),
    );
  }

  Widget _buildSearchSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Search Field
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search messages...',
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
            const SizedBox(width: 12),

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
                      Text('All Messages'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'unread',
                  child: Row(
                    children: [
                      Icon(Icons.mark_email_unread, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Text('Unread Only'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'incoming',
                  child: Row(
                    children: [
                      Icon(Icons.download, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Text('Incoming Only'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'outgoing',
                  child: Row(
                    children: [
                      Icon(Icons.upload, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text('Outgoing Only'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversationFilters() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildFilterChip('All', true),
        _buildFilterChip('Unread', false),
        _buildFilterChip('Clients', false),
        _buildFilterChip('Team', false),
        _buildFilterChip('Urgent', false),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (bool value) {
        // Handle filter selection
      },
      backgroundColor: Colors.grey[100],
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: selected ? AppColors.primary : Colors.grey[700],
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildQuickActions() {
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
              'Quick Actions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                _buildQuickActionItem(
                  Icons.mark_email_read,
                  'Mark All Read',
                  () {
                    // Mark all as read
                  },
                ),
                _buildQuickActionItem(
                  Icons.archive,
                  'Archive Old',
                  () {
                    // Archive old messages
                  },
                ),
                _buildQuickActionItem(
                  Icons.delete,
                  'Clear Deleted',
                  () {
                    // Clear deleted messages
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: AppColors.primary),
      ),
      title: Text(
        label,
        style: const TextStyle(fontSize: 14),
      ),
      onTap: onTap,
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Navigator.pushNamed(context, '/messages/form');
      },
      backgroundColor: AppColors.primary,
      elevation: 4,
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
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
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigator.pushNamed(context, '/messages/form');
              },
              tooltip: 'New Message',
            ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Responsive.isDesktop(context) 
          ? _buildDesktopLayout()
          : _buildMobileLayout(context),
      floatingActionButton: Responsive.isDesktop(context) ? null : _buildFloatingActionButton(),
    );
  }
}
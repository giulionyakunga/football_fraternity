import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:football_fraternity/env.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';
import 'package:football_fraternity/utils/responsive.dart';
import 'package:football_fraternity/widgets/drawer.dart';
import 'package:football_fraternity/widgets/header.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';


class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  int userId = 0;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  
  Future<void> _sendMessage() async { 

    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      'name': _nameController.text.trim(),
      'phone_number': _phoneNumberController.text.trim(),
      'email': _emailController.text.trim(),
      'message': _messageController.text.trim(),
    };

    try {
      setState(() => _isLoading = true);

      final Uri uri = Uri.parse('${backend_url}api/send_message');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        if (response.body == "Message sent successfully!") {
          setState(() {
            _submitted = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Your message has been sent successfully! We will get back to you within 24 hours.'),
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


  Widget _buildDesktopNavBar(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 80 : 40,
        vertical: 15,
      ),
      child: Row(
        children: [
          const Spacer(),
          _buildNavLink(context, 'Home', '/'),
          _buildNavLink(context, 'About Us', '/about-us'),
          _buildNavLink(context, 'Services', '/services'),
          _buildNavLink(context, 'Contacts', '/contacts'),
          if(userId != 0)
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String text, String route) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isDesktop(context) ? 20 : 15,
      ),
      child: TextButton(
        onPressed: () => context.go(route),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.isDesktop(context) ? 18 : 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
      child: Column(
        children: [
          // Header Section
          Center(
            child: Column(
              children: [
                Text(
                  'Get In Touch',
                  style: AppStyles.heading1.copyWith(
                    fontSize: 42,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 600,
                  child: Text(
                    'We\'re here to help you with all your football legal and management needs. '
                    'Reach out to us through any of the following channels.',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),

          // Contact Info and Form Side by Side
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Information
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information',
                      style: AppStyles.heading2.copyWith(fontSize: 28),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Feel free to reach out to us through any of the following methods. '
                      'We typically respond within 24 hours.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildContactCard(),
                  ],
                ),
              ),

              const SizedBox(width: 60),

              // Contact Form
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send Us a Message',
                      style: AppStyles.heading2.copyWith(fontSize: 28),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Have questions or need assistance? Send us a message and our team will get back to you promptly.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildContactForm(context),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),

          // Map Section
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Our Location',
                        style: AppStyles.heading2.copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            size: 60,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Interactive Map',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),

                          const SizedBox(height: 8),

                          ElevatedButton.icon(
                            icon: const Icon(Icons.map),
                            label: const Text("Open in Maps"),
                            onPressed: () async {
                              context.go('https://www.google.com/maps/search/?api=1&query=-6.778273,39.237430');

                              // final url = Uri.parse(Uri.encodeFull("https://www.google.com/maps/search/?api=1&query=-6.778273,39.237430"));
                              // if (await canLaunchUrl(url)) {
                              //   await launchUrl(url);
                              // }
                            },
                          ),

                          const SizedBox(height: 8),

                          ElevatedButton.icon(
                            icon: const Icon(Icons.share),
                            label: const Text("Share Location"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              const message = "Football Fraternity Head Office Location:\nWard: Kijitonyama, District: Kinondoni, Region: Dar es Salaam \nOpen in Maps (Link 1): https://maps.app.goo.gl/2VqqQ7387Xu5sXzHA \nOpen in Maps (Link 2): https://www.google.com/maps/search/?api=1&query=-6.778273,39.237430";
                              Share.share(message);

                              const clipboardData = "Football Fraternity Head Office Location:\nWard: Kijitonyama, \nDistrict: Kinondoni, \nRegion: Dar es Salaam \nOpen in Maps (Link 1): https://maps.app.goo.gl/2VqqQ7387Xu5sXzHA \nOpen in Maps (Link 2): https://www.google.com/maps/search/?api=1&query=-6.778273,39.237430";
                              await Clipboard.setData(const ClipboardData(text: clipboardData));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Link copied to clipboard!')),
                              );
                            },
                          ),

                          const SizedBox(height: 8),
                          Text( 
                            'Sikumwisho Street, Kijitonyama, Dar es Salaam, Tanzania',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isTablet(context) ? 40 : 20,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Center(
            child: Column(
              children: [
                Text(
                  'Get In Touch',
                  style: AppStyles.heading1.copyWith(
                    fontSize: Responsive.isTablet(context) ? 32 : 28,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'We\'re here to help you with all your football legal and management needs.',
                  style: TextStyle(
                    fontSize: Responsive.isTablet(context) ? 16 : 15,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Contact Information
          Text(
            'Contact Information',
            style: AppStyles.heading2.copyWith(
              fontSize: Responsive.isTablet(context) ? 24 : 22,
            ),
          ),
          const SizedBox(height: 20),
          _buildContactCard(),
          const SizedBox(height: 40),

          // Contact Form
          Text(
            'Send Us a Message',
            style: AppStyles.heading2.copyWith(
              fontSize: Responsive.isTablet(context) ? 24 : 22,
            ),
          ),
          const SizedBox(height: 20),
          _buildContactForm(context),
          const SizedBox(height: 40),

          // Map Section
          Card(
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
                      const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Our Location',
                        style: AppStyles.heading2.copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            size: 40,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Interactive Map',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),

                          ElevatedButton.icon(
                            icon: const Icon(Icons.map),
                            label: const Text("Open in Maps"),
                            onPressed: () async {
                              context.go('https://www.google.com/maps/search/?api=1&query=-6.778273,39.237430');

                              // final url = Uri.parse(Uri.encodeFull("https://www.google.com/maps/search/?api=1&query=-6.778273,39.237430"));
                              // if (await canLaunchUrl(url)) {
                              //   await launchUrl(url);
                              // }
                            },
                          ),

                          const SizedBox(height: 4),

                          ElevatedButton.icon(
                            icon: const Icon(Icons.share),
                            label: const Text("Share Location"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              const message = "Football Fraternity Head Office Location:\nWard: Kijitonyama, District: Kinondoni, Region: Dar es Salaam \nOpen in Maps (Link 1): https://maps.app.goo.gl/2VqqQ7387Xu5sXzHA \nOpen in Maps (Link 2): https://www.google.com/maps/search/?api=1&query=-6.778273,39.237430";
                              Share.share(message);

                              const clipboardData = "Football Fraternity Head Office Location:\nWard: Kijitonyama, \nDistrict: Kinondoni, \nRegion: Dar es Salaam \nOpen in Maps (Link 1): https://maps.app.goo.gl/2VqqQ7387Xu5sXzHA \nOpen in Maps (Link 2): https://www.google.com/maps/search/?api=1&query=-6.778273,39.237430";
                              await Clipboard.setData(const ClipboardData(text: clipboardData));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Link copied to clipboard!')),
                              );
                            },
                          ),

                          const SizedBox(height: 4),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Sikumwisho Street, Kijitonyama, Dar es Salaam, Tanzania',
                              style: TextStyle(
                                fontSize: Responsive.isTablet(context) ? 14 : 12,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            _buildContactItem(
              Icons.location_on,
              'Head Office',
              'Sikumwisho Street, Kijitonyama, Dar es Salaam, Tanzania',
              Colors.blue[700]!,
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              Icons.phone,
              'Phone Numbers',
              '+255 769 770 772\n+255 672 120 941',
              Colors.green[700]!,
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              Icons.email,
              'Email Address',
              '1yazidalpha@gmail.com',
              Colors.orange[700]!,
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              Icons.access_time,
              'Working Hours',
              'Monday - Friday: 8:00 AM - 5:00 PM\nSaturday: 9:00 AM - 1:00 PM\nSunday: Closed',
              Colors.purple[700]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String content, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return 
    Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  _buildFormField(
                    'Your Name',
                    Icons.person,
                    _nameController
                  ),
                  const SizedBox(height: 20),
                  _buildFormField(
                    'Your Phone Number',
                    Icons.phone,
                    _phoneNumberController
                  ),
                  const SizedBox(height: 20),
                  _buildFormField(
                    'Your Email',
                    Icons.email,
                    _emailController
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Message',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(

                      onPressed: _submitted ? null : () {
                        if (_formKey.currentState!.validate()) {
                          // Send Message
                          _sendMessage();
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
                        _submitted ? 'Message Sent' : 'Send Message',
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
            ),
          )
        ]
      )
    );
  }

  Widget _buildFormField(String label, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Header(),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context)) _buildDesktopNavBar(context),
            Responsive.isDesktop(context)
                ? _buildDesktopLayout(context)
                : _buildMobileLayout(context),
          ],
        ),
      ),
    );
  }
}
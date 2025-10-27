import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:football_fraternity/env.dart';
import 'package:football_fraternity/models/user_profile.dart';
import 'package:football_fraternity/services/storage_service.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  late final StorageService _storageService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    final prefs = await SharedPreferences.getInstance();
    _storageService = StorageService(prefs);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 768;
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

  Future<void> _handleLogin({bool useDNS = true}) async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() => _isLoading = true);

        final Uri uri = Uri.parse('${backend_url}api/login');        
        final response = await http.post(
          uri,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "email": _emailController.text,
            "password": _passwordController.text
          }),
        );

        if (response.statusCode == 200) {
          if (response.body == "Login failed, Plz check your credentials!") {
            _showSnackBar(response.body);
          } else {
            final responseData = jsonDecode(response.body);
            if (responseData['token'] != "") {
              await _saveUserProfile(responseData);
              context.go('/home');
            } else {
              _showSnackBar(response.body);
            }
          }

          if(useDNS){
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('use_dns', true);
          }else {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('use_dns', false);
          }
        } else if (response.statusCode == 302) {
          _handleHTTPRedirect();
        } else {
          _showSnackBar('Request failed: ${response.statusCode}');
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
        debugPrint('An error occurred: $e');
        _showSnackBar('An error occurred: $e');
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveUserProfile(Map<String, dynamic> responseData) async {
    try {
      final profile = UserProfile(
        id: responseData['id'],
        firstName: responseData['first_name'],
        middleName: responseData['middle_name'],
        lastName: responseData['last_name'],
        email: responseData['email'],
        phoneNumber: responseData['phone_number'],
        role: responseData['role'],
        region: responseData['region'],
        district: responseData['district'],
        ward: responseData['ward'],
        street: responseData['street'],
        token: responseData['token'],
        imageUrl: responseData['email'],
      );
      await _storageService.saveUserProfile(profile);
    } catch (e) {
      if (mounted) _showSnackBar('Failed to update profile');
    }
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

  Widget _buildLoginForm(bool isLargeScreen) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: _buildInputDecoration(
              label: 'Email',
              icon: Icons.email,
              isLargeScreen: isLargeScreen,
            ),
            style: TextStyle(fontSize: isLargeScreen ? 18 : 16),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your email';
              if (!value.contains('@')) return 'Please enter a valid email';
              if (value.length > 100) return 'Email cannot exceed 100 characters';
              return null;
            },
          ),
          SizedBox(height: isLargeScreen ? 24 : 16),
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: _buildInputDecoration(
              label: 'Password',
              icon: Icons.lock,
              isLargeScreen: isLargeScreen,
              isPasswordField: true,
              onVisibilityPressed: () {
                setState(() => _isPasswordVisible = !_isPasswordVisible);
              },
            ),
            style: TextStyle(fontSize: isLargeScreen ? 18 : 16),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter a password';
              if (value.length < 6) return 'Password must be at least 6 characters';
              if (value.length > 100) return 'Password cannot exceed 100 characters';
              return null;
            },
          ),
          SizedBox(height: isLargeScreen ? 24 : 12),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 20 : 16),
              elevation: 4,
            ),
            child: _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: isLargeScreen ? 18 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
    bool isLargeScreen = false,
    bool isPasswordField = false,
    VoidCallback? onVisibilityPressed,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.grey[600],
        fontSize: isLargeScreen ? 18 : 16,
      ),
      prefixIcon: Icon(
        icon,
        color: Colors.grey[600],
        size: isLargeScreen ? 24 : 20,
      ),
      suffixIcon: isPasswordField
          ? IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                size: isLargeScreen ? 24 : 20,
              ),
              onPressed: onVisibilityPressed,
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey[400]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.blue[800]!, width: 2.0),
      ),
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding: EdgeInsets.symmetric(
        vertical: isLargeScreen ? 20 : 16,
        horizontal: isLargeScreen ? 20 : 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = _isLargeScreen(context);

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isLargeScreen ? 32 : 24,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isLargeScreen ? 600 : double.infinity,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 24),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [Colors.blue[200]!, Colors.blue[800]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 48 : 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: isLargeScreen ? 16 : 8),

                      SizedBox(height: isLargeScreen ? 16 : 8),

                      Text(
                        'Sign in to continue',
                        style: TextStyle(
                          fontSize: isLargeScreen ? 22 : 18,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isLargeScreen ? 36 : 20),
                      _buildLoginForm(isLargeScreen),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Positioned button (top-right corner)
          Positioned(
            top: 24.0, // Adjust as needed
            right: 16.0, // Adjust as needed
            child: ElevatedButton.icon(
              icon: const Icon(Icons.explore),
              label: Text(
                'Continue Home',
                style: TextStyle(
                  fontSize: isLargeScreen ? 16 : 14,
                  color: Colors.blue[800],
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[100],
                foregroundColor: Colors.blue[800],
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              onPressed: () {
                context.go('/home');
              },
            ),
          ),
        ],
      ),
    );
  }
}
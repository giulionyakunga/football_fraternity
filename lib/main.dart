import 'package:flutter/material.dart';
import 'package:football_fraternity/models/footballer.dart';
import 'package:football_fraternity/screens/about_us.dart';
import 'package:football_fraternity/screens/contacts.dart';
import 'package:football_fraternity/screens/footballers/footballer_details.dart';
import 'package:football_fraternity/screens/footballers/footballer_form.dart';
import 'package:football_fraternity/screens/footballers/footballer_form2.dart';
import 'package:football_fraternity/screens/footballers/footballers_list.dart';
import 'package:football_fraternity/screens/legal_services/consultancy_form.dart';
import 'package:football_fraternity/screens/legal_services/footballer_management_form.dart';
import 'package:football_fraternity/screens/legal_services/representation_form.dart';
import 'package:football_fraternity/screens/legal_services/services_list.dart';
import 'package:football_fraternity/screens/main_screen.dart';
import 'package:football_fraternity/screens/services.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define your GoRouter configuration
  final GoRouter _router = GoRouter(
    initialLocation: '/',  // Initial route when the app loads
    routes: [
      // Define your routes here
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/services',
        builder: (context, state) => const ServicesScreen(),
      ),
       GoRoute(
        path: '/about-us',
        builder: (context, state) => const AboutUsScreen(),
      ),
      GoRoute(
        path: '/contacts',
        builder: (context, state) => const ContactsScreen(),
      ),
      GoRoute(
        path: '/footballers',
        builder: (context, state) => const FootballersListScreen(),
      ),
      GoRoute(
        path: '/footballers/form',
        builder: (context, state) => const FootballerFormScreen(),
      ),
      GoRoute(
        path: '/footballers/form2',
        builder: (context, state) {
          final footballer = state.extra as Footballer;
          return FootballerForm2Screen(footballer: footballer);
        },
      ),
      GoRoute(
        path: '/footballer-detail',
        builder: (context, state) {
          final footballer = state.extra as Footballer;
          return FootballerDetailsScreen(footballer: footballer);
        },
      ),
      GoRoute(
        path: '/legal-services',
        builder: (context, state) => const LegalServicesListScreen(),
      ),
      GoRoute(
        path: '/legal-services/consultancy',
        builder: (context, state) => const ConsultancyFormScreen(),
      ),
      GoRoute(
        path: '/legal-services/representation',
        builder: (context, state) => const RepresentationFormScreen(),
      ),
      GoRoute(
        path: '/legal-services/footballer_management_form',
        builder: (context, state) => const FootballerManagementFormScreen(),
      ),
      
      // Add other routes similarly...
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,  // Use the router configuration here
    );
  }
}
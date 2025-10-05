import 'package:flutter/material.dart';
import 'package:football_fraternity/models/service.dart';
import 'package:football_fraternity/widgets/service_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class LegalServicesListScreen extends StatelessWidget {
  const LegalServicesListScreen({super.key});

  final List<Service> services = const [
    Service(
      id: '1',
      title: 'Legal Consultancy',
      description: 'Expert advice on football contracts, transfers, and disputes',
      icon: 'legal',
      features: [
        'Contract review and analysis',
        'Transfer advice',
        'Dispute resolution guidance',
        'Compliance with regulations',
      ],
    ),
    Service(
      id: '2',
      title: 'Legal Representation',
      description: 'Professional representation in negotiations and legal proceedings',
      icon: 'gavel',
      features: [
        'Contract negotiations',
        'Dispute resolution',
        'Tribunal representation',
        'Mediation services',
      ],
    ),
    Service(
      id: '3',
      title: 'Footballers Management',
      description: 'Comprehensive management services for professional footballers',
      icon: 'people',
      features: [
        'Contract management',
        'Career planning',
        'Financial advisory',
        'Image rights management',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Legal Services'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ServiceCard(service: services[index]);
        },
      ),
    );
  }
}
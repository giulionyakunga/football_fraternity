import 'package:flutter/material.dart';
import 'package:football_fraternity/models/case.dart';
import 'package:football_fraternity/widgets/case_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class CasesListScreen extends StatelessWidget {
  CasesListScreen({super.key});

  final List<LegalCase> cases = [
    LegalCase(
      id: '1',
      title: 'Contract Dispute',
      description: 'Dispute over image rights with City FC',
      status: 'In Progress',
      clientId: '1',
      legalOfficerId: '1',
      createdAt: DateTime(2023, 5, 10),
    ),
    LegalCase(
      id: '2',
      title: 'Transfer Negotiation',
      description: 'Negotiating transfer to United FC',
      status: 'Pending',
      clientId: '2',
      legalOfficerId: '1',
      createdAt: DateTime(2023, 6, 15),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legal Cases'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: cases.length,
        itemBuilder: (context, index) {
          return CaseCard(legalCase: cases[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create new case
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
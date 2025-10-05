import 'package:flutter/material.dart';
import 'package:football_fraternity/models/case.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class CaseCard extends StatelessWidget {
  final LegalCase legalCase;

  const CaseCard({super.key, required this.legalCase});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(Icons.gavel, color: Colors.white),
        ),
        title: Text(legalCase.title),
        subtitle: Text(
            'Opened: ${legalCase.createdAt.day}/${legalCase.createdAt.month}/${legalCase.createdAt.year}'),
        trailing: Chip(
          label: Text(
            legalCase.status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _getStatusColor(legalCase.status),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/cases/detail',
            arguments: legalCase,
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.blue;
      case 'in progress':
        return Colors.orange;
      case 'closed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
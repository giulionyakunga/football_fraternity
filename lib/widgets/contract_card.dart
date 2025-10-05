import 'package:flutter/material.dart';
import 'package:football_fraternity/models/contract.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class ContractCard extends StatelessWidget {
  final Contract contract;

  const ContractCard({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(Icons.assignment, color: Colors.white),
        ),
        title: Text('Contract with ${contract.club}'),
        subtitle: Text(
            '${contract.startDate.day}/${contract.startDate.month}/${contract.startDate.year} - ${contract.endDate.day}/${contract.endDate.month}/${contract.endDate.year}'),
        trailing: Chip(
          label: Text(
            contract.status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _getStatusColor(contract.status),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/contracts/detail',
            arguments: contract,
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'expiring':
        return Colors.orange;
      case 'terminated':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
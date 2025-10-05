import 'package:flutter/material.dart';
import 'package:football_fraternity/models/footballer.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class FootballerCard extends StatelessWidget {
  final Footballer footballer;

  const FootballerCard({super.key, required this.footballer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(footballer.imageUrl),
        ),
        title: Text(footballer.name),
        subtitle: Text('${footballer.position} • ${footballer.club}'),
        trailing: Chip(
          label: Text(
            footballer.contractStatus,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _getStatusColor(footballer.contractStatus),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/footballers/detail',
            arguments: footballer,
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
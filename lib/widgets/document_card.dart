import 'package:flutter/material.dart';
import 'package:football_fraternity/models/document.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class DocumentCard extends StatelessWidget {
  final Document document;

  const DocumentCard({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(Icons.insert_drive_file, color: Colors.white),
        ),
        title: Text(document.title),
        subtitle: Text('${document.type} • ${document.size}'),
        trailing: Chip(
          label: Text(
            document.status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _getStatusColor(document.status),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/documents/detail',
            arguments: document,
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'verified':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
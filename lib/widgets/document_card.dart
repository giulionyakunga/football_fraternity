import 'package:flutter/material.dart';
import 'package:football_fraternity/models/document.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:go_router/go_router.dart';

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
        subtitle: Text('${document.documentType} • ${document.size}'),
        trailing: Chip( 
          label: Text(
            document.fileType.toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _getStatusColor(document.fileName),
        ),
        onTap: () {
          context.go('/document-details', extra: document);
        },
      ),
    );
  }

  Color _getStatusColor(String fileName) {
    if (fileName.toLowerCase().contains('.pdf')) return Colors.red;
    if (fileName.toLowerCase().contains('.xlsx')) return Colors.green;
    if (fileName.toLowerCase().contains('.docx')) return Colors.blue;
    if (fileName.toLowerCase().contains('.jpg') || fileName.toLowerCase().contains('.png')) return Colors.orange;
    return Colors.grey;
  }
}
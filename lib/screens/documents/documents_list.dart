import 'package:flutter/material.dart';
import 'package:football_fraternity/models/document.dart';
import 'package:football_fraternity/widgets/document_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class DocumentsListScreen extends StatelessWidget {
  const DocumentsListScreen({super.key});

  final List<Document> documents = const [
    Document(
      id: '1',
      title: 'Contract Agreement',
      type: 'Contract',
      date: '2023-05-15',
      size: '2.5 MB',
      status: 'Verified', url: '', uploadedBy: '',
    ),
    Document(
      id: '2',
      title: 'Player Registration',
      type: 'Registration',
      date: '2023-06-20',
      size: '1.8 MB',
      status: 'Pending', url: '', uploadedBy: '',
    ),
    // Add more documents
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Management'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return DocumentCard(document: documents[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/documents/upload');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.upload),
      ),
    );
  }
}
import 'package:flutter/foundation.dart';
import 'package:football_fraternity/models/document.dart';

class DocumentProvider with ChangeNotifier {
  final List<Document> _documents = [];

  List<Document> get documents => [..._documents];

  void uploadDocument(Document document) {
    _documents.add(document);
    notifyListeners();
  }

  void deleteDocument(String id) {
    _documents.removeWhere((doc) => doc.id == id);
    notifyListeners();
  }

  List<Document> getDocumentsByType(String type) {
    return _documents.where((doc) => doc.type == type).toList();
  }

  List<Document> getUserDocuments(String userId) {
    return _documents.where((doc) => doc.uploadedBy == userId).toList();
  }
}
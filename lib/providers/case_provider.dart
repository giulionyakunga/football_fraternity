import 'package:flutter/foundation.dart';
import 'package:football_fraternity/models/case.dart';

class CaseProvider with ChangeNotifier {
  final List<LegalCase> _cases = [];

  List<LegalCase> get cases => [..._cases];

  void addCase(LegalCase legalCase) {
    _cases.add(legalCase);
    notifyListeners();
  }

  void updateCase(String id, LegalCase updatedCase) {
    final index = _cases.indexWhere((c) => c.id == id);
    if (index >= 0) {
      _cases[index] = updatedCase;
      notifyListeners();
    }
  }

  void closeCase(String id) {
    final index = _cases.indexWhere((c) => c.id == id);
    if (index >= 0) {
      _cases[index] = _cases[index].copyWith(status: 'Closed');
      notifyListeners();
    }
  }

  List<LegalCase> getClientCases(String clientId) {
    return _cases.where((c) => c.clientId == clientId).toList();
  }

  List<LegalCase> getLegalOfficerCases(String legalOfficerId) {
    return _cases.where((c) => c.legalOfficerId == legalOfficerId).toList();
  }
}
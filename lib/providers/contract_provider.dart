import 'package:flutter/foundation.dart';
import 'package:football_fraternity/models/contract.dart';

class ContractProvider with ChangeNotifier {
  final List<Contract> _contracts = [];

  List<Contract> get contracts => [..._contracts];

  void addContract(Contract contract) {
    _contracts.add(contract);
    notifyListeners();
  }

  void updateContract(String id, Contract updatedContract) {
    final index = _contracts.indexWhere((c) => c.id == id);
    if (index >= 0) {
      _contracts[index] = updatedContract;
      notifyListeners();
    }
  }

  void terminateContract(String id) {
    final index = _contracts.indexWhere((c) => c.id == id);
    if (index >= 0) {
      _contracts[index] = _contracts[index].copyWith(status: 'Terminated');
      notifyListeners();
    }
  }

  List<Contract> getFootballerContracts(String footballerId) {
    return _contracts.where((c) => c.footballerId == footballerId).toList();
  }

  List<Contract> getExpiringContracts(int days) {
    final now = DateTime.now();
    return _contracts.where((c) {
      final daysLeft = c.endDate.difference(now).inDays;
      return daysLeft <= days && c.status == 'Active';
    }).toList();
  }
}
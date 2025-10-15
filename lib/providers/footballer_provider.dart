import 'package:flutter/foundation.dart';
import 'package:football_fraternity/models/footballer.dart';

class FootballerProvider with ChangeNotifier {
  final List<Footballer> _footballers = [];

  List<Footballer> get footballers => [..._footballers];

  void addFootballer(Footballer footballer) {
    _footballers.add(footballer);
    notifyListeners();
  }

  void updateFootballer(String id, Footballer updatedFootballer) {
    final index = _footballers.indexWhere((f) => f.id == id);
    if (index >= 0) {
      _footballers[index] = updatedFootballer;
      notifyListeners();
    }
  }

  void deleteFootballer(String id) {
    _footballers.removeWhere((f) => f.id == id);
    notifyListeners();
  }

  List<Footballer> searchFootballers(String query) {
    return _footballers
        .where((f) => f.fullName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
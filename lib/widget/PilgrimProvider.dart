import 'package:flutter/material.dart';

class PilgrimProvider with ChangeNotifier {
  Map<String, dynamic>? _pilgrimData;

  Map<String, dynamic>? get pilgrimData => _pilgrimData;

  void setPilgrimData(Map<String, dynamic> data) {
    _pilgrimData = data;
    notifyListeners();
  }
}

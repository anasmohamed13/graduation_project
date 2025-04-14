import 'package:flutter/material.dart';

// will delete this code //
class GenderProvider with ChangeNotifier {
  String _localGender = 'male';

  String? get localGender => _localGender;

  void setGender(String? gender) {
    _localGender = gender ?? _localGender;
    notifyListeners();
  }
}

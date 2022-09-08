import 'package:flutter/material.dart';

class LearnProvider extends ChangeNotifier {
  bool selected = false;

  numberSelected() {
    selected = true;
    notifyListeners();
  }

  alphabetSelected() {
    selected = false;
    notifyListeners();
  }
  
}

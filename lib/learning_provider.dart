import 'package:flutter/material.dart';

class LearnProvider extends ChangeNotifier {
  bool selected = false;
  String name = "Numbers";

  numberSelected() {
    selected = true;
    name = "Numbers";
    notifyListeners();
  }

  alphabetSelected() {
    selected = false;
    name = "Alphabets";
    notifyListeners();
  }
}

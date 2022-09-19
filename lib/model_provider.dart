import 'package:flutter/cupertino.dart';

class ModelProvider with ChangeNotifier {
  String model = "assets/model_unquant.tflite";

  changeToNumber() {
    model = "assets/model_unquant.tflite";
    notifyListeners();
  }

  changeToAlphabet() {
    model = "assets/model_unquant.tflite";
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class MqttDataNotifier extends ChangeNotifier {
  double _humidity = 50.0;
  double _temperature = 22.0;
  double _moisture = 30.0;

  double get humidity => _humidity;
  double get temperature => _temperature;
  double get moisture => _moisture;

  void updateData(double humidity, double temperature, double moisture) {
    _humidity = humidity;
    _temperature = temperature;
    _moisture = moisture;
    notifyListeners();
  }
}

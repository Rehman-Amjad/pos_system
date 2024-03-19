import 'package:flutter/material.dart';
import 'package:pos_system/screens/Purchase/components/build_text_field.dart';

class FormBuilderProvider with ChangeNotifier {
  List<Widget> _formBuilders = [];
  List<Widget> get formBuilders => _formBuilders;

  void addFormBuilder() {
    _formBuilders.add(BuildTextField());
    notifyListeners();
  }

  void deleteFormBuilder(int index) {
    _formBuilders.removeAt(index);
    notifyListeners();
  }
}

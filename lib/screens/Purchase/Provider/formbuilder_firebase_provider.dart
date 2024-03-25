import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/build_text_field.dart';

class FormBuilderProvider with ChangeNotifier {
  String joiningDate = 'Select Joining Date';

  List<FormControllers> _items = [];
  List<FormControllers> get items => _items;

  List<FormControllers> _controllers = [];
  List<FormControllers> get controllers => _controllers;

  void addItem(BuildContext context) {
    _controllers.add(FormControllers());
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void datePicker(BuildContext context) async {
    DateTime? picDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));
    joiningDate = DateFormat('dd-MM-yyyy').format(picDate!);
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/provider/items_data_fetch_provider.dart';
import 'package:provider/provider.dart';

import '../components/build_text_field.dart';

class FormBuilderProvider with ChangeNotifier {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static CollectionReference ref =
      FirebaseFirestore.instance.collection('purchase');

  String joiningDate = 'Select Joining Date';

  List<BuildTextField> _items = [];
  List<BuildTextField> get items => _items;

  List<FormControllers> _controllers = [];
  List<FormControllers> get controllers => _controllers;

  void addItem() {
    _items.add(BuildTextField(index: _items.length));
    _controllers.add(FormControllers());
    notifyListeners();
  }

  void deleteItem(int index, BuildContext context) {
    _items.removeAt(index);
    notifyListeners();
  }

  Future<void> saveDataToFireStore(
    BuildContext context, {
    required purchaseCode,
    purchaseDate,
    time,
    vendor,
    vendorID,
    remarks,
    paymentVia,
    date,
  }) async {
    try {
      await fireStore.collection('purchase').doc(purchaseCode).set({
        'purchaseCode': purchaseCode,
        'date': date,
        'purchaseDate': purchaseDate,
        'time': time,
        'vendor': vendor,
        'vendorID': vendorID,
        'remarks': remarks,
        'paymentVia': paymentVia,
        'invoiceType': 'purchase'
      }).whenComplete(() {
        print("Running");
        saveItems(context, purchaseCode);
      });
      print('Data saved to Firestore successfully');
    } catch (error) {
      print('Error saving data to Firestore: $error');
    }
  }

  Future<void> saveItems(BuildContext context, String purchaseCode) async {
    try {
      for (int i = 0; i < _items.length; i++) {
        FormControllers controllers = _controllers[i];
        String selectedItemName = controllers.itemNameController.text;
        String selectedItemCode = controllers.itemCodeController.text;
        String uom = controllers.uomController.text;
        String quantity = controllers.quantityController.text;
        String priceRate = controllers.priceRateController.text;
        String saleRate = controllers.saleRateController.text;
        String discount = controllers.discountController.text;
        String total = controllers.totalController.text;
        String id = DateTime.now().millisecondsSinceEpoch.toString();

        await fireStore
            .collection('purchase')
            .doc(purchaseCode)
            .collection("items")
            .doc(id)
            .set({
          'selectedItemName': selectedItemName,
          'selectedItemCode': selectedItemCode,
          'uom': uom,
          'quantity': quantity,
          'priceRate': priceRate,
          'saleRate': saleRate,
          'discount': discount,
          'total': total,
          'id': id,
        }).whenComplete(() {});
      }
      print('Data saved to Firestore successfully');
    } catch (error) {
      print('Error saving data to Firestore: $error');
    }
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

// Delete Function

// Future<void> deleteDataFromFireStore(int index) async {
//   try {
//     final QuerySnapshot querySnapshot =
//         await fireStore.collection('purchase').get();
//     final List<DocumentSnapshot> docs = querySnapshot.docs;
//     if (index >= 0 && index < docs.length) {
//       await ref.doc(docs[index].id.toString()).delete();
//       print('Document deleted successfully');
//     } else {
//       print('Invalid index');
//     }
//   } catch (error) {
//     print('Error deleting document: $error');
//   }
//   _items.removeAt(index);
//   notifyListeners();
// }

// int _counter = 0;
//
// String generateUniqueId() {
//   _counter++;
//   return 'buildTextField_$_counter';
// }

// void clearItems() {
//   _items.clear();
//   _controllers.clear();
//   notifyListeners();
// }

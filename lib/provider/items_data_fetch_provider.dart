import 'package:flutter/cupertino.dart';

import '../constants.dart';

class ItemsDataProvider extends ChangeNotifier {
  List<String> category = [];
  String? selectedCategory;
  String? selectedCategoryId;
  Map<String, String> itemDocumentIds = {};
  void Function(String, String)? onSelectedItemChanged;

  List<String> uom = [];
  String? selectedUom;
  String? selectedUomId;
  Map<String, String> itemUomDocumentIds = {};

  List<String> vendor = [];
  String? selectedVendor;
  String? selectedVendorId;
  Map<String, String> vendorDocumentIds = {};
  void Function(String, String)? onSelectedVendorChanged;

  List<String> itemName = [];
  List<String> itemsID = [];
  String? selectedItemName;
  String? selectedItemNameId;
  Map<String, String> itemNameDocumentIds = {};
  void Function(String, String)? onSelectedItemNameChanged;

  List<String> cashMethods = [
    'cash',
    'credit',
    'other',
  ];

  String? selectCashMethod;

  Future<void> fetchCategory() async {
    try {
      final snapshot =
          await firestore.collection(Constant.COLLECTION_CATEGORY).get();
      category = snapshot.docs
          .map((doc) => doc.data()[Constant.KEY_CATEGORY_NAME] as String)
          .toList();

      itemDocumentIds = {
        for (var doc in snapshot.docs)
          (doc.data())[Constant.KEY_CATEGORY_NAME] as String: doc.id
      };

      selectedCategory = category[0];
      print(selectedItemNameId);
      notifyListeners();
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void setSelectedCategory(String newValue) {
    selectedCategory = newValue;
    selectedCategoryId = itemDocumentIds[newValue];
    notifyListeners();
    if (onSelectedItemChanged != null) {
      onSelectedItemChanged!(newValue,
          selectedCategoryId!); // Pass document ID along with item value
    }
  }

  // UOM
  Future<void> fetchUom() async {
    try {
      final snapshot =
          await firestore.collection(Constant.COLLECTION_UOM).get();
      uom = snapshot.docs
          .map((doc) => doc.data()[Constant.KEY_UOM_NAME] as String)
          .toList();
      itemUomDocumentIds = {
        for (var doc in snapshot.docs)
          (doc.data())[Constant.KEY_UOM_NAME] as String: doc.id
      };
      selectedUom = uom[0];
      notifyListeners();
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void setSelectedUom(String newValue) {
    selectedUom = newValue;
    selectedUomId = itemUomDocumentIds[newValue];
    notifyListeners();
    if (onSelectedItemChanged != null) {
      onSelectedItemChanged!(
          newValue, selectedUomId!); // Pass document ID along with item value
    }
  }

  Future<void> fetchVendorName() async {
    try {
      final snapshot =
          await firestore.collection(Constant.COLLECTION_VENDORMAN).get();
      vendor = snapshot.docs
          .map((doc) => doc.data()[Constant.KEY_VENDORMAN_NAME] as String)
          .toList();
      vendorDocumentIds = {
        for (var doc in snapshot.docs)
          (doc.data())[Constant.KEY_VENDORMAN_NAME] as String: doc.id
      };
      selectedVendor = vendor[0];
      notifyListeners();
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void setSelectedVendorName(String newValue) {
    selectedVendor = newValue;
    selectedVendorId = vendorDocumentIds[newValue];
    notifyListeners();
    if (onSelectedVendorChanged != null) {
      onSelectedVendorChanged!(newValue,
          selectedVendorId!); // Pass document ID along with item value
    }
  }

  Future<void> fetchItemName() async {
    try {
      final snapshot =
          await firestore.collection(Constant.COLLECTION_ITEMS).get();
      itemName = snapshot.docs
          .map((doc) => doc.data()[Constant.KEY_ITEM_NAME] as String)
          .toList();
      itemsID = snapshot.docs
          .map((doc) => doc.data()[Constant.KEY_ITEM_CODE] as String)
          .toList();
      selectedItemName = itemName[0];
      selectedItemNameId = itemsID[0];
      print('Selected Item Name: $selectedItemName');
      print('Selected Item ID: $selectedItemNameId');
      notifyListeners();
    } catch (e) {
      print('Error Fetching data: $e');
    }
    notifyListeners();
  }

  void setSelectedItemName(String newValue) {
    selectedItemName = newValue;
    selectedItemNameId = itemNameDocumentIds[newValue];
    selectedItemName = itemName[0];
    selectedItemNameId = itemsID[0];
  }
}

// List<int> itemQuantities = []; // List to store item quantities
// String? selectedItemQuantity;
//
// Future<void> fetchItemQuantities() async {
//   try {
//     final snapshot =
//         await firestore.collection(Constant.COLLECTION_ITEMS).get();
//     itemQuantities = snapshot.docs
//         .map((doc) => doc.data()[Constant.KEY_ITEM_QUANTITY] as int)
//         .toList();
//     notifyListeners();
//   } catch (e) {
//     print('Error Fetching data: $e');
//   }
// }
//
// void setSelectedItemQuantity(String newValue) {
//   selectedItemQuantity = newValue;
//   notifyListeners();
// }

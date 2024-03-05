import 'package:flutter/cupertino.dart';
import 'package:pos_system/constants.dart';

class ItemsDataProvider extends ChangeNotifier {
  List<String> category = [];
  String? selectedCategory;
  String? selectedCategoryId; // Store selected item's document ID
  Map<String, String> itemDocumentIds = {};
  void Function(String, String)? onSelectedItemChanged;



  List<String> uom = [];
  String? selectedUom;
  String? selectedUomId; // Store selected item's document ID
  Map<String, String> itemUomDocumentIds = {};




  Future<void> fetchCategory() async {
    try {
      final snapshot = await firestore.collection(Constant.COLLECTION_CATEGORY).get();
      category = snapshot.docs.map((doc) => doc.data()[Constant.KEY_CATEGORY_NAME] as String).toList();
      itemDocumentIds = { for (var doc in snapshot.docs) (doc.data())[Constant.KEY_CATEGORY_NAME] as String : doc.id };
      selectedCategory = category[0];
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
      onSelectedItemChanged!(newValue, selectedCategoryId!); // Pass document ID along with item value
    }
  }

  // UOM
  Future<void> fetchUom() async {
    try {
      final snapshot = await firestore.collection(Constant.COLLECTION_UOM).get();
      uom = snapshot.docs.map((doc) => doc.data()[Constant.KEY_UOM_NAME] as String).toList();
      itemUomDocumentIds = { for (var doc in snapshot.docs) (doc.data())[Constant.KEY_UOM_NAME] as String : doc.id };
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
      onSelectedItemChanged!(newValue, selectedUomId!); // Pass document ID along with item value
    }
  }
}
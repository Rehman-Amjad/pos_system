import 'package:flutter/cupertino.dart';
import 'package:pos_system/constants.dart';

class UomProvider with ChangeNotifier{



  // category firebase collection
  Future<void> uploadUom({required count,required name, required description}) async {
    DateTime time = DateTime.now();
    try {
      await firestore.collection(Constant.COLLECTION_UOM).doc(count.toString()).set({
        Constant.KEY_UOM_ID : count.toString(),
        Constant.KEY_UOM_NAME : name.toString().toLowerCase(),
        Constant.KEY_UOM_DESC : description.toString(),
        "timeStamp" :  time.millisecondsSinceEpoch.toString(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> updateUom({required code,required name, required description}) async {
    try {
      await firestore.collection(Constant.COLLECTION_UOM).doc(code.toString()).set({
        Constant.KEY_UOM_NAME : name.toString().toLowerCase(),
        Constant.KEY_UOM_DESC : description.toString(),
      });
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

  Future<void> deleteUom({required id}) async {
    try {
      await firestore.collection(Constant.COLLECTION_UOM).doc(id.toString()).delete();
      notifyListeners();
    } catch (e) {
      print("Error fetching count value: $e");
    }
    notifyListeners();
  }

}
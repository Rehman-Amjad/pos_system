import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/helper/button_widget.dart';
import 'package:pos_system/helper/text_widget.dart';
import 'package:pos_system/screens/saleman/provider/salesman_firebase_provider.dart';
import 'package:pos_system/responsive.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controllers/MenuAppController.dart';
import '../../../helper/custom_shadow_button.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/text_helper.dart';
import '../../../provider/count_value_provider.dart';
import '../../../route/routes.dart';

class SalesManForm extends StatefulWidget {

  @override
  State<SalesManForm> createState() => _SalesManFormState();
}

class _SalesManFormState extends State<SalesManForm> {
  _SalesManFormState(){
    selectedStatus = statusList[0];
  }
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  String selectedStatus = "";
  var statusList = ['Running','Close'];
  String joinDate = "select Joining date";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<CountValueProvider>(context, listen: false)
    //     .fetchCountValue();
    Provider.of<CountValueProvider>(context, listen: false).fetchCountValue();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final countProvider = Provider.of<CountValueProvider>(context, listen: false);
    final dataProvider = Provider.of<SalesManDataProvider>(context, listen: false);
    return Container(
        width: size.width,
        padding: EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextHelper().mNormalText(text: "Sale Man Code: ",color: Colors.white,size: 14),
                Consumer<CountValueProvider>(
                  builder: (context, countValue, child) {
                    return TextHelper().mNormalText(text: countValue.countValue.toString(),color: hoverColor,size: 16);
                  },
                ),
              ],
            ),
            SizedBox(height: 15,),
            TextHelper().mNormalText(text: "Sale Man Name",color: Colors.white,size: 14),
            SizedBox(height: 15,),
            Container(
                width: Responsive.isMobile(context) ?  size.width: size.width / 1.9 ,
                child: CustomTextField(
                  controller: nameController,
                  hintText: 'Enter Sale Man Name',)),

            SizedBox(height: 20,),
            TextHelper().mNormalText(text: "Sale Man Phone",color: Colors.white,size: 14),
            const SizedBox(height: 15,),
            Container(
                width: Responsive.isMobile(context) ?  size.width: size.width / 1.9 ,
                child: CustomTextField(
                  controller: phoneController,
                  hintText: 'Phone number',)),

            SizedBox(height: 20,),

            TextHelper().mNormalText(text: "Sale Man Address",color: Colors.white,size: 14),
            const SizedBox(height: 15,),
            Container(
                width: Responsive.isMobile(context) ?  size.width: size.width / 1.9 ,
                child: CustomTextField(
                  controller: addressController,
                  hintText: 'Enter Address',)),

            // CustomDropDown(
            //   enabled: true,
            //   items: ['close','Running'],
            //   onChanged: (value) {
            //     print(value);
            // },),
            const SizedBox(height: 20,),
            TextHelper().mNormalText(text: "Joining Date",color: Colors.white,size: 14),
            const SizedBox(height: 15,),
            GestureDetector(
              onTap: () => _showDatePicker(),
              child: Container(
                width: Responsive.isMobile(context) ?  size.width: size.width / 2.9 ,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: Colors.white
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                child:  Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10.0,top: 20.0,bottom:20.0),
                  child: TextWidget(text: joinDate,color: Colors.white,size: 14, isBold: false,),
                ),
              ),
            ),

            const SizedBox(height: 20,),
            TextHelper().mNormalText(text: "Select Status",color: Colors.white,size: 14),
            const SizedBox(height: 15,),
            Container(
              width: Responsive.isMobile(context) ?  size.width: size.width / 2.9 ,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.white
                ),
                borderRadius: BorderRadius.circular(5)
              ),
              child:  Padding(
                padding: const EdgeInsets.only(left: 10,right: 5.0,top: 5.0,bottom:5.0),
                child: DropdownButtonFormField(
                  value: selectedStatus,
                  items: statusList
                      .map((e) => DropdownMenuItem(
                    child: TextWidget(text: e, color: Colors.white, size: 12, isBold: false,),
                    value: e,
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus =
                      value as String;
                    });
                    // selectedGroup = value as String;
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: hoverColor,
                  ),
                  dropdownColor: bgColor,
                  decoration: const InputDecoration(
                    border: InputBorder.none
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            Row(
              children: [
                ButtonWidget(
                  text: "Save", onClicked: () {

                  if(nameController.text.isNotEmpty && phoneController.text.isNotEmpty){
                    countProvider.fetchCountValue();
                    int newCountValue = countProvider.countValue;
                    dataProvider.uploadSalesMan(
                        collection: Constant.COLLECTION_SALESMAN,
                        count: newCountValue,
                        name: nameController.text.toString(),
                        phone: phoneController.text.toString(),
                        address: addressController.text.toString(),
                        joinDate: joinDate,
                        status: selectedStatus);

                    countProvider.updateCountValue(count: newCountValue+1);
                    countProvider.fetchCountValue();
                    nameController.text = "";
                    phoneController.text = "";
                    addressController.text = "";
                    Get.snackbar("New sale man Added", "",backgroundColor: hoverColor,colorText: Colors.white);
                  }else{
                    Get.snackbar("Alert!!!", "Please filled missing fields",backgroundColor: Colors.red,colorText: Colors.white);
                  }


                }, icons: false, width: 100, height: 50,
                ),
                const SizedBox(width: 20,),
                ButtonWidget(
                  text: "Cancel", onClicked: () {
                  Provider.of<MenuAppController>(context, listen: false)
                      .changeScreen(Routes.SALESMAN);
                }, icons: false, width: 100, height: 50,backgroundColor: Colors.grey,
                ),
              ],
            ),
          ],
        )
    );
  }
  void _showDatePicker() async {
    DateTime? picDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));

    setState(() {
      joinDate = DateFormat('dd-MM-yyyy').format(picDate!);
    });
  }
}

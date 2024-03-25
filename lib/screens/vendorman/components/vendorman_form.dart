import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/helper/button_widget.dart';
import 'package:pos_system/helper/text_widget.dart';
import 'package:pos_system/screens/saleman/provider/salesman_firebase_provider.dart';
import 'package:pos_system/responsive.dart';
import 'package:pos_system/screens/supplyman/provider/supplyman_firebase_provider.dart';
import 'package:pos_system/screens/vendorman/provider/vendorman_firebase_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controllers/MenuAppController.dart';
import '../../../helper/custom_shadow_button.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/text_helper.dart';
import '../../../provider/count_value_provider.dart';
import '../../../route/routes.dart';

class VendorManForm extends StatefulWidget {
  final String code, name, phone, address, joinDate, status;
  final String edit;
  String joiningDate = "select Joining date";
  VendorManForm({
    required this.edit,
    required this.code,
    required this.name,
    required this.phone,
    required this.address,
    this.joinDate = "select Join date",
    required this.status,
  }) {
    joiningDate = joinDate;
  }

  @override
  State<VendorManForm> createState() => _VendorManFormState();
}

class _VendorManFormState extends State<VendorManForm> {
  _VendorManFormState() {
    //  widget.edit=='true' ? selectedStatus = widget.status : selectedStatus = statusList[0];
    selectedStatus = statusList[0];
  }

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  String selectedStatus = "";
  var statusList = ['Running', 'Close'];

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
    final countProvider =
        Provider.of<CountValueProvider>(context, listen: false);
    final dataProvider =
        Provider.of<VendorDataProvider>(context, listen: false);
    return Container(
        width: size.width,
        padding: const EdgeInsets.all(defaultPadding),
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
                TextHelper().mNormalText(
                    text: "Vendor Code: ", color: Colors.white, size: 14.0),
                Consumer<CountValueProvider>(
                  builder: (context, countValue, child) {
                    return TextHelper().mNormalText(
                        text: widget.edit == 'true'
                            ? widget.code
                            : countValue.countValue.toString(),
                        color: hoverColor,
                        size: 16);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            TextHelper().mNormalText(
                text: "Vendor Name: ", color: Colors.white, size: 14.0),
            SizedBox(
              height: 15.0,
            ),
            Container(
                width: Responsive.isMobile(context)
                    ? size.width
                    : size.width / 1.9,
                child: CustomizeTextField(
                  controller: nameController,
                  hintText: widget.edit == 'true'
                      ? nameController.text = widget.name
                      : widget.name,
                )),

            SizedBox(
              height: 20.0,
            ),
            TextHelper().mNormalText(
                text: "Vendor Phone", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            Container(
                width: Responsive.isMobile(context)
                    ? size.width
                    : size.width / 1.9,
                child: CustomizeTextField(
                  controller: phoneController,
                  hintText: widget.edit == 'true'
                      ? phoneController.text = widget.phone
                      : widget.phone,
                )),

            SizedBox(
              height: 20.0,
            ),

            TextHelper().mNormalText(
                text: "Vendor Address", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            Container(
                width: Responsive.isMobile(context)
                    ? size.width
                    : size.width / 1.9,
                child: CustomizeTextField(
                  controller: addressController,
                  hintText: widget.edit == 'true'
                      ? addressController.text = widget.address
                      : widget.address,
                )),

            // CustomDropDown(
            //   enabled: true,
            //   items: ['close','Running'],
            //   onChanged: (value) {
            //     print(value);
            // },),
            const SizedBox(
              height: 20.0,
            ),
            TextHelper().mNormalText(
                text: "Joining Date", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => _showDatePicker(),
              child: Container(
                width: Responsive.isMobile(context)
                    ? size.width
                    : size.width / 2.9,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
                  child: TextWidget(
                    text: widget.joiningDate,
                    color: Colors.white,
                    size: 14,
                    isBold: false,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20.0,
            ),
            TextHelper().mNormalText(
                text: "Select Status", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 2.9,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 5.0, top: 5.0, bottom: 5.0),
                child: DropdownButtonFormField(
                  value: selectedStatus,
                  items: statusList
                      .map((e) => DropdownMenuItem(
                            child: TextWidget(
                              text: e,
                              color: Colors.white,
                              size: 12.0,
                              isBold: false,
                            ),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value as String;
                    });
                    // selectedGroup = value as String;
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: hoverColor,
                  ),
                  dropdownColor: bgColor,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),

            SizedBox(
              height: 20.0,
            ),

            Row(
              children: [
                widget.edit == 'true'
                    ? ButtonWidget(
                        text: "Update",
                        onClicked: () {
                          if (nameController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty) {
                            dataProvider.updateVendorData(
                                collection: Constant.COLLECTION_VENDORMAN,
                                code: widget.code,
                                name: nameController.text.toString(),
                                phone: phoneController.text.toString(),
                                address: addressController.text.toString(),
                                joinDate: widget.joiningDate.toString(),
                                status: selectedStatus);
                            Get.snackbar("Vendor Updated...", "",
                                backgroundColor: hoverColor,
                                colorText: Colors.white);
                          } else {
                            Get.snackbar(
                                "Alert!!!", "Please filled missing fields",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        icons: false,
                        width: 100.0,
                        height: 50.0,
                      )
                    : ButtonWidget(
                        text: "Save",
                        onClicked: () {
                          if (nameController.text.isNotEmpty &&
                              phoneController.text.isNotEmpty) {
                            countProvider.fetchCountValue();
                            int newCountValue = countProvider.countValue;
                            dataProvider.uploadVendorData(
                                collection: Constant.COLLECTION_VENDORMAN,
                                count: newCountValue,
                                name: nameController.text.toString(),
                                phone: phoneController.text.toString(),
                                address: addressController.text.toString(),
                                joinDate: widget.joiningDate.toString(),
                                status: selectedStatus);

                            countProvider.updateCountValue(
                                count: newCountValue + 1);
                            countProvider.fetchCountValue();
                            nameController.text = "";
                            phoneController.text = "";
                            addressController.text = "";
                            Get.snackbar("New Vendor Added", "",
                                backgroundColor: hoverColor,
                                colorText: Colors.white);
                          } else {
                            Get.snackbar(
                                "Alert!!!", "Please filled missing fields",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        icons: false,
                        width: 100.0,
                        height: 50.0,
                      ),
                const SizedBox(
                  width: 20.0,
                ),
                ButtonWidget(
                  text: "Cancel",
                  onClicked: () {
                    Provider.of<MenuAppController>(context, listen: false)
                        .changeScreen(Routes.VENDOR);
                  },
                  icons: false,
                  width: 100.0,
                  height: 50.0,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          ],
        ));
  }

  void _showDatePicker() async {
    DateTime? picDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));

    setState(() {
      widget.joiningDate = DateFormat('dd-MM-yyyy').format(picDate!);
    });
  }
}

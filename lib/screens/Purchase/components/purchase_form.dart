import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/constants.dart';
import 'package:pos_system/controllers/cash_dropdown.dart';
import 'package:pos_system/controllers/vendor_dropdown.dart';
import 'package:pos_system/provider/count_value_provider.dart';
import 'package:pos_system/provider/items_data_fetch_provider.dart';
import 'package:pos_system/screens/Purchase/Provider/formbuilder_firebase_provider.dart';
import 'package:provider/provider.dart';
import '../../../helper/text_helper.dart';
import '../../../helper/text_widget.dart';
import '../../../responsive.dart';
import 'build_text_field.dart';

class PurchaseForm extends StatefulWidget {
  var joinDate;

  PurchaseForm({
    super.key,
    this.joinDate = "select Join date",
  });

  @override
  State<PurchaseForm> createState() => _PurchaseFormState();
}

var serialController = TextEditingController();
var vendorController = TextEditingController();
var voucherController = TextEditingController();
var remarksController = TextEditingController();

class _PurchaseFormState extends State<PurchaseForm> {
  @override
  Widget build(BuildContext context) {
    Provider.of<CountValueProvider>(context, listen: false).fetchCountValue();
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                        text: "Serial number: ",
                        color: Colors.white,
                        size: 14.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 50.0,
                        width: Responsive.isMobile(context)
                            ? size.width
                            : size.width / 3.9,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Consumer<CountValueProvider>(
                            builder: (context, value, child) {
                              return TextHelper().mNormalText(
                                  text: value.countValue.toString(),
                                  color: hoverColor,
                                  size: 16.0);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 45.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                        text: "Date: ",
                        color: Colors.white,
                        size: 14.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () => _showDatePicker(),
                        child: Container(
                          height: 50.0,
                          width: Responsive.isMobile(context)
                              ? size.width
                              : size.width / 3.9,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Center(
                              child: TextWidget(
                                text: widget.joinDate,
                                color: Colors.white,
                                size: 14.0,
                                isBold: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            TextHelper().mNormalText(
                text: "Vendor Name: ", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(right: 120),
              child: Container(
                height: 50.0,
                width: Responsive.isMobile(context)
                    ? size.width
                    : size.width / 0.9,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5)),
                child: Consumer<ItemsDataProvider>(
                  builder: (context, value, child) {
                    if (value.vendor.isEmpty) {
                      value.fetchVendorName();
                      return Center(
                        child: CircularProgressIndicator(
                          color: hoverColor,
                        ),
                      );
                    } else {
                      return VendorDropDown(
                        vendors: value.vendor,
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                        text: "Remarks: ",
                        color: Colors.white,
                        size: 14.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: Responsive.isMobile(context)
                            ? size.width
                            : size.width / 1.9,
                        child: TextFormField(
                          cursorColor: hoverColor,
                          controller: remarksController,
                          decoration: InputDecoration(
                            hintText: 'Edit Text',
                            hintStyle: TextStyle(fontSize: 12),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 55.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                        text: "Payment Term: ",
                        color: Colors.white,
                        size: 14.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 50.0,
                        width: Responsive.isMobile(context)
                            ? size.width
                            : size.width / 3.9,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        child: CashDropdown(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: 18, left: 5), // Adjust the bottom value
              child: Divider(
                color: hoverColor,
                thickness: 0.4,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 18, left: 5),
              child: Divider(
                color: hoverColor,
                thickness: 2.5,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Consumer<FormBuilderProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.formBuilders.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            BuildTextField(
                              index: index,
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      },
                    ),
                    Container(
                      height: 36.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: hoverColor,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18.0,
                          ),
                          onPressed: () {
                            value.addFormBuilder();
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker() async {
    DateTime? picDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));

    setState(() {
      widget.joinDate = DateFormat('dd-MM-yyyy').format(picDate!);
    });
  }
}

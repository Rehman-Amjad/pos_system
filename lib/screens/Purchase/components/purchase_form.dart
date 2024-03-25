import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/controllers/cash_dropdown.dart';
import 'package:pos_system/screens/Purchase/Provider/formbuilder_firebase_provider.dart';
import 'package:pos_system/screens/Purchase/components/build_text_field.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../controllers/vendor_dropdown.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/text_helper.dart';
import '../../../helper/text_widget.dart';
import '../../../provider/count_value_provider.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../responsive.dart';

class PurchaseForm extends StatelessWidget {
  int index;
  PurchaseForm({
    super.key,
    this.index = 0,
  });

  TextEditingController _stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<CountValueProvider>(context, listen: false).fetchCountValue();
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Responsive.isMobile(context) ? size.width : size.width / 1.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                          text: "Serial Number:",
                          color: Colors.white,
                          size: 14.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 60.0,
                        width: Responsive.isMobile(context)
                            ? size.width
                            : size.width / 2.9,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0)),
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
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 80.0,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                          text: "Date", color: Colors.white, size: 14.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Consumer<FormBuilderProvider>(
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () => value.datePicker(context),
                            child: Container(
                              width: Responsive.isMobile(context)
                                  ? size.width
                                  : size.width / 2.9,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 20.0,
                                      bottom: 20.0),
                                  child: TextWidget(
                                    text: value.joiningDate,
                                    color: hoverColor,
                                    size: 14.0,
                                    isBold: false,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35.0,
          ),
          TextHelper().mNormalText(
              text: "Vendor Name:", color: Colors.white, size: 14.0),
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 35.0),
            child: Container(
              height: 60.0,
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 0.9,
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
                    return VendorDropdown();
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Container(
            width: Responsive.isMobile(context) ? size.width : size.width / 1.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                          text: "Remarks", color: Colors.white, size: 14.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: Responsive.isMobile(context)
                            ? size.width
                            : size.width / 3.9,
                        child: CustomizeTextField(
                          controller: _stockController,
                          hintText: 'Edit Text',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 80.0,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHelper().mNormalText(
                          text: "Payment Term:",
                          color: Colors.white,
                          size: 14.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 60.0,
                        width: Responsive.isMobile(context)
                            ? size.width
                            : size.width / 3.9,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(5)),
                        child: CashDropDown(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 18.0, left: 5.0),
            child: Divider(
              color: hoverColor,
              thickness: 0.4,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 18.0, left: 5.0),
            child: Divider(
              color: hoverColor,
              thickness: 2.5,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.safety_check_outlined),
          ),
          SizedBox(
            height: 45.0,
          ),
          Consumer<FormBuilderProvider>(
            builder: (context, provider, _) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: provider.controllers.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      BuildTextField(
                        index: index + 1,
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            },
          ),
          Center(
            child: Container(
              height: 36.0,
              width: 36.0, // Set width to make it a circle
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hoverColor,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18.0,
                ),
                onPressed: () {
                  Provider.of<FormBuilderProvider>(context, listen: false)
                      .addItem(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

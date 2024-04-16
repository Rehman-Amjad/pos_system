import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/controllers/cash_dropdown.dart';
import 'package:pos_system/screens/Purchase/Provider/formbuilder_firebase_provider.dart';
import 'package:pos_system/screens/Purchase/components/build_text_field.dart';
import 'package:pos_system/screens/Purchase/purchase_generate_pdf.dart';
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
  PurchaseForm({super.key, this.index = 0});

  TextEditingController _remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormBuilderProvider>(context, listen: false);
    final provider1 = Provider.of<CountValueProvider>(context, listen: false);
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
                          text: "Invoice Number:",
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
                            onTap: () {
                              value.datePicker(context);
                            },
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
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: secondaryColor,
                      ),
                      child: Center(
                        child: Text(
                          "No Items Found",
                          style: TextStyle(
                              fontSize: Responsive.isMobile(context) ? 12 : 18,
                              fontWeight: FontWeight.bold),
                        ),
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
                          controller: _remarksController,
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
            padding: EdgeInsets.only(right: 18.0, left: 5.0, bottom: 8.0),
            child: Divider(
              color: hoverColor,
              thickness: 2.5,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    provider.saveDataToFireStore(
                      context,
                      purchaseCode: provider1.countValue.toString(),
                      paymentVia: AllController.cash,
                      remarks: _remarksController.text.toString(),
                      vendor: AllController.vendor,
                      date: provider.joiningDate,
                      time: DateTime.now(),
                    );
                    provider1.fetchCountValue();
                    int newCountValue = provider1.countValue;
                    provider1.updateCountValue(count: newCountValue + 1);
                    _remarksController.text = '';
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: hoverColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    List<Map<String, String>> rowsData = [];
                    for (int i = 0; i < provider.items.length; i++) {
                      FormControllers controllers = provider.controllers[i];

                      String selectedItemName =
                          controllers.itemNameController.text;
                      String selectedItemCode =
                          controllers.itemCodeController.text;
                      String selectedUom = controllers.uomController.text;
                      String selectedStock = controllers.stockController.text;
                      String totalAmount =
                          controllers.totalAmountController.text;
                      String quantity = controllers.quantityController.text;
                      String priceRate = controllers.priceRateController.text;
                      String saleRate = controllers.saleRateController.text;
                      String discount = controllers.discountController.text;
                      String total = controllers.totalController.text;
                      String plusStock = controllers.stockController.text +
                          "+" +
                          controllers.quantityController.text;

                      rowsData.add({
                        'SerialNumber': (i + 1).toString(),
                        'ItemName': selectedItemName,
                        'ItemCode': selectedItemCode,
                        'ItemPriceRate': priceRate,
                        'ItemSalePrice': saleRate,
                        'Amount': total,
                        'TotalAmount': totalAmount,
                        'Discount': discount,
                        'Quantity': quantity,
                        'Uom': selectedUom,
                        'Stock': selectedStock,
                        'PlusStock': plusStock,
                      });
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PurchasePdf(
                          cash: MultiController.cash1.toString(),
                          joinDate: provider.joiningDate,
                          remarks: _remarksController.text,
                          vendor: MultiController.vendor1.toString(),
                          rowsData: rowsData,
                          invoiceNumber: provider1.countValue.toString(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Preview',
                    style: TextStyle(color: hoverColor),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Consumer<FormBuilderProvider>(
            builder: (context, value, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: value.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 2),
                                child: Text('Serial no: '),
                              ),
                              Text(
                                (index + 1).toString(),
                                style: TextStyle(color: hoverColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 18.0),
                      value.items[index],
                      SizedBox(height: 10.0),
                      if (index == value.items.length - 1)
                        Center(
                          child: Container(
                            height: 32.0,
                            width: 32.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              color: hoverColor,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 16.0,
                              ),
                              onPressed: () {
                                Provider.of<FormBuilderProvider>(context,
                                        listen: false)
                                    .deleteItem(index, context);
                                print('indexToDelete: $index');
                              },
                            ),
                          ),
                        ),
                      SizedBox(height: 12.0),
                      Divider(),
                      SizedBox(height: 18.0),
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(height: 10.0),
          Container(
            height: 36.0,
            width: 36.0,
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
                    .addItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MultiController {
  static dynamic cash1 = TextEditingController();
  static dynamic vendor1 = TextEditingController();
}

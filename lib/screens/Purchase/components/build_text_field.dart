
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/screens/Purchase/Provider/formbuilder_firebase_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../responsive.dart';

class BuildTextField extends StatefulWidget {
  final int index;
  BuildTextField({
    Key? key,
    this.index = 0,
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

FormControllers _formControllers = FormControllers();

// _formControllers = Provider.of<FormBuilderProvider>(context, listen: false)
//     .controllers[widget.index];
class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text('Item Code: '),
            ),
            Consumer<ItemsDataProvider>(
              builder: (context, value, child) {
                return Text(
                  value.selectedItemNameId.toString(),
                  style: TextStyle(color: hoverColor),
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                'Company: ',
              ),
            ),
            Text(
              'Vendor',
              style: TextStyle(color: hoverColor),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Items Name',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    Container(
                      height: 55.0,
                      width: Responsive.isMobile(context)
                          ? size.width
                          : size.width / 2.9,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: hoverColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Consumer<ItemsDataProvider>(
                        builder: (context, values, child) {
                          if (values.itemName.isEmpty) {
                            values.fetchItemName();
                            return Center(
                              child: CircularProgressIndicator(
                                color: hoverColor,
                              ),
                            );
                          } else {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select Item Name',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: provider.itemName
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      value: provider.selectedItemName,
                                      onChanged: (value) {
                                        setState(() {
                                          provider.selectedItemName = value;
                                          int itemIndex =
                                              provider.itemName.indexOf(value!);
                                          provider.selectedItemNameId =
                                              provider.itemsID[itemIndex];
                                          provider.selectedItemQuantity =
                                              provider.itemQuantity[itemIndex];
                                          provider.selectedItemSalePrice =
                                              provider.itemSalePrice[itemIndex];
                                          provider.selectedItemPurchasePrice =
                                              provider
                                                  .itemPurchasePrice[itemIndex];
                                          _formControllers
                                              .itemNameController.text = value;
                                          _formControllers
                                                  .itemCodeController.text =
                                              provider.itemsID[itemIndex];
                                        });
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        height: 57.0,
                                        width: 400.0,
                                      ),
                                      dropdownStyleData:
                                          const DropdownStyleData(
                                        maxHeight: 200.0,
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40.0,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController:
                                            _formControllers.itemController,
                                        searchInnerWidgetHeight: 50.0,
                                        searchInnerWidget: Container(
                                          height: 57.0,
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 4.0,
                                            right: 8.0,
                                            left: 8.0,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller:
                                                _formControllers.itemController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 8.0,
                                              ),
                                              hintText:
                                                  'Search for Item Name...',
                                              hintStyle: const TextStyle(
                                                  fontSize: 12.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          return item.value
                                              .toString()
                                              .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          _formControllers.itemController
                                              .clear();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Uom',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: _formControllers.uomController,
                      decoration: InputDecoration(
                        hintText: 'Uom',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Quantity',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: _formControllers.quantityController,
                      decoration: InputDecoration(
                        hintText: provider.selectedItemQuantity != null
                            ? _formControllers.quantityController.text =
                                provider.selectedItemQuantity!
                            : "0",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'P.Price',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: _formControllers.priceRateController,
                      decoration: InputDecoration(
                        hintText: provider.selectedItemPurchasePrice != null
                            ? _formControllers.priceRateController.text =
                                provider.selectedItemPurchasePrice!
                            : "0",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'S.Rate',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: _formControllers.saleRateController,
                      decoration: InputDecoration(
                        hintText: provider.selectedItemSalePrice != null
                            ? _formControllers.saleRateController.text =
                                provider.selectedItemSalePrice!
                            : "0",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Discount',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: _formControllers.discountController,
                      decoration: InputDecoration(
                        hintText: 'Discount',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    Text(
                      'Amount',
                      style: TextStyle(fontSize: 16.0, color: hoverColor),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      cursorColor: hoverColor,
                      controller: _formControllers.totalController,
                      decoration: InputDecoration(
                        hintText: 'T.Amount',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: hoverColor),
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class FormControllers {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceRateController = TextEditingController();
  TextEditingController saleRateController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController totalController = TextEditingController();
}

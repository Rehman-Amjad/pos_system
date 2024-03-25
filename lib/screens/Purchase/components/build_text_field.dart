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

TextEditingController uomController = TextEditingController();
TextEditingController itemController = TextEditingController();
TextEditingController quantityController = TextEditingController();
TextEditingController priceRateController = TextEditingController();
TextEditingController saleRateController = TextEditingController();
TextEditingController discountController = TextEditingController();
TextEditingController totalController = TextEditingController();

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  ('ignore me :(').toString(),
                  style: TextStyle(color: hoverColor),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text('Item Code: '),
                ),
                Consumer<ItemsDataProvider>(
                  builder: (context, values, child) {
                    return Text(
                      values.selectedItemNameId.toString(),
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
          ),
        ),
        SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
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
                                          provider.itemPurchasePrice[itemIndex];
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    height: 57.0,
                                    width: 400.0,
                                  ),
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200.0,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40.0,
                                  ),
                                  dropdownSearchData: DropdownSearchData(
                                    searchController: itemController,
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
                                        controller: itemController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 8.0,
                                          ),
                                          hintText: 'Search for Item Name...',
                                          hintStyle:
                                              const TextStyle(fontSize: 12.0),
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
                                  //This to clear the search value when you close the menu
                                  onMenuStateChange: (isOpen) {
                                    if (!isOpen) {
                                      itemController.clear();
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextFormField(
                  cursorColor: hoverColor,
                  controller: uomController,
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextFormField(
                  cursorColor: hoverColor,
                  controller: quantityController,
                  decoration: InputDecoration(
                    hintText: provider.selectedItemQuantity != null
                        ? quantityController.text =
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextFormField(
                  cursorColor: hoverColor,
                  controller: priceRateController,
                  decoration: InputDecoration(
                    hintText: provider.selectedItemPurchasePrice != null
                        ? priceRateController.text =
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextFormField(
                  cursorColor: hoverColor,
                  controller: saleRateController,
                  decoration: InputDecoration(
                    hintText: provider.selectedItemSalePrice != null
                        ? saleRateController.text =
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextFormField(
                  cursorColor: hoverColor,
                  controller: discountController,
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextFormField(
                  cursorColor: hoverColor,
                  controller: totalController,
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
              ),
            ),
            Container(
              height: 36.0,
              decoration: BoxDecoration(
                color: hoverColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Consumer<FormBuilderProvider>(
                  builder: (context, value, child) {
                    return IconButton(
                      icon: Icon(Icons.delete, color: Colors.white, size: 18),
                      onPressed: () {
                        value.removeItem(widget.index);
                      },
                    );
                  },
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

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/controllers/cash_dropdown.dart';
import 'package:pos_system/screens/Purchase/components/purchase_form.dart';
import 'package:provider/provider.dart';

import '../provider/items_data_fetch_provider.dart';

class SalesManDropdown extends StatefulWidget {
  const SalesManDropdown({Key? key}) : super(key: key);

  @override
  _SalesManDropdownState createState() => _SalesManDropdownState();
}

class _SalesManDropdownState extends State<SalesManDropdown> {
  late TextEditingController _salesManController;

  @override
  void initState() {
    super.initState();
    _salesManController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ItemsDataProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select SalesMan',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: dataProvider.salesMan
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
              value: dataProvider.selectedSalesMan,
              onChanged: (value) {
                setState(() {
                  dataProvider.selectedSalesMan = value;
                  SaleAllController.saleSalesMan = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 57.0,
                width: 900.0,
              ),
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200.0,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40.0,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: _salesManController,
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
                    controller: _salesManController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 8.0,
                      ),
                      hintText: 'Search for SalesMan...',
                      hintStyle: const TextStyle(fontSize: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().contains(searchValue);
                },
              ),
              //This to clear the search value when you close the menu
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  _salesManController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _salesManController.dispose();
    super.dispose();
  }
}

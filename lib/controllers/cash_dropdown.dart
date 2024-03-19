import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/provider/items_data_fetch_provider.dart';
import 'package:provider/provider.dart';

class CashDropdown extends StatefulWidget {
  const CashDropdown({super.key});

  @override
  State<CashDropdown> createState() => _CashDropdownState();
}

class _CashDropdownState extends State<CashDropdown> {
  late TextEditingController _cashController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cashController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select Payment Method',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: provider.cashMethods
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
              value: provider.selectCashMethod,
              onChanged: (value) {
                setState(() {
                  provider.selectCashMethod = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: 57.0,
                width: 800.0,
              ),
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 200.0,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40.0,
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: _cashController,
                searchInnerWidgetHeight: 50.0,
                searchInnerWidget: Container(
                  height: 57.0,
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 4.0,
                    right: 8.0,
                    left: 8.0,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Expanded(
                      child: TextFormField(
                        expands: true,
                        maxLines: null,
                        controller: _cashController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          hintText: 'Search for Payment...',
                          hintStyle: const TextStyle(fontSize: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
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
                  _cashController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

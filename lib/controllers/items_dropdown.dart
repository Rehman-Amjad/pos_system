import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/provider/items_data_fetch_provider.dart';
import 'package:provider/provider.dart';

class ItemDropDown extends StatefulWidget {
  const ItemDropDown({super.key});

  @override
  State<ItemDropDown> createState() => _ItemDropDownState();
}

class _ItemDropDownState extends State<ItemDropDown> {
  late TextEditingController _itemController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _itemController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                'Select item Name',
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
                  int index = provider.itemName.indexOf(value!);
                  provider.selectedItemNameId = provider.itemsID[index];
                  print("Value Index : $index");
                  print("Selected Item: ${provider.selectedItemName}");
                  print("Selected Item ID: ${provider.selectedItemNameId}");
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
                searchController: _itemController,
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
                        controller: _itemController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          hintText: 'Search for Item...',
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
                  _itemController.clear();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }
}

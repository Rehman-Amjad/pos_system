import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/provider/items_data_fetch_provider.dart';
import 'package:provider/provider.dart';

class VendorDropDown extends StatefulWidget {
  final List<String> vendors;
  const VendorDropDown({super.key, required this.vendors});

  @override
  State<VendorDropDown> createState() => _VendorDropDownState();
}

class _VendorDropDownState extends State<VendorDropDown> {
  late TextEditingController _vendorController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vendorController = TextEditingController();
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
                'Select Vendor Name',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: provider.vendor
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
              value: provider.selectedVendor,
              onChanged: (value) {
                setState(() {
                  provider.selectedVendor = value;
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
                searchController: _vendorController,
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
                        controller: _vendorController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          hintText: 'Search for vendor...',
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
                  _vendorController.clear();
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
    _vendorController.dispose();
    super.dispose();
  }
}

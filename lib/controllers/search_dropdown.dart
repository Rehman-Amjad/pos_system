
import 'package:flutter/material.dart';

class SearchableDropdown extends StatefulWidget {
  final List<String> items;

  const SearchableDropdown({Key? key, required this.items}) : super(key: key);

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  String? _selectedItem;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _selectedItem,
          items: _buildDropdownItems(),
          onChanged: (value) {
            setState(() {
              _selectedItem = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Select Item',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String item in widget.items) {
      if (_searchController.text.isEmpty ||
          item.toLowerCase().contains(_searchController.text.toLowerCase())) {
        dropdownItems.add(
          DropdownMenuItem(
            value: item,
            child: Text(item),
          ),
        );
      }
    }
    return dropdownItems;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
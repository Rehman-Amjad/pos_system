import 'package:flutter/material.dart';
import 'package:pos_system/screens/Purchase/Provider/formbuilder_firebase_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../controllers/items_dropdown.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../responsive.dart';

class BuildTextField extends StatelessWidget {
  final int index;

  BuildTextField({
    super.key,
    this.index = 0,
  });

  final _uomController = TextEditingController();
  final _qController = TextEditingController();
  final _prateController = TextEditingController();
  final _saleRateController = TextEditingController();
  final _dController = TextEditingController();
  final _tController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  (index + 1).toString(),
                  style: TextStyle(color: hoverColor),
                ),
                Spacer(),
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
                      borderRadius: BorderRadius.circular(5)),
                  child: Consumer<ItemsDataProvider>(
                    builder: (context, value, child) {
                      if (value.itemName.isEmpty) {
                        value.fetchItemName();
                        return const Center(
                            child: CircularProgressIndicator(
                          color: hoverColor,
                        ));
                      } else {
                        return ItemDropDown();
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
                  controller: _uomController,
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
                  controller: _qController,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
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
                  controller: _prateController,
                  decoration: InputDecoration(
                    hintText: 'P.Rate',
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
                  controller: _saleRateController,
                  decoration: InputDecoration(
                    hintText: 'S.Rate',
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
                  controller: _dController,
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
                  controller: _tController,
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
                        value.deleteFormBuilder(index);
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

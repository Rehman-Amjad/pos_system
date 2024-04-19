import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../provider/items_data_fetch_provider.dart';

class BuildTextFieldHeadMobile extends StatelessWidget {
  final formControllers;
  const BuildTextFieldHeadMobile({super.key, required this.formControllers});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              child: Text('Stock: '),
            ),
            Consumer<ItemsDataProvider>(
              builder: (context, value, child) {
                return Text(
                  value.selectedItemStock.toString(),
                  style: TextStyle(color: hoverColor),
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text('Total Stock: '),
            ),
            Expanded(
              child: TextFormField(
                cursorColor: hoverColor,
                controller: formControllers.plusStockController,
                decoration: InputDecoration(
                  hintText: formControllers.stockController.text.isNotEmpty
                      ? formControllers.plusStockController.text
                      : '0',
                  hintStyle: TextStyle(fontSize: 12, color: hoverColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text('Uom: '),
            ),
            Consumer<ItemsDataProvider>(
              builder: (context, value, child) {
                return Text(
                  value.selectedUom.toString(),
                  style: TextStyle(color: hoverColor),
                );
              },
            ),
            SizedBox(
              width: 10.0,
            ),
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
      ],
    );
  }
}

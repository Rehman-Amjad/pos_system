import 'package:flutter/material.dart';
import 'package:pos_system/constants.dart';
import 'package:pos_system/controllers/MenuAppController.dart';
import 'package:pos_system/helper/text_helper.dart';
import 'package:pos_system/screens/dashboard/components/header.dart';
import 'package:provider/provider.dart';

import 'components/purchase_form.dart';

class AddPurchaseScreen extends StatelessWidget {
  const AddPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: defaultDrawerHeadHeight + 20.0),
              TextHelper().mNormalText(
                  text: 'Purchase', color: Colors.white, size: 18.0),
              SizedBox(height: defaultDrawerHeadHeight - 10),
              TextHelper().mNormalText(
                  text: "Add New Purchase", color: Colors.white70, size: 14.0),
              SizedBox(height: defaultDrawerHeadHeight + 20.0),
              PurchaseForm(
                joinDate:
                    provider.parameters?[Constant.KEY_VENDORMAN_JOIN_DATE] ??
                        '',
                // serialNum: serialNum,
                // itemCode: itemCode,
                // itemName: itemName,
                // vendorName: vendorName,
                // uom: uom,
                // quantity: quantity,
                // purchasePrice: purchasePrice,
                // salePrice: salePrice,
                // totalAmount: totalAmount,
                // discount: discount,
                // discountAmount: discountAmount,
                // payableAmount: payableAmount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

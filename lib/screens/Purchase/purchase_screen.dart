import 'package:flutter/material.dart';
import 'package:pos_system/constants.dart';
import 'package:pos_system/controllers/MenuAppController.dart';
import 'package:pos_system/helper/custom_shadow_button.dart';
import 'package:pos_system/helper/text_helper.dart';
import 'package:pos_system/responsive.dart';
import 'package:pos_system/route/routes.dart';
import 'package:pos_system/screens/Purchase/Provider/purcahse_list.dart';
import 'package:pos_system/screens/dashboard/components/header.dart';
import 'package:provider/provider.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MenuAppController>(context, listen: false);
    return SingleChildScrollView(
      primary: false,
      child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultDrawerHeadHeight + 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper().mNormalText(
                  text: "Purchase List",
                  color: Colors.white,
                  size: Responsive.isMobile(context) ? 14.0 : 18.0,
                ),
                // CustomNeumorphicButton(
                //   press: () {
                //     provider.parameters?.clear();
                //     provider.changeScreen(Routes.ADD_PURCHASE);
                //   },
                //   width: Responsive.isMobile(context) ? 150.0 : 200.0,
                //   height: 50.0,
                //   label: "Add New",
                //   isIcon: false,
                // ),
              ],
            ),
            SizedBox(height: defaultDrawerHeadHeight + 20.0),
            PurchaseList(),
          ],
        ),
      ),
    );
  }
}

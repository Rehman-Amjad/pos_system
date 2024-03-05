import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/screens/saleman/components/salesman_list.dart';
import 'package:pos_system/screens/supplyman/components/supplyman_list.dart';
import 'package:pos_system/screens/vendorman/components/vendorman_list.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controllers/MenuAppController.dart';
import '../../helper/custom_shadow_button.dart';
import '../../helper/text_helper.dart';
import '../../responsive.dart';
import '../../route/routes.dart';
import '../dashboard/components/header.dart';

class VendorManScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider  =  Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
          const  Header(),
          const  SizedBox(height: defaultDrawerHeadHeight + 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextHelper().mNormalText(text: "Vendor List",color: Colors.white,
                    size: Responsive.isMobile(context) ? 14.0 : 18.0),
                CustomNeumorphicButton(
                  width: Responsive.isMobile(context) ? 150.0: 200.0,
                  height: 50.0,
                  isIcon: false,
                  label: 'Add New',
                  press: (){
                   provider.parameters?.clear();
                   provider.changeScreen(Routes.ADD_VENDOR);
                  },),
                // ButtonWidget(text: "Add New", width: 120, height: 50,backgroundColor: hoverColor,icons: true,
                //     onClicked: (){
                //       Provider.of<MenuAppController>(context, listen: false)
                //           .changeScreen(Routes.ADD_CATEGORY_ROUTE);
                //     }
                // )
              ],
            ),
           const SizedBox(height: defaultDrawerHeadHeight + 20.0),
           const VendorManList()
          ],
        ),
      ),
    );
  }
}

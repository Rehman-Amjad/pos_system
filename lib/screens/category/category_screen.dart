import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/helper/button_widget.dart';
import 'package:pos_system/helper/my_button.dart';
import 'package:pos_system/route/routes.dart';
import 'package:pos_system/screens/category/components/category_list.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controllers/MenuAppController.dart';
import '../../helper/custom_shadow_button.dart';
import '../../helper/text_helper.dart';
import '../dashboard/components/header.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultDrawerHeadHeight + 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextHelper().mNormalText(text: "Items Category list",color: Colors.white,size: 18),
                  CustomNeumorphicButton(
                    width: 200,
                    height: 50,
                    isIcon: false,
                    label: 'Add New',
                    press: (){
                      Provider.of<MenuAppController>(context, listen: false)
                                .changeScreen(Routes.ADD_CATEGORY_ROUTE);
                    },),
                  // ButtonWidget(text: "Add New", width: 120, height: 50,backgroundColor: hoverColor,icons: true,
                  //     onClicked: (){
                  //       Provider.of<MenuAppController>(context, listen: false)
                  //           .changeScreen(Routes.ADD_CATEGORY_ROUTE);
                  //     }
                  // )
                ],
              ),
              SizedBox(height: defaultDrawerHeadHeight + 20),
              CategoryList()




            ],
          ),
        )
    );
  }
}

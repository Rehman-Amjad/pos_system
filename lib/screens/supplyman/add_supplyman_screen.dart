import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/screens/saleman/components/saleman_form.dart';
import 'package:pos_system/screens/supplyman/components/supplyman_form.dart';

import '../../constants.dart';
import '../../helper/text_helper.dart';
import '../dashboard/components/header.dart';

class AddSupplyManScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: defaultDrawerHeadHeight + 20),
              TextHelper().mNormalText(text: "Supply Man",color: Colors.white,size: 18),
              SizedBox(height: defaultDrawerHeadHeight-10),
              TextHelper().mNormalText(text: "Add new Supply Man",color: Colors.white70,size: 14),
              SizedBox(height: defaultDrawerHeadHeight + 20),
              SupplyManForm()
            ],
          ),
        )
    );
  }
}

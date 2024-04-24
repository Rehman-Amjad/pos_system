import 'package:flutter/material.dart';
import 'package:pos_system/constants.dart';
import 'package:pos_system/helper/text_helper.dart';
import 'package:pos_system/screens/Sales/component/sales_form.dart';
import 'package:pos_system/screens/dashboard/components/header.dart';

class AddSalesScreen extends StatelessWidget {
  const AddSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              TextHelper()
                  .mNormalText(text: 'Sales', color: Colors.white, size: 18.0),
              SizedBox(height: defaultDrawerHeadHeight - 10),
              TextHelper().mNormalText(
                  text: "Add New Sales", color: Colors.white70, size: 14.0),
              SizedBox(height: defaultDrawerHeadHeight + 20.0),
              SalesForm(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/screens/dashboard/components/header.dart';

import '../../constants.dart';
import '../../helper/text_helper.dart';
import 'components/category_form.dart';

class AddCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            SizedBox(height: defaultDrawerHeadHeight + 20),
            TextHelper().mNormalText(text: "Items Category",color: Colors.white,size: 18),
            SizedBox(height: defaultDrawerHeadHeight-10),
            TextHelper().mNormalText(text: "Create new item Category",color: Colors.white70,size: 14),
            SizedBox(height: defaultDrawerHeadHeight + 20),
            CategoryForm()
          ],
        ),
      ),
      )
    );
  }
}

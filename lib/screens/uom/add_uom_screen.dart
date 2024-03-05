import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/screens/dashboard/components/header.dart';
import 'package:pos_system/screens/uom/components/uom_form.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../controllers/MenuAppController.dart';
import '../../helper/text_helper.dart';

class AddUOMScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider =   Provider.of<MenuAppController>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(height: defaultDrawerHeadHeight + 20),
            TextHelper().mNormalText(text: "UOM",color: Colors.white,size: 18.0),
            const SizedBox(height: defaultDrawerHeadHeight-10),
            TextHelper().mNormalText(text: "Create new UOM",color: Colors.white70,size: 14.0),
            const SizedBox(height: defaultDrawerHeadHeight + 20),
            UOMForm(
              edit: provider.parameters?['edit'] ?? 'false',
              code: provider.parameters?[Constant.KEY_CATEGORY_ID] ?? "no code",
              name: provider.parameters?[Constant.KEY_CATEGORY_NAME] ?? 'Enter UOM Name',
              desc: provider.parameters?[Constant.KEY_CATEGORY_DESC] ?? 'Enter Description',
            )
          ],
        ),
      ),
      )
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pos_system/helper/button_widget.dart';
import 'package:pos_system/responsive.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controllers/MenuAppController.dart';
import '../../../helper/custom_shadow_button.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/text_helper.dart';
import '../../../provider/count_value_provider.dart';
import '../../../route/routes.dart';

class CategoryForm extends StatefulWidget {

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  var categoryNameController = TextEditingController();

  var categoryDescriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<CountValueProvider>(context, listen: false)
    //     .fetchCountValue();
    Provider.of<CountValueProvider>(context, listen: false).fetchCountValue();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final countProvider = Provider.of<CountValueProvider>(context, listen: false);
    return Container(
      width: size.width,
      padding: EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextHelper().mNormalText(text: "Category Code: ",color: Colors.white,size: 14),
              Consumer<CountValueProvider>(
                builder: (context, countValue, child) {
                  return TextHelper().mNormalText(text: countValue.countValue.toString(),color: hoverColor,size: 16);
                },
              ),
            ],
          ),
          SizedBox(height: 15,),
          TextHelper().mNormalText(text: "Category Name",color: Colors.white,size: 14),
          SizedBox(height: 15,),
          Container(
              width: Responsive.isMobile(context) ?  size.width: size.width / 1.9 ,
              child: CustomTextField(
                controller: categoryNameController,
                hintText: 'Enter Category Name',)),
          SizedBox(height: 20,),
          TextHelper().mNormalText(text: "Category Description",color: Colors.white,size: 14),
          const SizedBox(height: 15,),
          Container(
              width: Responsive.isMobile(context) ?  size.width: size.width / 1.9 ,
              child: CustomTextField(
                controller: categoryDescriptionController,
                hintText: 'Description',)),

          SizedBox(height: 20,),
          Row(
            children: [
              ButtonWidget(
                text: "Save", onClicked: () {

                  if(categoryNameController.text.isNotEmpty && categoryDescriptionController.text.isNotEmpty){
                    countProvider.fetchCountValue();
                    int newCountValue = countProvider.countValue;
                    countProvider.uploadCategory(count: newCountValue,
                        name: categoryNameController.text.toString(),
                      description: categoryDescriptionController.text.toString()
                    );
                    countProvider.updateCountValue(count: newCountValue+1);
                    countProvider.fetchCountValue();
                    categoryNameController.text = "";
                    categoryDescriptionController.text = "";
                    Get.snackbar("New Category Added", "",backgroundColor: hoverColor,colorText: Colors.white);
                  }else{
                    Get.snackbar("Alert!!!", "Please filled missing fields",backgroundColor: Colors.red,colorText: Colors.white);
                  }


              }, icons: false, width: 100, height: 50,
              ),
              const SizedBox(width: 20,),
              ButtonWidget(
                text: "Cancel", onClicked: () {
                Provider.of<MenuAppController>(context, listen: false)
                    .changeScreen(Routes.CATEGORY_ROUTE);
              }, icons: false, width: 100, height: 50,backgroundColor: Colors.grey,
              ),
            ],
          ),
        ],
      )
    );
  }
}

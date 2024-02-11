import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/helper/text_helper.dart';
import 'package:pos_system/helper/text_widget.dart';
import 'package:pos_system/provider/count_value_provider.dart';
import 'package:pos_system/responsive.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../dashboard/components/header.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(3),
                4: FlexColumnWidth(3),
              },
              children: const [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextWidget(text: "Code", color: hoverColor,
                        size: 14, isBold: true,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextWidget(text: "Name", color: hoverColor,
                        size: 14, isBold: true,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextWidget(text: "Description", color: hoverColor,
                        size: 14, isBold: true,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextWidget(text: "Created By", color: hoverColor,
                        size: 14, isBold: true,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: TextWidget(text: "Action", color: hoverColor,
                          size: 14, isBold: true,),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          StreamBuilder(
            stream: firestore.collection(Constant.COLLECTION_CATEGORY)
                .orderBy("timeStamp",descending: false)
                .snapshots(),
            builder: (context, snapshot){
              return (snapshot.connectionState == ConnectionState.waiting) ?
              const Center(
                child: CircularProgressIndicator(color: hoverColor,),
              ) : snapshot.data!.docs.isEmpty ?
              Center(child: Text("No Category Found",style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 12 : 18,fontWeight: FontWeight.bold
              ),)
                ,) : ListView.separated(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: PageScrollPhysics(),
                itemBuilder: (context,index){
                  var category = snapshot.data!.docs[index].data();
                    return Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(3),
                        3: FlexColumnWidth(3),
                        4: FlexColumnWidth(3),
                      },
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 5.0,bottom: 5.0,top: 5.0),
                              child: TextWidget(text: category[Constant.KEY_CATEGORY_ID].toString(), color: Colors.white,
                                size: 14, isBold: false,),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.only(left: 12,top: 5),
                                  decoration: BoxDecoration(
                                      color: hoverColor,
                                      borderRadius: BorderRadius.circular(3)
                                  ),
                                  child: Center(child: Icon(Icons.category)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                  child: TextWidget(text: category[Constant.KEY_CATEGORY_NAME], color: Colors.white,
                                    size: 14, isBold: false,),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 5.0,bottom: 5.0,top: 5.0),
                              child: TextWidget(text: category[Constant.KEY_CATEGORY_DESC], color: Colors.white,
                                size: 14, isBold: false,),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15,right: 5.0,bottom: 5.0,top: 5.0),
                              child: TextWidget(text: "admin", color: Colors.white,
                                size: 14, isBold: false,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 5.0,bottom: 5.0,top: 5.0),
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit,color: hoverColor,size: Responsive.isMobile(context) ? 24 : 30,),
                                      const SizedBox(width: 5,),
                                      GestureDetector(
                                          onTap: (){
                                            Provider.of<CountValueProvider>(context, listen: false).deleteCategory(id: category[Constant.KEY_CATEGORY_ID]);
                                          },
                                          child: Icon(Icons.delete,color: Colors.red,size: Responsive.isMobile(context) ? 24 : 30,)),
                                    ],)
                              ),
                            ),
                          ],
                        )
                      ],
                    );


                },
                separatorBuilder: (context,index){
                  return const Divider(color: Colors.white70,);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}


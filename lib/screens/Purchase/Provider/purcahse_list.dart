import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_system/controllers/MenuAppController.dart';
import 'package:pos_system/helper/text_widget.dart';
import 'package:pos_system/responsive.dart';
import 'package:pos_system/screens/items_registrations/provider/register_firebase_provider.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../route/routes.dart';

class PurchaseList extends StatelessWidget {
  const PurchaseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        StreamBuilder(
          stream: firestore
              .collection('purchase')
              .orderBy(Constant.KEY_PURCHASE_TIMESTAMP, descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: hoverColor,
                    ),
                  )
                : snapshot.data!.docs.isEmpty
                    ? Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: secondaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "No Purchase Found",
                            style: TextStyle(
                                fontSize:
                                    Responsive.isMobile(context) ? 12 : 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: PaginatedDataTable(
                            header: TextWidget(
                              text:
                                  "Total Purchases: ${snapshot.data!.docs.length}",
                              size: 20,
                              color: Colors.white,
                              isBold: false,
                            ),
                            headingRowColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return hoverColor; // Default color
                              },
                            ),
                            columnSpacing: 20.0,
                            arrowHeadColor: Colors.white,
                            rowsPerPage: snapshot.data!.docs.length > 10
                                ? 10
                                : snapshot.data!.docs.length,
                            columns: const [
                              DataColumn(
                                label: TextWidget(
                                  text: "Code",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Name",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Category",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "UOM",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Stock",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Quantity",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Purchase Price",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Sale Price",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Joining Date",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Status",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                              DataColumn(
                                label: TextWidget(
                                  text: "Action",
                                  color: Colors.black,
                                  size: 14,
                                  isBold: true,
                                ),
                              ),
                            ],
                            source: DataTableSourceImpl(
                                items: snapshot.data!.docs,
                                length: snapshot.data!.docs.length,
                                context: context)),
                      );
          },
        ),
      ],
    );
  }
}

class DataTableSourceImpl extends DataTableSource {
  final items;
  final length;
  final context;

  DataTableSourceImpl(
      {required this.items, required this.length, required this.context});

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      color: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return bgColor; // Default color
        },
      ),
      cells: [
        DataCell(
          TextWidget(
            text: '',
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(Row(
          children: [
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(left: 2.0, top: 5.0, bottom: 10.0),
              decoration: BoxDecoration(
                  color: hoverColor, borderRadius: BorderRadius.circular(3)),
              child: const Center(child: Icon(Icons.shopping_basket)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 5.0, bottom: 5.0, top: 5.0),
              child: TextWidget(
                text: '',
                color: Colors.white,
                size: 14.0,
                isBold: false,
              ),
            ),
          ],
        )),
        DataCell(
          TextWidget(
            text: '',
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: '',
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: '',
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: '',
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: '',
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: '',
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: '',
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: '',
            color: Colors.white,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  // Provider.of<MenuAppController>(context, listen: false)
                  //     .changeScreenWithParams(Routes.ADD_ITEMS_REGISTRATION,
                  //         parameters: {
                  //       'edit': 'true',
                  //       Constant.KEY_ITEM_CODE.toString():
                  //           items[index][Constant.KEY_ITEM_CODE].toString(),
                  //       Constant.KEY_ITEM_NAME.toString():
                  //           items[index][Constant.KEY_ITEM_NAME].toString(),
                  //       Constant.KEY_ITEM_CATEGORY.toString():
                  //           items[index][Constant.KEY_ITEM_CATEGORY].toString(),
                  //       Constant.KEY_ITEM_STOCK.toString():
                  //           items[index][Constant.KEY_ITEM_STOCK].toString(),
                  //       Constant.KEY_ITEM_UOM.toString():
                  //           items[index][Constant.KEY_ITEM_UOM].toString(),
                  //       Constant.KEY_ITEM_QUANTITY.toString():
                  //           items[index][Constant.KEY_ITEM_QUANTITY].toString(),
                  //       Constant.KEY_ITEM_PURCHASE_PRICE.toString():
                  //           items[index][Constant.KEY_ITEM_PURCHASE_PRICE]
                  //               .toString(),
                  //       Constant.KEY_ITEM_SALE_PRICE.toString(): items[index]
                  //               [Constant.KEY_ITEM_SALE_PRICE]
                  //           .toString(),
                  //       Constant.KEY_ITEM_JOIN_DATE.toString(): items[index]
                  //               [Constant.KEY_ITEM_JOIN_DATE]
                  //           .toString(),
                  //       Constant.KEY_STATUS.toString():
                  //           items[index][Constant.KEY_STATUS].toString(),
                  //     });
                },
                child: Icon(
                  Icons.edit,
                  color: hoverColor,
                  size: Responsive.isMobile(context) ? 24.0 : 30.0,
                )),
            const SizedBox(
              width: 5.0,
            ),
            GestureDetector(
                onTap: () {
                  // Provider.of<RegisterFirebaseProvider>(context, listen: false)
                  //     .deleteRegistrationData(
                  //         id: items[index][Constant.KEY_ITEM_CODE].toString(),
                  //         collection: Constant.COLLECTION_ITEMS);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: Responsive.isMobile(context) ? 24.0 : 30.0,
                )),
          ],
        )),
      ],
    );
  }

  @override
  int get rowCount => length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

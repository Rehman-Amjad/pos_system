import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/helper/button_widget.dart';
import 'package:pos_system/helper/custom_dropdown.dart';
import 'package:pos_system/helper/text_widget.dart';
import 'package:pos_system/provider/items_data_fetch_provider.dart';
import 'package:pos_system/screens/items_registrations/provider/register_firebase_provider.dart';
import 'package:pos_system/responsive.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../controllers/MenuAppController.dart';
import '../../../controllers/search_dropdown.dart';
import '../../../helper/custom_textfield.dart';
import '../../../helper/text_helper.dart';
import '../../../provider/count_value_provider.dart';
import '../../../route/routes.dart';

class ItemsRegistrationForm extends StatefulWidget {
  final String code,
      name,
      category,
      uom,
      stock,
      quantity,
      status,
      joinDate,
      purchasePrice,
      salePrice;
  final String edit;
  String joiningDate = "Select Purchase Date";

  ItemsRegistrationForm({
    super.key,
    required this.edit,
    required this.code,
    required this.name,
    required this.category,
    required this.uom,
    required this.stock,
    required this.quantity,
    required this.purchasePrice,
    required this.salePrice,
    this.joinDate = "select Join date",
    required this.status,
  }) {
    joiningDate = joinDate;
  }

  @override
  State<ItemsRegistrationForm> createState() => _ItemsRegistrationFormState();
}

class _ItemsRegistrationFormState extends State<ItemsRegistrationForm> {
  _ItemsRegistrationFormState() {
    selectedStatus = statusList[0];
  }
  var nameController = TextEditingController();
  var stockController = TextEditingController();
  var quantityController = TextEditingController();
  var purchasePriceController = TextEditingController();
  var salePriceController = TextEditingController();
  var lowStockController = TextEditingController();

  String selectedStatus = "";
  var statusList = ['Running', 'Close'];
  String joinDate = "select Joining date";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CountValueProvider>(context, listen: false).fetchCountValue();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final countProvider =
        Provider.of<CountValueProvider>(context, listen: false);
    final dataProvider = Provider.of<ItemsDataProvider>(context, listen: false);
    final registerProvider =
        Provider.of<RegisterFirebaseProvider>(context, listen: false);
    return Container(
        width: size.width,
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextHelper().mNormalText(
                    text: "Items Code: ", color: Colors.white, size: 14.0),
                Consumer<CountValueProvider>(
                  builder: (context, countValue, child) {
                    return TextHelper().mNormalText(
                        text: widget.edit == 'true'
                            ? widget.code
                            : countValue.countValue.toString(),
                        color: hoverColor,
                        size: 16.0);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            TextHelper().mNormalText(
                text: "Items Name", color: Colors.white, size: 14.0),
            SizedBox(
              height: 15.0,
            ),
            Container(
                width: Responsive.isMobile(context)
                    ? size.width
                    : size.width / 1.9,
                child: CustomizeTextField(
                  controller: nameController,
                  hintText: widget.edit == 'true'
                      ? nameController.text = widget.name
                      : widget.name,
                )),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 1.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHelper().mNormalText(
                              text: "Items Category",
                              color: Colors.white,
                              size: 14.0),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            width: Responsive.isMobile(context)
                                ? size.width
                                : size.width / 2.9,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(5)),
                            child: Consumer<ItemsDataProvider>(
                              builder: (context, value, child) {
                                if (value.category.isEmpty) {
                                  value.fetchCategory();
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: secondaryColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "No Items Found",
                                        style: TextStyle(
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 12
                                                    : 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SearchableDropdown();
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextHelper().mNormalText(
                            text: "Items UOM", color: Colors.white, size: 14.0),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          width: Responsive.isMobile(context)
                              ? size.width
                              : size.width / 2.9,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          child: Consumer<ItemsDataProvider>(
                            builder: (context, dataProvider, _) {
                              if (dataProvider.uom.isEmpty) {
                                dataProvider.fetchUom();
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: secondaryColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "No Items Found",
                                      style: TextStyle(
                                          fontSize: Responsive.isMobile(context)
                                              ? 12
                                              : 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              } else {
                                return CustomDropDownList(
                                  items: dataProvider.uom,
                                  selectedItem: dataProvider.selectedUom,
                                  onChanged: (newValue) {
                                    dataProvider.setSelectedUom(newValue!);
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 1.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHelper().mNormalText(
                              text: "Items Stock",
                              color: Colors.white,
                              size: 14.0),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              width: Responsive.isMobile(context)
                                  ? size.width
                                  : size.width / 1.9,
                              child: CustomizeTextField(
                                controller: stockController,
                                hintText: widget.edit == 'true'
                                    ? widget.stock
                                    : "Enter Stock",
                              )),
                        ],
                      )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHelper().mNormalText(
                              text: "Items Quantity",
                              color: Colors.white,
                              size: 14.0),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              width: Responsive.isMobile(context)
                                  ? size.width
                                  : size.width / 1.9,
                              child: CustomizeTextField(
                                controller: quantityController,
                                hintText: widget.edit == 'true'
                                    ? quantityController.text = widget.quantity
                                    : widget.quantity,
                              )),
                        ],
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 1.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHelper().mNormalText(
                              text: "Purchase Price",
                              color: Colors.white,
                              size: 14.0),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              width: Responsive.isMobile(context)
                                  ? size.width
                                  : size.width / 1.9,
                              child: CustomizeTextField(
                                controller: purchasePriceController,
                                hintText: widget.edit == 'true'
                                    ? purchasePriceController.text =
                                        widget.purchasePrice
                                    : widget.purchasePrice,
                              )),
                        ],
                      )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextHelper().mNormalText(
                              text: "Sale Price",
                              color: Colors.white,
                              size: 14.0),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              width: Responsive.isMobile(context)
                                  ? size.width
                                  : size.width / 1.9,
                              child: CustomizeTextField(
                                controller: salePriceController,
                                hintText: widget.edit == 'true'
                                    ? salePriceController.text =
                                        widget.salePrice
                                    : widget.salePrice,
                              )),
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextHelper()
                .mNormalText(text: "Date", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            GestureDetector(
              onTap: () => _showDatePicker(),
              child: Container(
                width: Responsive.isMobile(context)
                    ? size.width
                    : size.width / 2.9,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
                  child: TextWidget(
                    text: widget.joiningDate,
                    color: Colors.white,
                    size: 14.0,
                    isBold: false,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextHelper().mNormalText(
                text: "Select Status", color: Colors.white, size: 14.0),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              width:
                  Responsive.isMobile(context) ? size.width : size.width / 2.9,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 5.0, top: 5.0, bottom: 5.0),
                child: DropdownButtonFormField(
                  value: selectedStatus,
                  items: statusList
                      .map((e) => DropdownMenuItem(
                            child: TextWidget(
                              text: e,
                              color: Colors.white,
                              size: 12.0,
                              isBold: false,
                            ),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value as String;
                    });
                    // selectedGroup = value as String;
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: hoverColor,
                  ),
                  dropdownColor: bgColor,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                widget.edit == 'true'
                    ? ButtonWidget(
                        text: "Update",
                        onClicked: () {
                          if (nameController.text.isNotEmpty &&
                              stockController.text.isNotEmpty) {
                            registerProvider.updateRegistrationData(
                              collection: Constant.COLLECTION_ITEMS,
                              count: widget.code,
                              joiningDate: widget.joiningDate.toString(),
                              name: nameController.text.toString(),
                              category: dataProvider.selectedCategory,
                              uom: dataProvider.selectedUom,
                              stock: stockController.text.toString(),
                              quantity: quantityController.text.toString(),
                              purchasePrice:
                                  purchasePriceController.text.toString(),
                              salePrice: salePriceController.text.toString(),
                              status: selectedStatus,
                            );
                            nameController.text = "";
                            stockController.text = "";
                            salePriceController.text = "";
                            purchasePriceController.text = "";
                            selectedStatus = "";
                            joinDate = "";
                            quantityController.text = "";
                            // dataProvider.updateSalesManData(
                            //     collection: Constant.COLLECTION_SALESMAN,
                            //     code: widget.code,
                            //     name: nameController.text.toString(),
                            //     phone: phoneController.text.toString(),
                            //     address: addressController.text.toString(),
                            //     joinDate: widget.joiningDate.toString(),
                            //     status: selectedStatus);
                            Get.snackbar("New Items Updated...", "",
                                backgroundColor: hoverColor,
                                colorText: Colors.white);
                          } else {
                            Get.snackbar(
                                "Alert!!!", "Please filled missing fields",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        icons: false,
                        width: 100.0,
                        height: 50.0,
                      )
                    : ButtonWidget(
                        text: "Save",
                        onClicked: () {
                          if (nameController.text.isNotEmpty &&
                              stockController.text.isNotEmpty) {
                            countProvider.fetchCountValue();
                            int newCountValue = countProvider.countValue;
                            // Check if stock is less than 50
                            if (int.parse(stockController.text) < 5) {
                              // If stock is less than 50, set its value to lowStockController
                              lowStockController.text = stockController.text;
                            }
                            registerProvider.uploadRegistrationData(
                              collection: Constant.COLLECTION_ITEMS,
                              count: newCountValue,
                              joiningDate: widget.joiningDate.toString(),
                              name: nameController.text.toString(),
                              category: dataProvider.selectedCategory,
                              uom: dataProvider.selectedUom,
                              stock: stockController.text.toString(),
                              quantity: quantityController.text.toString(),
                              purchasePrice:
                                  purchasePriceController.text.toString(),
                              salePrice: salePriceController.text.toString(),
                              status: selectedStatus,
                              lowStock: lowStockController.text.toString(),
                            );
                            // dataProvider.uploadPersonData(
                            //     collection: Constant.COLLECTION_SALESMAN,
                            //     count: newCountValue,
                            //     name: nameController.text.toString(),
                            //     phone: phoneController.text.toString(),
                            //     address: addressController.text.toString(),
                            //     joinDate: widget.joiningDate.toString(),
                            //     status: selectedStatus);

                            countProvider.updateCountValue(
                                count: newCountValue + 1);
                            countProvider.fetchCountValue();
                            nameController.text = "";
                            stockController.text = "";
                            salePriceController.text = "";
                            purchasePriceController.text = "";
                            selectedStatus = "";
                            joinDate = "";
                            quantityController.text = "";
                            Get.snackbar("New Items Added", "",
                                backgroundColor: hoverColor,
                                colorText: Colors.white);
                          } else {
                            Get.snackbar(
                                "Alert!!!", "Please filled missing fields",
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        icons: false,
                        width: 100.0,
                        height: 50.0,
                      ),
                const SizedBox(
                  width: 20.0,
                ),
                ButtonWidget(
                  text: "Cancel",
                  onClicked: () {
                    Provider.of<MenuAppController>(context, listen: false)
                        .changeScreen(Routes.ITEMS_REGISTRATION);
                  },
                  icons: false,
                  width: 100.0,
                  height: 50.0,
                  backgroundColor: Colors.grey,
                ),
              ],
            ),
          ],
        ));
  }

  void _showDatePicker() async {
    DateTime? picDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));

    setState(() {
      widget.joiningDate = DateFormat('dd-MM-yyyy').format(picDate!);
    });
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_system/screens/Purchase/Provider/formbuilder_firebase_provider.dart';
import 'package:pos_system/screens/Purchase/components/mobile_responsive_view/build_text_field_head_mobile.dart';
import 'package:pos_system/screens/Purchase/components/purchase_form.dart';
import 'package:pos_system/screens/Purchase/components/web_responsive_view/build_text_field_head_web.dart';
import 'package:pos_system/screens/Purchase/components/web_responsive_view/build_text_filed_items_web.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../provider/items_data_fetch_provider.dart';
import '../../../responsive.dart';

class BuildTextField extends StatefulWidget {
  final int index;
  BuildTextField({
    Key? key,
    required this.index,
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  late FormControllers _formControllers;

  MultiController multiController = MultiController();

  @override
  void initState() {
    super.initState();
    _formControllers = Provider.of<FormBuilderProvider>(context, listen: false)
        .controllers[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Responsive.isMobile(context)
            ? BuildTextFieldHeadMobile(formControllers: _formControllers)
            :
            // run web is on desktop or tablet mode
            BuildTextFieldHeadWeb(formControllers: _formControllers),
        SizedBox(height: 14.0),
        BuildTextFieldItemsWeb(
            formControllers: _formControllers, index: widget.index),
        SizedBox(height: 16),
      ],
    );
  }

  void updateTotal() {
    updateQuantity();
    updateAmount();
    updateTotalAmount();
    updatePlusStock();
  }

  void updateQuantity() {
    double quantity =
        double.tryParse(_formControllers.quantityController.text) ?? 0;
    _formControllers.quantityController.text = quantity.toString();
  }

  void updateAmount() {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    double priceRate =
        double.tryParse(provider.selectedItemPurchasePrice ?? '0') ?? 0;
    double quantity =
        double.tryParse(_formControllers.quantityController.text) ?? 0;
    double amount = priceRate * quantity;
    _formControllers.totalController.text = amount.toString();
  }

  void updateTotalAmount() {
    double discount =
        double.tryParse(_formControllers.discountController.text) ?? 0;
    double amount = double.tryParse(_formControllers.totalController.text) ?? 0;
    double totalAmount = amount - (amount * (discount / 100));
    _formControllers.totalAmountController.text = totalAmount.toString();
  }

  void updatePlusStock() {
    final provider = Provider.of<ItemsDataProvider>(context, listen: false);
    double stock = double.tryParse(provider.selectedItemStock.toString()) ?? 0;
    double quantity =
        double.tryParse(_formControllers.quantityController.text) ?? 0;
    double stockAddition = stock + quantity;
    _formControllers.plusStockController.text = stockAddition.toString();
  }

  void updateQuantityForIndex(index) {
    double quantity =
        double.tryParse(_formControllers.quantityController.text) ?? 0;
    if (index == widget.index) {
      _formControllers.quantityController.text = quantity.toString();
      updateAmount();
      updateTotalAmount();
      updatePlusStock();
    }
  }
}

class FormControllers {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceRateController = TextEditingController();
  TextEditingController saleRateController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController plusStockController = TextEditingController();
}

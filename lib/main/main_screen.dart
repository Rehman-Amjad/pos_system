
import 'package:flutter/material.dart';
import 'package:pos_system/route/routes.dart';
import 'package:pos_system/screens/category/add_category_screen.dart';
import 'package:pos_system/screens/customer/add_customer_screen.dart';
import 'package:pos_system/screens/items_registrations/components/items_registration_form.dart';
import 'package:pos_system/screens/saleman/saleman_screen.dart';
import 'package:pos_system/screens/supplyman/supplyman_screen.dart';
import 'package:pos_system/screens/uom/add_uom_screen.dart';
import 'package:pos_system/screens/uom/uom_screen.dart';
import 'package:provider/provider.dart';

import '../controllers/MenuAppController.dart';
import '../responsive.dart';
import '../screens/category/category_screen.dart';
import '../screens/customer/customer_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/items_registrations/add_items_screen.dart';
import '../screens/items_registrations/items_screen.dart';
import '../screens/saleman/add_salesman_screen.dart';
import '../screens/supplyman/add_supplyman_screen.dart';
import '../screens/vendorman/add_vendorman_screen.dart';
import '../screens/vendorman/vendorman_screen.dart';
import 'components/side_menu.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuAppController = Provider.of<MenuAppController>(context);
    Widget screen;
    switch(menuAppController.selectedIndex){
      case Routes.DASHBOARD_ROUTE:
        screen = DashboardScreen();
        break;
      case Routes.CATEGORY_ROUTE:
        screen = CategoryScreen();
        break;
      case Routes.ADD_CATEGORY_ROUTE:
        screen = AddCategoryScreen();
        break;
      case Routes.SALESMAN:
        screen = SalesManScreen();
        break;
      case Routes.ADD_SALESMAN:
        screen = AddSaleManScreen();
        break;
      case Routes.SUPPLYMAN:
        screen = SupplyManScreen();
        break;
      case Routes.ADD_SUPPLYMAN:
        screen = AddSupplyManScreen();
        break;
        case Routes.VENDOR:
        screen = VendorManScreen();
        break;
        case Routes.ADD_VENDOR:
        screen = AddVendorManScreen();
        break;
      case Routes.CUSTOMER:
        screen = CustomerScreen();
        break;
      case Routes.ADD_CUSTOMER:
        screen = AddCustomerScreen();
        break;
      case Routes.UOM:
        screen = UOMScreen();
        break;
      case Routes.ADD_UOM:
        screen = AddUOMScreen();
        break;

        case Routes.ITEMS_REGISTRATION:
        screen = ItemsScreen();
        break;

        case Routes.ADD_ITEMS_REGISTRATION:
        screen = AddItemsScreen();
        break;
      default:
        screen = DashboardScreen();
        break;
    }
    return Scaffold(
      extendBody: true,
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 2,
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: screen,
            ),
          ],
        ),
      ),
    );
  }
}

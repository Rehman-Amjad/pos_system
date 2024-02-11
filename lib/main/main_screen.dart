
import 'package:flutter/material.dart';
import 'package:pos_system/route/routes.dart';
import 'package:pos_system/screens/category/add_category_screen.dart';
import 'package:pos_system/screens/saleman/saleman_screen.dart';
import 'package:provider/provider.dart';

import '../controllers/MenuAppController.dart';
import '../responsive.dart';
import '../screens/category/category_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/saleman/add_salesman_screen.dart';
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
      default:
        screen = DashboardScreen();
        break;
    }
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
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

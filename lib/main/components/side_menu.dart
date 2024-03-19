import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_system/route/routes.dart';
import 'package:provider/provider.dart';

import '../../../controllers/MenuAppController.dart';
import '../../../helper/drawer_list_tile.dart';
import '../../../provider/text_color_provider.dart';
import '../../constants.dart';
import '../../helper/text_helper.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: drawerBackground,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              // child: Image.asset("assets/images/logo.png"),
              child: Center(
                  child: Text(
                "Waqas Hassan P.O.S",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            ),

            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper()
                  .mNormalText(text: "Main", color: Colors.blue, size: 14.0),
            ),
            const DrawerListTile(
              index: 0,
              screenIndex: Routes.DASHBOARD_ROUTE,
              title: "Dashboard",
              svgSrc: DASHBOARD_SVG,
              // press: () {
              //
              // },
            ),

            const Divider(
              thickness: 0.5,
            ),
            const SizedBox(
              height: defaultDrawerHeadHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper().mNormalText(
                  text: "Registration Form", color: Colors.blue, size: 14.0),
            ),
            const SizedBox(
              height: defaultDrawerHeadHeight - 5,
            ),
            const DrawerListTile(
              index: 1,
              screenIndex: Routes.CATEGORY_ROUTE,
              title: "Category",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 2,
              screenIndex: Routes.ITEMS_REGISTRATION,
              title: "Items Registration",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 3,
              screenIndex: Routes.UOM,
              title: "UOM Registration",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 4,
              screenIndex: Routes.SUPPLYMAN,
              title: "Supply Man",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 5,
              screenIndex: Routes.SALESMAN,
              title: "Sales Man",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 6,
              screenIndex: Routes.VENDOR,
              title: "Vendor",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 7,
              screenIndex: Routes.CUSTOMER,
              title: "Customer",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            //Purchase LIST
            const Divider(
              thickness: 0.5,
            ),
            const SizedBox(
              height: defaultDrawerHeadHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper().mNormalText(
                  text: "Purchase Forms", color: Colors.blue, size: 14.0),
            ),
            const SizedBox(
              height: defaultDrawerHeadHeight - 5,
            ),
            const DrawerListTile(
              index: 8,
              screenIndex: Routes.PURCHASE,
              title: "Purchase",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 9,
              screenIndex: 9,
              title: "P. History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            const DrawerListTile(
              index: 10,
              screenIndex: 10,
              title: "P. Returns",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            DrawerListTile(
              index: 11,
              screenIndex: 11,
              title: "P. Returns History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            //Sale LIST
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: defaultDrawerHeadHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper().mNormalText(
                  text: "Sales Forms", color: Colors.blue, size: 14.0),
            ),
            SizedBox(
              height: defaultDrawerHeadHeight - 5,
            ),
            DrawerListTile(
              index: 12,
              screenIndex: 12,
              title: "Sales",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            DrawerListTile(
              index: 13,
              screenIndex: 13,
              title: "Sale History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            DrawerListTile(
              index: 14,
              screenIndex: 14,
              title: "Sale Returns",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            DrawerListTile(
              index: 15,
              screenIndex: 15,
              title: "Sale Returns History",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            //Reports LIST
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: defaultDrawerHeadHeight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextHelper()
                  .mNormalText(text: "Reports", color: Colors.blue, size: 14.0),
            ),
            SizedBox(
              height: defaultDrawerHeadHeight - 5,
            ),
            DrawerListTile(
              index: 16,
              screenIndex: 16,
              title: "Stock",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            DrawerListTile(
              index: 17,
              screenIndex: 17,
              title: "Opening Stock",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            DrawerListTile(
              index: 18,
              screenIndex: 18,
              title: "Items List",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),

            DrawerListTile(
              index: 19,
              screenIndex: 19,
              title: "Low Stock",
              svgSrc: "assets/icons/menu_dashboard.svg",
            ),
          ],
        ),
      ),
      // child: ListView(
      //   children: [
      //     DrawerHeader(
      //      // child: Image.asset("assets/images/logo.png"),
      //       child: Center(child: Text("Waqas Hassan P.O.S")),
      //     ),
      //     DrawerListTile(
      //       title: "Dashboard",
      //       svgSrc: "assets/icons/menu_dashboard.svg",
      //       press: () {
      //         Provider.of<MenuAppController>(context, listen: false)
      //             .changeScreen(0);
      //         if(Responsive.isMobile(context)){
      //           Navigator.pop(context);
      //         }
      //       },
      //     ),
      //     DrawerListTile(
      //       title: "Transaction",
      //       svgSrc: "assets/icons/menu_tran.svg",
      //       press: () {
      //         Provider.of<MenuAppController>(context, listen: false)
      //             .changeScreen(1);
      //         if(Responsive.isMobile(context)){
      //           Navigator.pop(context);
      //         }
      //       },
      //     ),
      //     DrawerListTile(
      //       title: "Task",
      //       svgSrc: "assets/icons/menu_task.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Documents",
      //       svgSrc: "assets/icons/menu_doc.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Store",
      //       svgSrc: "assets/icons/menu_store.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Notification",
      //       svgSrc: "assets/icons/menu_notification.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Profile",
      //       svgSrc: "assets/icons/menu_profile.svg",
      //       press: () {},
      //     ),
      //     DrawerListTile(
      //       title: "Settings",
      //       svgSrc: "assets/icons/menu_setting.svg",
      //       press: () {},
      //     ),
      //   ],
      // ),
    );
  }
}

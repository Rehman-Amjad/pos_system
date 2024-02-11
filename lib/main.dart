
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_system/provider/count_value_provider.dart';
import 'package:pos_system/screens/saleman/provider/salesman_firebase_provider.dart';
import 'package:pos_system/provider/text_color_provider.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'controllers/MenuAppController.dart';
import 'firebase_options.dart';
import 'main/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
          ChangeNotifierProvider(
            create: (context) => TextColorProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CountValueProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SalesManDataProvider(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}

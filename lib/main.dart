import 'package:app_redes_sociais/examples/calendar/calendar_page.dart';
import 'package:app_redes_sociais/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/calendar_controller.dart';
import 'controllers/main_controller.dart';
import 'examples/carousel/carousel.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('pt_BR');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App Redes Sociais',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: BindingsBuilder((){
        Get.put(MainController());
        Get.put(CalendarController());
      }),
      home: CalendarPage(),
    );
  }
}

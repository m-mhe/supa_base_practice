import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:live_sync/controller_binder.dart';
import 'package:live_sync/data_base_practice/ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Live Sync",
      home: HomeScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}

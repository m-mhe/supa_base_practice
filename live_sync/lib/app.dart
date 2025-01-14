import 'package:flutter/material.dart';
import 'package:live_sync/data_base_practice/ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Live Sync",
      home: HomeScreen(),
    );
  }
}

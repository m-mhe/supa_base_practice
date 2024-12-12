import 'package:flutter/material.dart';
import 'package:live_sync/ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'LiveSync',
      home: HomeScreen(),
    );
  }
}

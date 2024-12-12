import 'package:flutter/material.dart';
import 'package:live_sync/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://fdjtiuqnwwtknbqowbwp.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZkanRpdXFud3d0a25icW93YndwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4MTI5MjAsImV4cCI6MjA0OTM4ODkyMH0.rvoH3CuFMSwsbSUrmeaTKKuwW1tM6dNMivB1VPxnHXc"
  );
  runApp(const MyApp());
}

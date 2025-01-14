import 'package:flutter/material.dart';
import 'package:live_sync/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://tvbwbcsljunuihmbfjaq.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR2YndiY3NsanVudWlobWJmamFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU4MjYzMzksImV4cCI6MjA1MTQwMjMzOX0.Af_5dSkTJHRAZool21zb0d2Ew628KIjki16P1xf_C5E');
  runApp(const MyApp());
}

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TextDataEditController extends GetxController{
  bool _loading = false;
  bool get  loading=> _loading;

  Future<void> editTextData({required String title, required String subtitle, required int id})async{
    _loading = true;
    update();
    await Supabase.instance.client.from('notes').update({'title': title, 'subtitle': subtitle}).eq('id', id);
    _loading = false;
    update();
  }
}